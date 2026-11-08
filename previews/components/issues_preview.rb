module Components
  # Issue parts rendered with Redmine's own partials and Redmine's test data.
  class IssuesPreview < Lookbook::Preview
    # @label Issue list
    def list
      render_with_template
    end
  end
end
