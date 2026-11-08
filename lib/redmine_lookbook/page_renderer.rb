require "nokogiri"
require "uri"

module RedmineLookbook
  # Renders a real Redmine page by sending an internal GET request through
  # the Rails application, then returns its HTML. With "component only", the
  # header, menus, sidebar and footer are removed and the stylesheets,
  # scripts and theme are kept.
  class PageRenderer
    REMOVED_IN_COMPONENT_ONLY = [
      "#top-menu", "#header", "#sidebar", "#sidebar-switch-panel",
      "#footer", ".flyout-menu", "#ajax-indicator"
    ].freeze

    def initialize(controller)
      @controller = controller
      @request = controller.request
      @params = controller.params
    end

    # The header that tells bin/check-previews that a page preview got
    # another HTTP status than it expects (for example an error page).
    STATUS_HEADER = "X-Redmine-Lookbook-Unexpected-Status".freeze

    # user: :admin (the first active administrator), :anonymous, or a login.
    # settings: Redmine settings for this request (see SettingsOverride).
    # status: the HTTP status the page is expected to return.
    def render(path, user: :admin, settings: {}, status: 200)
      got, html = SettingsOverride.with(settings) { fetch(path, user) }
      @controller.response.headers[STATUS_HEADER] = "#{got} #{path}" if got != status
      Display.component_only?(@params) ? strip_layout(html) : html
    end

    # The HTML of a part of a page that Redmine loads with JavaScript (for
    # example the context menu), as the given user, for component previews.
    def fragment(path, user: :admin)
      _status, html = fetch(path, user)
      html.html_safe
    end

    private

    MAX_REDIRECTS = 3

    # Returns the final status and HTML, following redirects on this host.
    def fetch(path, user, redirects = 0)
      status, headers, html = request(path, user)
      location = headers["location"] || headers["Location"]
      if status.between?(300, 399) && location && redirects < MAX_REDIRECTS
        uri = URI.parse(location)
        return fetch(uri.request_uri, user, redirects + 1) if uri.host.nil? || uri.host == @request.host
      end
      [status, html]
    end

    def request(path, user)
      env = Rack::MockRequest.env_for(
        path,
        "HTTP_HOST" => @request.host_with_port,
        "rack.url_scheme" => @request.scheme,
        "REMOTE_ADDR" => @request.remote_ip,
        "HTTP_ACCEPT" => "text/html"
      )
      env[ApplicationControllerPatch::ENV_USER] = user_id(user)
      env[ApplicationControllerPatch::ENV_THEME] = Display.theme_id(@params)
      env[ApplicationControllerPatch::ENV_LOCALE] = Display.locale(@params)

      with_preserved_state do
        status, headers, body = ReloadGuard.internal_request { Rails.application.call(env) }
        [status, headers, read(body)]
      end
    end

    def user_id(user)
      case user
      when :anonymous then :anonymous
      when :admin then User.active.where(admin: true).order(:id).first&.id
      else User.find_by_login(user.to_s)&.id
      end
    end

    # Redmine keeps the current user and language per thread; the internal
    # request must not change them for the preview that is rendering.
    def with_preserved_state
      user = User.current
      locale = ::I18n.locale
      yield
    ensure
      User.current = user
      ::I18n.locale = locale
    end

    def read(body)
      html = +""
      body.each { |chunk| html << chunk }
      html
    ensure
      body.close if body.respond_to?(:close)
    end

    def strip_layout(html)
      doc = Nokogiri::HTML5(html)
      REMOVED_IN_COMPONENT_ONLY.each { |selector| doc.css(selector).each(&:remove) }
      doc.css("#main").each { |main| main["class"] = "nosidebar" }
      doc.to_html
    end
  end
end
