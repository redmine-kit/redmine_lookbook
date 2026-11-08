module Pages
  # Issues and spent time, rendered by Redmine's own controllers with Redmine's test data.
  class IssuesPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Issues
    def index
      render_page(user: :admin) { project_path("/issues") }
    end

    # @label Issue
    def show
      render_page(user: :admin) { "/issues/#{RedmineLookbook::TestData.issue&.id}" if RedmineLookbook::TestData.issue }
    end

    # @label New issue
    def new
      render_page(user: :admin) { project_path("/issues/new") }
    end

    # @label Gantt chart
    def gantt
      render_page(user: :admin) { project_path("/issues/gantt") }
    end

    # @label Calendar
    def calendar
      render_page(user: :admin) { project_path("/issues/calendar") }
    end

    # @label Issue summary
    def report
      render_page(user: :admin) { project_path("/issues/report") }
    end

    # @label Spent time
    def spent_time
      render_page(user: :admin) { project_path("/time_entries") }
    end

    # @label Log time
    def log_time
      render_page(user: :admin) { project_path("/time_entries/new") }
    end

    private

    def project_path(suffix)
      project = RedmineLookbook::TestData.project
      "/projects/#{project.identifier}#{suffix}" if project
    end
  end
end
