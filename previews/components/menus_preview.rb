module Components
  # Menus and dropdowns of Redmine, in their open states. A short script opens
  # them in the same way as a click does. They render directly in #wrapper, as
  # in Redmine, so the "Layout" toolbar option does not apply to them.
  class MenusPreview < Lookbook::Preview
    layout "redmine_lookbook/bare"

    # @label Jump to a project, open
    def project_jump
      render_with_template
    end

    # @label New object menu ("+") in the project menu, open
    def new_object
      render_with_template
    end

    # @label Actions menu ("..."), open
    def actions
      render_with_template
    end

    # @label Context menu of the issue list, open
    def context_menu
      render_with_template
    end

    # @label Account menu, open
    def account
      render_with_template(template: "components/layout_preview/top_menu", locals: { open: true })
    end

    # @label Tabs with scroll buttons
    def many_tabs
      render_with_template
    end
  end
end
