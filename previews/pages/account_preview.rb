module Pages
  # Account and personal pages, rendered by Redmine's own controllers with Redmine's test data.
  class AccountPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Sign in
    def login
      render_page("/login", user: :anonymous)
    end

    # @label Lost password
    def lost_password
      render_page("/account/lost_password", user: :anonymous)
    end

    # @label Register
    def register
      render_page("/account/register", user: :anonymous)
    end

    # @label My page
    def my_page
      render_page("/my/page", user: :admin)
    end

    # @label My account
    def my_account
      render_page("/my/account", user: :admin)
    end

    # @label Change password
    def my_password
      render_page("/my/password", user: "jsmith")
    end

    # @label User profile
    def user
      render_page("/users/2", user: :admin)
    end

    # @label Confirm password (sudo mode)
    def api_key
      render_page("/my/api_key", user: :admin)
    end

    # @label Sign in without registration
    def login_without_register
      render_page("/login", user: :anonymous, settings: { self_registration: "0" })
    end

    # @label User profile of another user
    def other_user
      render_page("/users/3", user: "jsmith")
    end
  end
end
