module Pages
  # Wiki, news, documents, files and forums, rendered by Redmine's own controllers with Redmine's test data.
  class ContentPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Wiki page
    def wiki
      render_page(user: :admin) { project_path("/wiki") }
    end

    # @label Wiki edit
    def wiki_edit
      render_page(user: :admin) { wiki_page_path("/edit") }
    end

    # @label Wiki index
    def wiki_index
      render_page(user: :admin) { project_path("/wiki/index") }
    end

    # @label Wiki history
    def wiki_history
      render_page(user: :admin) { wiki_page_path("/history") }
    end

    # @label News
    def news_list
      render_page(user: :admin) { project_path("/news") }
    end

    # @label News item
    def news
      render_page(user: :admin) { "/news/#{RedmineLookbook::TestData.news&.id}" if RedmineLookbook::TestData.news }
    end

    # @label Documents
    def documents
      render_page(user: :admin) { project_path("/documents") }
    end

    # @label Document
    def document
      render_page(user: :admin) { "/documents/#{RedmineLookbook::TestData.document&.id}" if RedmineLookbook::TestData.document }
    end

    # @label Files
    def files
      render_page(user: :admin) { project_path("/files") }
    end

    # @label Forums
    def forums
      render_page(user: :admin) { project_path("/boards") }
    end

    # @label Forum
    def forum
      render_page(user: :admin) { project_path("/boards/#{RedmineLookbook::TestData.board&.id}") if RedmineLookbook::TestData.board }
    end

    # @label Forum topic
    def topic
      render_page(user: :admin) { "/boards/#{RedmineLookbook::TestData.board&.id}/topics/#{RedmineLookbook::TestData.topic&.id}" if RedmineLookbook::TestData.topic }
    end

    private

    def wiki_page_path(suffix)
      page = RedmineLookbook::TestData.wiki_page
      project_path("/wiki/#{page.title}#{suffix}") if page
    end

    def project_path(suffix)
      project = RedmineLookbook::TestData.project
      "/projects/#{project.identifier}#{suffix}" if project
    end
  end
end
