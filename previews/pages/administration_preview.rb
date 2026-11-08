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

    # @label Webhooks
    def webhooks
      render_page("/admin/webhooks", user: :admin, settings: { webhooks_enabled: true })
    end

    # @label New webhook
    def new_webhook
      render_page("/webhooks/new", user: :admin, settings: { webhooks_enabled: true })
    end

    # @label Users: locked
    def locked_users
      render_page("/users?set_filter=1&f[]=status&op[status]=%3D&v[status][]=3", user: :admin)
    end

    # @label Edit user: projects
    def user_memberships
      render_page("/users/2/edit?tab=memberships", user: :admin)
    end

    # @label Edit user: groups
    def user_groups
      render_page("/users/2/edit?tab=groups", user: :admin)
    end

    # @label User email addresses
    def user_email_addresses
      render_page("/users/2/email_addresses", user: :admin)
    end

    # @label Add projects to a user
    def user_add_projects
      render_page("/users/2/memberships/new", user: :admin)
    end

    # @label Import users
    def import_users
      render_page("/users/imports/new", user: :admin)
    end

    # @label Group
    def group
      render_page("/groups/10", user: :admin)
    end

    # @label New group
    def new_group
      render_page("/groups/new", user: :admin)
    end

    # @label Edit group: users
    def group_users
      render_page("/groups/10/edit?tab=users", user: :admin)
    end

    # @label Edit group: projects
    def group_memberships
      render_page("/groups/10/edit?tab=memberships", user: :admin)
    end

    # @label New role
    def new_role
      render_page("/roles/new", user: :admin)
    end

    # @label New tracker
    def new_tracker
      render_page("/trackers/new", user: :admin)
    end

    # @label New issue status
    def new_status
      render_page("/issue_statuses/new", user: :admin)
    end

    # @label Edit issue status
    def edit_status
      render_page("/issue_statuses/1/edit", user: :admin)
    end

    # @label Workflow summary
    def workflow_summary
      render_page("/workflows", user: :admin)
    end

    # @label Copy workflow
    def workflow_copy
      render_page("/workflows/copy", user: :admin)
    end

    # @label New custom field: choose the type
    def custom_field_types
      render_page("/custom_fields/new", user: :admin)
    end

    # @label New enumeration value
    def new_enumeration
      render_page("/enumerations/new?type=IssuePriority", user: :admin)
    end

    # @label Edit enumeration value
    def edit_enumeration
      render_page("/enumerations/4/edit", user: :admin)
    end

    # @label New LDAP authentication
    def new_auth_source
      render_page("/auth_sources/new", user: :admin)
    end

    # @label Edit LDAP authentication
    def edit_auth_source
      render_page("/auth_sources/1/edit", user: :admin)
    end
  end
end
