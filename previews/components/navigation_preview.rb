module Components
  # Navigation parts rendered with Redmine's helpers.
  class NavigationPreview < Lookbook::Preview
    # @label Tabs
    def tabs
      render_with_template
    end

    # @label Project menu
    def main_menu
      render_with_template
    end

    # @label Top menu and account menu
    def top_menu
      render_with_template
    end

    # @label Administration menu
    def admin_menu
      render_with_template
    end

    # @label Title with breadcrumbs
    def breadcrumbs
      render_with_template
    end

    # @label Issue sidebar
    def sidebar
      render_with_template
    end
  end
end
