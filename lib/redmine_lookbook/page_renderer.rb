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
    # sudo: false shows the password form of Redmine's sudo mode where a page
    # asks for it; true (the default) counts the password as confirmed.
    def render(path, user: :admin, settings: {}, status: 200, sudo: true)
      @sudo = sudo
      got, html = SettingsOverride.with(settings) { fetch(path, user) }
      @controller.response.headers[STATUS_HEADER] = "#{got} #{path}" if got != status
      Display.component_only?(@params) ? strip_layout(html) : html
    end

    # The HTML of a part of a page that Redmine loads with JavaScript (for
    # example the context menu), as the given user, for component previews.
    def fragment(path, user: :admin)
      @sudo = true
      status, html = fetch(path, user)
      @controller.response.headers[STATUS_HEADER] = "#{status} #{path}" if status != 200
      html.html_safe # rubocop:disable Rails/OutputSafety -- Redmine's own HTML
    end

    private

    MAX_REDIRECTS = 3

    # Returns the final status and HTML, following redirects on this server.
    def fetch(path, user, redirects = 0)
      status, headers, html = request(path, user)
      location = headers["location"] || headers["Location"]
      if status.between?(300, 399) && location && redirects < MAX_REDIRECTS
        target = same_server_path(location)
        return fetch(target, user, redirects + 1) if target
      end
      [status, html]
    end

    # The path and query of a redirect's location when it is on this server
    # (the same scheme, host and port), or nil.
    def same_server_path(location)
      uri = URI.join(@request.base_url + "/", encode(location))
      return unless uri.scheme == @request.scheme && uri.host == @request.host && uri.port == @request.port

      uri.request_uri
    rescue URI::Error
      nil
    end

    # Percent-encodes characters outside ASCII, such as wiki page titles in
    # Japanese, and leaves the rest of the path as it is.
    def encode(path)
      path.to_s.gsub(/[^\x00-\x7F]+/) { |text| URI.encode_www_form_component(text).gsub("+", "%20") }
    end

    def request(path, user)
      env = Rack::MockRequest.env_for(
        encode(path),
        "HTTP_HOST" => @request.host_with_port,
        "rack.url_scheme" => @request.scheme,
        "REMOTE_ADDR" => @request.remote_ip,
        "HTTP_ACCEPT" => "text/html"
      )
      env[ApplicationControllerPatch::ENV_USER] = user_id(user)
      env[ApplicationControllerPatch::ENV_LOCALE] = Display.locale(@params)
      env[ApplicationControllerPatch::ENV_SUDO] = @sudo

      with_preserved_state do
        status, headers, body = ReloadGuard.internal_request { Rails.application.call(env) }
        [status, headers, read(body)]
      end
    end

    # A user that is not found raises an error, so that a mistyped login is
    # not rendered as an anonymous user.
    def user_id(user)
      found = case user
              when :anonymous then return :anonymous
              when :admin then RedmineLookbook.first_admin
              else User.active.find_by(login: user.to_s)
              end
      found&.id or raise ArgumentError, "No active user #{user.inspect} for a page preview."
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
