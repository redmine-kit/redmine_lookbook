module Pages
  # Wiki, news, documents, files and forums, rendered by Redmine's own controllers with Redmine's test data.
  class ContentPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Wiki page
    def wiki
      render_page("/projects/ecookbook/wiki", user: :admin)
    end

    # @label Wiki page with sections
    def wiki_sections
      render_page("/projects/ecookbook/wiki/Page_with_sections", user: :admin)
    end

    # @label Wiki page with an inline image
    def wiki_image
      render_page("/projects/ecookbook/wiki/Page_with_an_inline_image", user: :admin)
    end

    # @label Wiki edit
    def wiki_edit
      render_page("/projects/ecookbook/wiki/CookBook_documentation/edit", user: :admin)
    end

    # @label Wiki history
    def wiki_history
      render_page("/projects/ecookbook/wiki/CookBook_documentation/history", user: :admin)
    end

    # @label Wiki diff
    def wiki_diff
      render_page("/projects/ecookbook/wiki/CookBook_documentation/2/diff", user: :admin)
    end

    # @label Wiki annotate
    def wiki_annotate
      render_page("/projects/ecookbook/wiki/CookBook_documentation/2/annotate", user: :admin)
    end

    # @label Wiki rename
    def wiki_rename
      render_page("/projects/ecookbook/wiki/Another_page/rename", user: :admin)
    end

    # @label Wiki index
    def wiki_index
      render_page("/projects/ecookbook/wiki/index", user: :admin)
    end

    # @label Wiki index by date
    def wiki_date_index
      render_page("/projects/ecookbook/wiki/date_index", user: :admin)
    end

    # @label News
    def news_list
      render_page("/projects/ecookbook/news", user: :admin)
    end

    # @label News item
    def news
      render_page("/news/1", user: :admin)
    end

    # @label New news
    def new_news
      render_page("/projects/ecookbook/news/new", user: :admin)
    end

    # @label Documents
    def documents
      render_page("/projects/ecookbook/documents", user: :admin)
    end

    # @label Document
    def document
      render_page("/documents/1", user: :admin)
    end

    # @label New document
    def new_document
      render_page("/projects/ecookbook/documents/new", user: :admin)
    end

    # @label Files
    def files
      render_page("/projects/ecookbook/files", user: :admin)
    end

    # @label New file
    def new_file
      render_page("/projects/ecookbook/files/new", user: :admin)
    end

    # @label Forums
    def forums
      render_page("/projects/ecookbook/boards", user: :admin)
    end

    # @label Forum
    def forum
      render_page("/projects/ecookbook/boards/1", user: :admin)
    end

    # @label Forum topic
    def topic
      render_page("/boards/1/topics/1", user: :admin)
    end

    # @label New forum topic
    def new_topic
      render_page("/boards/1/topics/new", user: :admin)
    end
  end
end
