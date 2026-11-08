module RedmineLookbook
  # Mix into a Lookbook preview class to preview whole Redmine pages.
  #
  #   class Pages::IssuesPreview < Lookbook::Preview
  #     include RedmineLookbook::PagePreview
  #
  #     def index
  #       render_page { "/projects/#{TestData.project.identifier}/issues" }
  #     end
  #   end
  module PagePreview
    def self.included(base)
      base.layout false
    end

    # The path can be given as a string, or as a block that runs when the
    # preview renders (so it can look up the test data).
    #
    # user: :admin (the default), :anonymous or a login.
    # settings: Redmine settings for this page only, e.g. { webhooks_enabled: true }.
    # status: the HTTP status the page returns (200 unless it is an error page).
    def render_page(path = nil, user: :admin, settings: {}, status: 200, &block)
      render_with_template(
        template: "redmine_lookbook/page",
        locals: { path: path, path_block: block, user: user, settings: settings, status: status }
      )
    end
  end
end
