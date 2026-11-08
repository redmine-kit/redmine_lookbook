module Pages
  # Administration settings, one preview per tab, rendered by Redmine's own controllers with Redmine's test data.
  class SettingsPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Settings: General
    def general
      render_page("/settings?tab=general", user: :admin)
    end

    # @label Settings: Display
    def display
      render_page("/settings?tab=display", user: :admin)
    end

    # @label Settings: Authentication
    def authentication
      render_page("/settings?tab=authentication", user: :admin)
    end

    # @label Settings: Integrations
    def integrations
      render_page("/settings?tab=integrations", user: :admin)
    end

    # @label Settings: Projects
    def projects
      render_page("/settings?tab=projects", user: :admin)
    end

    # @label Settings: Users
    def users
      render_page("/settings?tab=users", user: :admin)
    end

    # @label Settings: Issue tracking
    def issues
      render_page("/settings?tab=issues", user: :admin)
    end

    # @label Settings: Time tracking
    def timelog
      render_page("/settings?tab=timelog", user: :admin)
    end

    # @label Settings: Files
    def attachments
      render_page("/settings?tab=attachments", user: :admin)
    end

    # @label Settings: Email notifications
    def notifications
      render_page("/settings?tab=notifications", user: :admin)
    end

    # @label Settings: Incoming emails
    def mail_handler
      render_page("/settings?tab=mail_handler", user: :admin)
    end

    # @label Settings: Repositories
    def repositories
      render_page("/settings?tab=repositories", user: :admin)
    end
  end
end
