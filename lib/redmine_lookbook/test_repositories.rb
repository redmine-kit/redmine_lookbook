require "fileutils"
require "open3"

module RedmineLookbook
  # The repositories of Redmine's own tests, for the repository previews.
  #
  # Redmine's test data refers to a Subversion repository in
  # tmp/test/subversion_repository, which Redmine's tests create from
  # test/fixtures/repositories ("rake test:scm:setup:subversion"). This
  # creates it in the same way, adds Git and Mercurial repositories from the
  # same fixtures to the eCookbook project, and reads their revisions.
  module TestRepositories
    # Repository identifier => [Redmine's SCM class, the directory under
    # tmp/test]. The repositories have file names in ISO-8859-1, as Redmine's
    # own repository tests expect.
    ADDED = {
      "git" => ["Repository::Git", "git_repository"],
      "mercurial" => ["Repository::Mercurial", "mercurial_repository"]
    }.freeze

    PATH_ENCODING = "ISO-8859-1".freeze

    module_function

    def root
      Rails.root.join("tmp/test")
    end

    def fixtures
      TestData.fixtures_path.join("repositories")
    end

    # Creates the missing repositories and reads new revisions. It does
    # nothing unless Redmine's test data is loaded, and it can run again.
    # Returns the identifiers of the repositories that are ready.
    def setup!
      project = TestData.project
      return [] unless project && fixtures.exist?

      FileUtils.mkdir_p(root)
      ready = []

      subversion = Repository.find_by(id: 10, project: project)
      if subversion && create_subversion
        ready << (subversion.identifier.presence || "subversion")
        fetch(subversion)
      end

      ADDED.each do |identifier, (type, dir)|
        next unless create(dir)

        repository = project.repositories.find_by(identifier: identifier) ||
                     type.constantize.create!(project: project, identifier: identifier,
                                              url: root.join(dir).to_s, is_default: false,
                                              path_encoding: PATH_ENCODING,
                                              extra_info: { "extra_report_last_commit" => "1" })
        fetch(repository)
        ready << identifier
      end
      link_issues(project)
      ready
    end

    # The revisions in Redmine's test data refer to issues in their messages
    # ("Refs #2"), but are not linked to them. Redmine's own scan links them,
    # so that issues show their associated revisions.
    def link_issues(project)
      changesets = Changeset.where(repository_id: project.repositories.ids)
      return if changesets.joins(:issues).exists?

      changesets.find_each(&:scan_comment_for_issue_ids)
    end

    # The identifiers of the test repositories whose directories exist.
    def ready
      project = TestData.project
      return [] unless project

      project.repositories.select { |repository| File.directory?(repository.root_url.to_s.delete_prefix("file://")) }
             .map { |repository| repository.identifier.presence || "subversion" }
    end

    def create_subversion
      path = root.join("subversion_repository")
      return true if path.exist?

      dump = fixtures.join("subversion_repository.dump.gz")
      run("svnadmin", "create", path.to_s) &&
        run_with_input(Zlib::GzipReader.open(dump.to_s, &:read), "svnadmin", "load", "--quiet", path.to_s)
    end

    def create(dir)
      path = root.join(dir)
      return true if path.exist?

      case dir
      when "mercurial_repository"
        run("hg", "init", path.to_s) && run("hg", "-R", path.to_s, "pull", "--quiet", fixtures.join("mercurial_repository.hg").to_s)
      else
        run("tar", "-xzf", fixtures.join("#{dir}.tar.gz").to_s, "-C", root.to_s)
      end
    end

    def fetch(repository)
      repository.fetch_changesets
    rescue StandardError => e
      Rails.logger.warn("redmine_lookbook: could not read the revisions of #{repository.identifier_param}: #{e.message}")
    end

    def run(*command)
      _out, err, status = Open3.capture3(*command)
      Rails.logger.warn("redmine_lookbook: #{command.first} failed: #{err}") unless status.success?
      status.success?
    rescue Errno::ENOENT
      Rails.logger.warn("redmine_lookbook: #{command.first} is not installed")
      false
    end

    def run_with_input(input, *command)
      _out, err, status = Open3.capture3(*command, stdin_data: input, binmode: true)
      Rails.logger.warn("redmine_lookbook: #{command.first} failed: #{err}") unless status.success?
      status.success?
    rescue Errno::ENOENT
      Rails.logger.warn("redmine_lookbook: #{command.first} is not installed")
      false
    end
  end
end
