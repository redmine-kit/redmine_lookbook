require "fileutils"

module RedmineLookbook
  # Redmine's own test data (test/fixtures in the Redmine source) gives the
  # previews projects, issues, wiki pages, news, documents, forums,
  # attachments and spent time. Loading it replaces the rows of those tables,
  # so load it only into a Redmine that is used for previews.
  module TestData
    PROJECT = "ecookbook".freeze

    class ExistingDataError < StandardError
      def message
        "The Redmine database already has data. Redmine's test data is loaded only into a new, empty Redmine."
      end
    end

    module_function

    def fixtures_path
      Rails.root.join("test/fixtures")
    end

    def available?
      fixtures_path.join("projects.yml").exist?
    end

    # True when the database holds anything beyond what a new Redmine has
    # after "db:migrate" (the first administrator and the built-in anonymous
    # user and groups), including Redmine's default data.
    def existing_data?
      Project.exists? || Issue.exists? || Tracker.exists? ||
        User.where(type: "User").where.not(login: "admin").exists?
    end

    def load!
      raise "Refusing to load test data in production." if Rails.env.production?
      raise "Redmine's test data was not found in #{fixtures_path}." unless available?
      raise ExistingDataError if existing_data?

      names = Dir[fixtures_path.join("*.yml")].map { |file| File.basename(file, ".yml") }
      ActiveRecord::FixtureSet.reset_cache
      ActiveRecord::FixtureSet.create_fixtures(fixtures_path, names)
      update!
      names.size
    end

    # True when Redmine's test data is loaded: its eCookbook project and its
    # user jsmith are there.
    def loaded?
      project.present? && user.present?
    end

    # Adds what the previews need beyond Redmine's test data, when it is
    # missing: attachment files, a subtask, a webhook, an email address and the test
    # repositories. It runs only on Redmine's test data and can run again.
    # Returns the identifiers of the test repositories that are ready.
    def update!
      raise "Refusing to change data in production." if Rails.env.production?
      return [] unless loaded?

      copy_attachment_files
      fill_missing_images
      add_subtask
      add_webhook
      add_email_address
      TestRepositories.setup!
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

    # Redmine's test data has no parent and child issues, so one subtask is
    # added to issue 1 for the subtask previews.
    def add_subtask
      parent = Issue.find_by(id: 1)
      return if parent.nil? || parent.children.any?

      Issue.create!(project: parent.project, tracker: parent.tracker, parent_issue_id: parent.id,
                    subject: "Check the print layout", author: User.find_by_login("jsmith") || parent.author,
                    status: IssueStatus.sorted.first, priority: IssuePriority.default || IssuePriority.first)
    end

    # Redmine's test data has no webhooks (new in Redmine 7), so one is added
    # for the webhook pages.
    def add_webhook
      return if Webhook.exists?

      webhook = Webhook.new(user: user, url: "https://example.com/redmine/webhook", active: true)
      webhook.projects = [project]
      webhook.events = %w[issue.created issue.updated]
      webhook.save!(validate: false)
    end

    # Redmine's test data has no additional email addresses, so jsmith gets
    # one for the email address page.
    def add_email_address
      return if EmailAddress.where(is_default: false).exists?

      EmailAddress.create!(user: user, address: "john.smith@example.net", is_default: false, notify: false)
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
