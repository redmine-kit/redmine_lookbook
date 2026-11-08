module Pages
  # Issues and spent time, rendered by Redmine's own controllers with Redmine's test data.
  class IssuesPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Issues
    def index
      render_page("/projects/ecookbook/issues", user: :admin)
    end

    # @label Issues grouped, with totals
    def grouped
      render_page("/projects/ecookbook/issues?set_filter=1&f%5B%5D=&group_by=status&t%5B%5D=estimated_hours&t%5B%5D=spent_hours&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=estimated_hours&c%5B%5D=spent_hours", user: :admin)
    end

    # @label Issues of all projects
    def all
      render_page("/issues", user: :admin)
    end

    # @label Issue
    def show
      render_page("/issues/1", user: :admin)
    end

    # @label Issue with related issues
    def show_related
      render_page("/issues/2", user: :admin)
    end

    # @label Closed issue
    def show_closed
      render_page("/issues/8", user: :admin)
    end

    # @label Private issue
    def show_private
      render_page("/issues/14", user: :admin)
    end

    # @label New issue
    def new
      render_page("/projects/ecookbook/issues/new", user: :admin)
    end

    # @label Edit issue
    def edit
      render_page("/issues/1/edit", user: :admin)
    end

    # @label Copy issue
    def copy
      render_page("/projects/ecookbook/issues/1/copy", user: :admin)
    end

    # @label Bulk edit
    def bulk_edit
      render_page("/issues/bulk_edit?ids%5B%5D=1&ids%5B%5D=2", user: :admin)
    end

    # @label Context menu
    def context_menu
      render_page("/issues/context_menu?ids%5B%5D=1&ids%5B%5D=2", user: :admin)
    end

    # @label New query
    def new_query
      render_page("/projects/ecookbook/queries/new", user: :admin)
    end

    # @label Import issues
    def import
      render_page("/projects/ecookbook/issues/imports/new", user: :admin)
    end

    # @label Gantt chart
    def gantt
      render_page("/projects/ecookbook/issues/gantt", user: :admin)
    end

    # @label Calendar
    def calendar
      render_page("/projects/ecookbook/issues/calendar", user: :admin)
    end

    # @label Issue summary
    def report
      render_page("/projects/ecookbook/issues/report", user: :admin)
    end

    # @label Spent time
    def spent_time
      render_page("/projects/ecookbook/time_entries", user: :admin)
    end

    # @label Spent time report
    def time_report
      render_page("/projects/ecookbook/time_entries/report?columns=month&criteria%5B%5D=user", user: :admin)
    end

    # @label Log time
    def log_time
      render_page("/projects/ecookbook/time_entries/new", user: :admin)
    end

    # @label Edit spent time
    def edit_time
      render_page("/time_entries/1/edit", user: :admin)
    end
  end
end
