require "fileutils"

module RedmineLookbook
  # Redmine's own test data (test/fixtures in the Redmine source) gives the
  # previews projects, issues, wiki pages, news, documents, forums,
  # attachments and spent time. Loading it replaces the rows of those tables,
  # so load it only into a Redmine that is used for previews.
  module TestData
    PROJECT = "ecookbook".freeze

    module_function

    def fixtures_path
      Rails.root.join("test/fixtures")
    end

    def available?
      fixtures_path.join("projects.yml").exist?
    end

    def load!
      raise "Redmine's test data was not found in #{fixtures_path}." unless available?

      names = Dir[fixtures_path.join("*.yml")].map { |file| File.basename(file, ".yml") }
      ActiveRecord::FixtureSet.reset_cache
      ActiveRecord::FixtureSet.create_fixtures(fixtures_path, names)
      copy_attachment_files
      names.size
    end

    # Attachments in the test data point at files under test/fixtures/files.
    def copy_attachment_files
      source = fixtures_path.join("files")
      return unless source.exist?

      FileUtils.mkdir_p(Attachment.storage_path)
      FileUtils.cp_r("#{source}/.", Attachment.storage_path)
    end

    def project
      Project.find_by(identifier: PROJECT)
    end

    def issue
      project&.issues&.order(:id)&.first
    end

    def version
      project&.versions&.order(:id)&.first
    end

    def wiki_page
      project&.wiki&.find_page(project.wiki.start_page)
    end

    def news
      project&.news&.order(:id)&.first
    end

    def document
      project&.documents&.order(:id)&.first
    end

    def board
      project&.boards&.order(:id)&.first
    end

    def topic
      board&.topics&.order(:id)&.first
    end

    def user
      User.find_by_login("jsmith")
    end
  end
end
