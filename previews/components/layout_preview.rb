module Components
  # Parts of Redmine's layout (app/views/layouts/base.html.erb), with the same
  # helpers and markup. They render directly in #wrapper, as in Redmine, so
  # the "Layout" toolbar option does not apply to them.
  class LayoutPreview < Lookbook::Preview
    layout "redmine_lookbook/bare"

    # @label Whole layout
    def whole
      render_with_template(template: "components/layout_preview/whole", locals: { variant: :project })
    end

    # @label Whole layout without a project
    def whole_without_project
      render_with_template(template: "components/layout_preview/whole", locals: { variant: :global })
    end

    # @label Whole layout, signed out
    def whole_signed_out
      render_with_template(template: "components/layout_preview/whole", locals: { variant: :anonymous })
    end

    # @label Whole layout with the sidebar hidden
    def whole_sidebar_hidden
      render_with_template(template: "components/layout_preview/whole", locals: { variant: :sidebar_hidden })
    end

    # @label Whole layout with the flyout menu open (narrow screens)
    def whole_flyout_open
      render_with_template(template: "components/layout_preview/whole", locals: { variant: :flyout })
    end

    # @label Whole layout of a closed project
    def whole_closed_project
      render_with_template(template: "components/layout_preview/whole", locals: { variant: :closed })
    end

    # @label Top menu
    def top_menu
      render_with_template(locals: { open: false })
    end

    # @label Top menu with the account menu open
    def account_menu
      render_with_template(template: "components/layout_preview/top_menu", locals: { open: true })
    end

    # @label Top menu, signed out
    def top_menu_signed_out
      render_with_template
    end

    # @label Header with the project menu
    def header
      render_with_template
    end

    # @label Sidebar
    def sidebar
      render_with_template
    end

    # @label Footer
    def footer
      render_with_template
    end
  end
end
