module Pages
  # Error pages, rendered by Redmine's own controllers with Redmine's test data.
  class ErrorsPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Not found (404)
    def not_found
      render_page("/issues/0", user: :admin)
    end

    # @label Forbidden (403)
    def forbidden
      render_page("/admin", user: "dlopper")
    end
  end
end
