# Loaded by RedmineLookbook.setup only when the previews are enabled, because
# it uses ViewComponent, which Lookbook installs. It is kept out of the
# autoloaded directories for the same reason as the preview controller.
module RedmineLookbook
  # Renders a Redmine page for RedmineLookbook::PagePreview#render_page.
  # Page previews return this component instead of rendering a template, so
  # Lookbook's Source panel shows the preview method with the page's path.
  class PageComponent < ViewComponent::Base
    MISSING_TEST_DATA = <<~HTML.freeze
      <!DOCTYPE html>
      <html><body><p>Load Redmine's test data first: <code>bin/rails redmine_lookbook:load_test_data</code></p></body></html>
    HTML

    def initialize(path:, user:, settings:, status:)
      super()
      @path = path
      @user = user
      @settings = settings
      @status = status
    end

    def call
      path = @path.respond_to?(:call) ? @path.call : @path
      html = path ? PageRenderer.new(controller).render(path, user: @user, settings: @settings, status: @status) : MISSING_TEST_DATA
      html.html_safe # rubocop:disable Rails/OutputSafety -- Redmine's own HTML
    end
  end
end
