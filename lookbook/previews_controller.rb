# Loaded by RedmineLookbook.setup only when the plugin is enabled. It is kept
# outside the autoloaded directories, because it needs the Lookbook gem,
# which is not installed on production servers.
module RedmineLookbook
  # Renders Lookbook previews inside Redmine, so Redmine's helpers, layouts
  # and theme handling are available. The private layout and view path
  # methods mirror Lookbook::PreviewController (lookbook 2.3).
  class PreviewsController < ::ApplicationController
    include Lookbook::PreviewControllerActions

    # The helpers of Redmine's IssuesController, plus the few that other
    # component previews need. "helper :all" is not
    # used: ProjectsQueriesHelper and UserQueriesHelper redefine the methods
    # of QueriesHelper, and the issue list would render empty cells.
    helper :issues, :journals, :projects, :custom_fields, :issue_relations, :watchers,
           :attachments, :queries, :repositories, :timelog, :versions, :activities

    # Lookbook renders previews through these methods (with
    # controller.process), so the display options are applied around them.
    module DisplayOptions
      def render_scenario_to_string(*args, **kwargs)
        return render_server_switch(other_server_url) if other_server_url

        with_display_options { super }
      end

      def render_in_layout_to_string(*args, **kwargs)
        with_display_options { super }
      end
    end
    prepend DisplayOptions

    # Previews do not depend on the browser's Redmine session: they render as
    # an administrator even when Redmine requires a sign-in, a password
    # change or two-factor authentication, or when the session has expired.
    skip_before_action :check_if_login_required, :check_password_change, :check_twofa_activation,
                       :session_expiration, raise: false

    private

    # Components render as an administrator, so links and buttons that need
    # permissions are shown. Page previews choose their own user.
    def with_display_options(&block)
      user = User.current
      User.current = RedmineLookbook.first_admin || user
      theme = Display.theme_id(params)
      ::I18n.with_locale(Display.locale(params) || ::I18n.default_locale) do
        theme ? SettingsOverride.with(ui_theme: theme, &block) : yield
      end
    ensure
      User.current = user
    end

    # The URL of the server chosen in the toolbar, only when it is one of
    # REDMINE_LOOKBOOK_SERVERS and not this server. Lookbook keeps display
    # values in a cookie without checking them against the choices.
    def other_server_url
      url = Display.value(params, :server)
      url if url && url != request.base_url && Display.servers.any? { |_label, server| server == url }
    end

    # Opens the same preview on the other server, in the preview pane. An HTTP
    # redirect would move the whole Lookbook screen, and Lookbook expects
    # HTML from this method.
    def render_server_switch(server)
      url = "#{server}#{request.fullpath}"
      render html: <<~HTML.html_safe # rubocop:disable Rails/OutputSafety -- the URL is escaped
        <!DOCTYPE html>
        <html><body>
        <p>Opening this preview on <a href="#{ERB::Util.html_escape(url)}">#{ERB::Util.html_escape(server)}</a>.</p>
        <script>location.replace(#{url.to_json});</script>
        </body></html>
      HTML
    end

    def set_locale(&block)
      I18n.with_locale(params[:locale] || I18n.default_locale, &block)
    end

    def determine_layout(layout_override = nil, prepend_views: true)
      declaration = {}
      if !layout_override.nil?
        declaration[:layout] = layout_override
      else
        declaration[:layout] = Display.component_only?(params) ? "redmine_lookbook/component" : "base"
      end
      prepend_application_view_paths if declaration[:layout].present? && prepend_views
      declaration
    end

    def prepend_application_view_paths
      prepend_view_path Rails.root.join("app/views")
    end

    def prepend_preview_scenarios_view_path
      prepend_view_path(Lookbook::Engine.preview_paths)
    end
    alias_method :prepend_preview_examples_view_path, :prepend_preview_scenarios_view_path
  end
end
