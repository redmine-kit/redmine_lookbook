# Loaded by RedmineLookbook.setup only when the plugin is enabled. It is kept
# outside the autoloaded directories, because it needs the Lookbook gem,
# which is not installed on production servers.
module RedmineLookbook
  # Renders Lookbook previews inside Redmine, so Redmine's helpers, layouts
  # and theme handling are available. The private layout and view path
  # methods mirror Lookbook::PreviewController (lookbook 2.3).
  class PreviewsController < ::ApplicationController
    include Lookbook::PreviewControllerActions

    # The same helpers as Redmine's IssuesController. "helper :all" is not
    # used: ProjectsQueriesHelper and UserQueriesHelper redefine the methods
    # of QueriesHelper, and the issue list would render empty cells.
    helper :issues, :journals, :projects, :custom_fields, :issue_relations, :watchers,
           :attachments, :queries, :repositories, :timelog, :versions

    # Lookbook calls the render methods directly, without action callbacks,
    # so the display options are applied right before rendering.
    module DisplayOptions
      def render_scenario_to_string(*args, **kwargs)
        return redirect_to_server if other_server_url

        with_display_options { super }
      end

      def render_in_layout_to_string(*args, **kwargs)
        with_display_options { super }
      end
    end
    prepend DisplayOptions

    private

    # Components render as an administrator, so links and buttons that need
    # permissions are shown. Page previews choose their own user.
    def with_display_options
      @current_theme = Display.theme(params)
      user = User.current
      User.current = User.active.where(admin: true).order(:id).first || user
      ::I18n.with_locale(Display.locale(params) || ::I18n.default_locale) { yield }
    ensure
      User.current = user
    end

    def other_server_url
      url = Display.value(params, :server)
      url if url && url != request.base_url
    end

    def redirect_to_server
      redirect_to "#{other_server_url}#{request.fullpath}", allow_other_host: true
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
