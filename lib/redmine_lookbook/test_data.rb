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
      fill_missing_images
      names.size
    end

    # Attachments in the test data point at files under test/fixtures/files.
    def copy_attachment_files
      source = fixtures_path.join("files")
      return unless source.exist?

      FileUtils.mkdir_p(Attachment.storage_path)
      FileUtils.cp_r("#{source}/.", Attachment.storage_path)
    end

    IMAGE_EXTENSIONS = %w[.png .gif .jpg .jpeg].freeze

    # Redmine's test data has image attachments (for example picture.jpg on
    # issue 2) whose files are not in test/fixtures/files. Previews need them,
    # so an image is created from a test image that is there.
    def fill_missing_images
      source = fixtures_path.join("files/2010/11/101123161450_testfile_1.png")
      return unless source.exist?

      Attachment.find_each do |attachment|
        extension = File.extname(attachment.filename).downcase
        next unless IMAGE_EXTENSIONS.include?(extension)
        next if File.exist?(attachment.diskfile)

        FileUtils.mkdir_p(File.dirname(attachment.diskfile))
        write_image(source, attachment.diskfile, extension)
      end
    end

    def write_image(source, target, extension)
      if extension != ".png" && defined?(MiniMagick)
        image = MiniMagick::Image.open(source.to_s)
        image.format(extension.delete(".").sub("jpeg", "jpg"))
        image.write(target)
      else
        FileUtils.cp(source, target)
      end
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
