module Pages
  # Error pages, rendered by Redmine's own controllers with Redmine's test data.
  class ErrorsPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Not found (404)
    def not_found
      render_page("/issues/0", user: :admin, status: 404)
    end

    # @label Forbidden (403)
    def forbidden
      render_page("/admin", user: "dlopper", status: 403)
    end

    # @label Sign-in required
    def sign_in_required
      render_page("/projects/private-child", user: :anonymous)
    end
  end
end
