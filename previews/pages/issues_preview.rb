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
      render_page("/issues/imports/new?project_id=ecookbook", user: :admin)
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

    # @label New issue: another tracker
    def new_feature
      render_page("/projects/ecookbook/issues/new?issue%5Btracker_id%5D=2", user: :admin)
    end

    # @label Issue with associated revisions
    def show_revisions
      render_page("/issues/3", user: :admin)
    end

    # @label Issue of another project
    def show_other_project
      render_page("/issues/4", user: :admin)
    end

    # @label Issue as a member
    def show_member
      render_page("/issues/1", user: "jsmith")
    end

    # @label Issue, signed out
    def show_anonymous
      render_page("/issues/1", user: :anonymous)
    end

    # @label Description diff
    def description_diff
      render_page("/journals/3/diff?detail_id=4", user: :admin)
    end

    # @label Saved query
    def saved_query
      render_page("/projects/ecookbook/issues?query_id=1", user: :admin)
    end

    # @label Issues grouped by a custom field
    def grouped_custom_field
      render_page("/issues?query_id=9", user: :admin)
    end

    # @label Issues with description and last notes
    def with_description
      render_page("/issues?set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=subject&c%5B%5D=description&c%5B%5D=last_notes", user: :admin)
    end

    # @label Issues: nothing found
    def no_issues
      render_page("/projects/ecookbook/issues?set_filter=1&f%5B%5D=subject&op%5Bsubject%5D=~&v%5Bsubject%5D%5B%5D=zzzz", user: :admin)
    end

    # @label Issue summary details
    def report_details
      render_page("/projects/ecookbook/issues/report/tracker", user: :admin)
    end

    # @label Edit query
    def edit_query
      render_page("/queries/1/edit", user: :admin)
    end

    # @label New spent time query
    def new_time_query
      render_page("/queries/new?type=TimeEntryQuery", user: :admin)
    end

    # @label New project query
    def new_project_query
      render_page("/queries/new?type=ProjectQuery", user: :admin)
    end

    # @label New user query
    def new_user_query
      render_page("/queries/new?type=UserQuery", user: :admin)
    end

    # @label Bulk edit spent time
    def time_bulk_edit
      render_page("/time_entries/bulk_edit?ids%5B%5D=1&ids%5B%5D=2", user: :admin)
    end

    # @label Spent time report by project and user
    def time_report_projects
      render_page("/time_entries/report?columns=month&criteria%5B%5D=project&criteria%5B%5D=user", user: :admin)
    end

    # @label Import spent time
    def import_time
      render_page("/time_entries/imports/new?project_id=ecookbook", user: :admin)
    end

    # @label Edit attachments
    def edit_attachments
      render_page("/attachments/issues/3/edit", user: :admin)
    end
  end
end
