module Pages
  # Projects, rendered by Redmine's own controllers with Redmine's test data.
  class ProjectsPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Home
    def home
      render_page("/", user: :admin)
    end

    # @label Projects
    def index
      render_page("/projects", user: :admin)
    end

    # @label New project
    def new
      render_page("/projects/new", user: :admin)
    end

    # @label Project overview
    def overview
      render_page("/projects/ecookbook", user: :admin)
    end

    # @label Subproject overview
    def subproject
      render_page("/projects/subproject1", user: :admin)
    end

    # @label Copy project
    def copy
      render_page("/projects/ecookbook/copy", user: :admin)
    end

    # @label Activity
    def activity
      render_page("/projects/ecookbook/activity", user: :admin)
    end

    # @label Roadmap
    def roadmap
      render_page("/projects/ecookbook/roadmap", user: :admin)
    end

    # @label Version
    def version
      render_page("/versions/2", user: :admin)
    end

    # @label New version
    def new_version
      render_page("/projects/ecookbook/versions/new", user: :admin)
    end

    # @label Edit version
    def edit_version
      render_page("/versions/2/edit", user: :admin)
    end

    # @label Project settings
    def settings
      render_page("/projects/ecookbook/settings", user: :admin)
    end

    # @label Project settings: modules
    def settings_modules
      render_page("/projects/ecookbook/settings/modules", user: :admin)
    end

    # @label Project settings: members
    def settings_members
      render_page("/projects/ecookbook/settings/members", user: :admin)
    end

    # @label Project settings: versions
    def settings_versions
      render_page("/projects/ecookbook/settings/versions", user: :admin)
    end

    # @label Project settings: issue categories
    def settings_categories
      render_page("/projects/ecookbook/settings/categories", user: :admin)
    end

    # @label Search results
    def search
      render_page("/search?q=issue", user: :admin)
    end

    # @label Search results (all types)
    def search_all
      render_page("/search?q=cookbook&all_words=1&titles_only=0&issues=1&news=1&documents=1&changesets=1&wiki_pages=1&messages=1&projects=1", user: :admin)
    end
  end
end
