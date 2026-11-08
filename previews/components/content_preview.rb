module Components
  # Content parts rendered with Redmine's own partials and Redmine's test data.
  class ContentPreview < Lookbook::Preview
    # @label Wiki formatting
    # @param format select { choices: [common_mark, textile] }
    def wiki(format: "common_mark")
      render_with_template(locals: { format: format })
    end

    # @label Calendar
    def calendar
      render_with_template
    end

    # @label Diff
    # @param style select { choices: [inline, sbs] }
    def diff(style: "inline")
      render_with_template(locals: { style: style })
    end

    # @label Version overview
    def version
      render_with_template
    end

    # @label News
    def news
      render_with_template
    end
  end
end
