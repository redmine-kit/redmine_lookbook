module Pages
  # Repository pages, rendered by Redmine's own controllers with the test
  # repositories of Redmine's tests (see RedmineLookbook::TestRepositories):
  # Subversion is the default repository of eCookbook, Git and Mercurial are
  # further repositories.
  class RepositoryPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label Repository
    def subversion
      render_page("/projects/ecookbook/repository", user: :admin)
    end

    # @label Directory
    def subversion_directory
      render_page { subversion_path("show/subversion_test") }
    end

    # @label Revisions
    def subversion_revisions
      render_page { subversion_path("revisions") }
    end

    # @label Revision with related issues
    def subversion_revision
      render_page { subversion_path("revisions/11") }
    end

    # @label Revision diff
    def subversion_diff
      render_page { subversion_path("revisions/15/diff") }
    end

    # @label Revision diff, side by side
    def subversion_diff_sbs
      render_page { subversion_path("revisions/15/diff?type=sbs") }
    end

    # @label Statistics
    def statistics
      render_page { subversion_path("statistics") }
    end

    # @label Git repository
    def git
      render_page("/projects/ecookbook/repository/git", user: :admin)
    end

    # @label Git directory
    def git_directory
      render_page("/projects/ecookbook/repository/git/show/sources", user: :admin)
    end

    # @label File with syntax highlighting
    def git_file
      render_page("/projects/ecookbook/repository/git/entry/sources/watchers_controller.rb", user: :admin)
    end

    # @label Text file
    def git_text_file
      render_page("/projects/ecookbook/repository/git/entry/README", user: :admin)
    end

    # @label Image file
    def git_image
      render_page("/projects/ecookbook/repository/git/entry/images/edit.png", user: :admin)
    end

    # @label Annotate
    def git_annotate
      render_page("/projects/ecookbook/repository/git/annotate/sources/watchers_controller.rb", user: :admin)
    end

    # @label File history
    def git_changes
      render_page("/projects/ecookbook/repository/git/changes/sources/watchers_controller.rb", user: :admin)
    end

    # @label Git revisions with the graph
    def git_revisions
      render_page("/projects/ecookbook/repository/git/revisions", user: :admin)
    end

    # @label Git revision with every kind of change
    def git_revision
      render_page("/projects/ecookbook/repository/git/revisions/deff712f05a90d96edbd70facc47d944be5897e3", user: :admin)
    end

    # @label Git revision diff
    def git_diff
      render_page("/projects/ecookbook/repository/git/revisions/deff712f05a90d96edbd70facc47d944be5897e3/diff", user: :admin)
    end

    # @label Mercurial revisions with branches
    def mercurial_revisions
      render_page("/projects/ecookbook/repository/mercurial/revisions", user: :admin)
    end

    # @label New repository
    def new_repository
      render_page("/projects/ecookbook/repositories/new", user: :admin)
    end

    # @label Edit repository
    def edit_repository
      render_page { (repository = git_repository) && "/repositories/#{repository.id}/edit" }
    end

    # @label Project settings: repositories
    def settings
      render_page("/projects/ecookbook/settings/repositories", user: :admin)
    end

    private

    def subversion_repository
      RedmineLookbook::TestData.project&.repository
    end

    def git_repository
      RedmineLookbook::TestData.project&.repositories&.find_by(identifier: "git")
    end

    def subversion_path(rest)
      repository = subversion_repository
      repository && "/projects/ecookbook/repository/#{repository.identifier_param}/#{rest}"
    end
  end
end
