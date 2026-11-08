module Components
  # Common building blocks of the Redmine UI, rendered with Redmine's helpers.
  class BasicsPreview < Lookbook::Preview
    # @label Flash messages
    # @param kind select { choices: [notice, error, warning] }
    # @param message text
    def flash(kind: "notice", message: "Successful update.")
      render_with_template(locals: { kind: kind, message: message })
    end

    # @label Icons (SVG sprite)
    def icons
      render_with_template
    end

    # @label Buttons and form fields
    def form
      render_with_template
    end

    # @label Progress bar
    # @param closed number
    # @param done number
    def progress(closed: 30, done: 60)
      render_with_template(locals: { closed: closed.to_i, done: done.to_i })
    end

    # @label Pagination
    # @param page number
    def pagination(page: 3)
      render_with_template(locals: { page: page.to_i })
    end

    # @label Wiki formatting
    def wiki
      render_with_template
    end
  end
end
