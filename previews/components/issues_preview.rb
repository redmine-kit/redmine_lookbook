module Components
  # Issue parts rendered with Redmine's own partials and Redmine's test data.
  class IssuesPreview < Lookbook::Preview
    # @label Issue list
    def list
      render_with_template
    end

    # @label History
    def history
      render_with_template
    end

    # @label Attachments
    def attachments
      render_with_template
    end

    # @label Watchers
    def watchers
      render_with_template
    end

    # @label Related issues
    def relations
      render_with_template
    end

    # @label Custom fields
    def custom_fields
      render_with_template
    end

    # @label Issue tooltip
    def tooltip
      render_with_template
    end

    # @label Subtasks
    def subtasks
      render_with_template
    end
  end
end
