module Components
  # Form parts rendered with Redmine's form helpers and partials.
  class FormsPreview < Lookbook::Preview
    # @label Form fields
    def fields
      render_with_template
    end

    # @label Error messages
    def errors
      render_with_template
    end

    # @label Text area with the wiki toolbar
    def wiki_toolbar
      render_with_template
    end

    # @label Issue filters
    def filters
      render_with_template
    end
  end
end
