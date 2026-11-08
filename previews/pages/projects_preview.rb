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

    # @label Project overview
    def overview
      render_page(user: :admin) { project_path("") }
    end

    # @label Activity
    def activity
      render_page(user: :admin) { project_path("/activity") }
    end

    # @label Roadmap
    def roadmap
      render_page(user: :admin) { project_path("/roadmap") }
    end

    # @label Version
    def version
      render_page(user: :admin) { "/versions/#{RedmineLookbook::TestData.version&.id}" if RedmineLookbook::TestData.version }
    end

    # @label Project settings
    def settings
      render_page(user: :admin) { project_path("/settings") }
    end

    # @label Search results
    def search
      render_page("/search?q=page", user: :admin)
    end

    private

    def project_path(suffix)
      project = RedmineLookbook::TestData.project
      "/projects/#{project.identifier}#{suffix}" if project
    end
  end
end
