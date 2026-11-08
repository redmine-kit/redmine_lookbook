module Pages
  # Administration, rendered by Redmine's own controllers with Redmine's test data.
  class AdministrationPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Administration
    def index
      render_page("/admin", user: :admin)
    end

    # @label Projects (admin)
    def projects
      render_page("/admin/projects", user: :admin)
    end

    # @label Users
    def users
      render_page("/users", user: :admin)
    end

    # @label New user
    def new_user
      render_page("/users/new", user: :admin)
    end

    # @label Edit user
    def edit_user
      render_page("/users/2/edit", user: :admin)
    end

    # @label Groups
    def groups
      render_page("/groups", user: :admin)
    end

    # @label Edit group
    def edit_group
      render_page("/groups/10/edit", user: :admin)
    end

    # @label Roles and permissions
    def roles
      render_page("/roles", user: :admin)
    end

    # @label Edit role
    def edit_role
      render_page("/roles/1/edit", user: :admin)
    end

    # @label Permissions report
    def permissions
      render_page("/roles/permissions", user: :admin)
    end

    # @label Trackers
    def trackers
      render_page("/trackers", user: :admin)
    end

    # @label Edit tracker
    def edit_tracker
      render_page("/trackers/1/edit", user: :admin)
    end

    # @label Issue statuses
    def statuses
      render_page("/issue_statuses", user: :admin)
    end

    # @label Workflow
    def workflows
      render_page("/workflows/edit", user: :admin)
    end

    # @label Workflow: field permissions
    def workflow_permissions
      render_page("/workflows/permissions", user: :admin)
    end

    # @label Custom fields
    def custom_fields
      render_page("/custom_fields", user: :admin)
    end

    # @label New custom field
    def new_custom_field
      render_page("/custom_fields/new?type=IssueCustomField", user: :admin)
    end

    # @label Edit custom field
    def edit_custom_field
      render_page("/custom_fields/1/edit", user: :admin)
    end

    # @label Enumerations
    def enumerations
      render_page("/enumerations", user: :admin)
    end

    # @label LDAP authentication
    def auth_sources
      render_page("/auth_sources", user: :admin)
    end

    # @label Plugins
    def plugins
      render_page("/admin/plugins", user: :admin)
    end

    # @label Information
    def info
      render_page("/admin/info", user: :admin)
    end
  end
end
