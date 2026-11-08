module Components
  # Navigation parts rendered with Redmine's helpers.
  class NavigationPreview < Lookbook::Preview
    # @label Tabs
    def tabs
      render_with_template
    end
  end
end
