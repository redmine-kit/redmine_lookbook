module Pages
  # Redmine's help pages for wiki formatting.
  class HelpPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Wiki syntax quick reference
    def wiki_syntax
      render_page("/help/wiki_syntax", user: :admin)
    end

    # @label Wiki syntax, detailed
    def wiki_syntax_detailed
      render_page("/help/wiki_syntax/detailed", user: :admin)
    end

    # @label Code highlighting
    def code_highlighting
      render_page("/help/code_highlighting", user: :admin)
    end
  end
end
