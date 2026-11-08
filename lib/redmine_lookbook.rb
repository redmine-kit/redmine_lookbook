# Previews of Redmine components and pages, built on Lookbook.
#
# Redmine 7 autoloads the plugin's lib directory (Zeitwerk), so the files in
# lib/redmine_lookbook are not required here.
module RedmineLookbook
  VERSION = "0.1.0"

  module_function

  # Lookbook must be installed, and previews are on in development unless
  # REDMINE_LOOKBOOK says otherwise. Never enable it on a production server.
  def enabled?
    return false unless defined?(::Lookbook)

    default = Rails.env.development? ? "1" : "0"
    ENV.fetch("REDMINE_LOOKBOOK", default) == "1"
  end

  def root
    File.expand_path("..", __dir__)
  end

  # The administrator that previews render as by default.
  def first_admin
    User.active.where(admin: true).order(:id).first
  end

  def mount_path
    ENV.fetch("REDMINE_LOOKBOOK_PATH", "/lookbook")
  end

  # Built-in previews, plus extra directories (for example, previews kept in
  # a theme) listed in REDMINE_LOOKBOOK_PREVIEW_PATHS, separated by ":".
  def preview_paths
    extra = ENV.fetch("REDMINE_LOOKBOOK_PREVIEW_PATHS", "").split(":").reject(&:empty?)
    [File.join(root, "previews"), *extra]
  end

  # Redmine runs plugin init.rb files in a to_prepare callback, after the
  # Rails autoloader is set up, and again on every code reload in
  # development. So the previews are loaded here directly instead of
  # through the autoloader, and loading them again picks up changes.
  def setup
    paths = preview_paths
    controller = "RedmineLookbook::PreviewsController"

    # Reload when the previews or the preview controller change. Rails reads
    # these directories when it builds its file watcher, which happens after
    # the first to_prepare run, so the first setup call is in time.
    [*paths, File.join(root, "lookbook")].each do |dir|
      Rails.application.config.watchable_dirs[dir] = [:rb, :erb]
    end

    Rails.application.config.view_component.previews.paths |= paths
    Rails.application.config.view_component.previews.controller = controller

    Lookbook.config.project_name = "Redmine Lookbook"
    Lookbook.config.preview_paths |= paths
    Lookbook.config.preview_controller = controller
    # Render each preview and its layout in one pass, so that content_for
    # :header_tags from Redmine's helpers (the scripts and stylesheets of the
    # context menu and the wiki toolbar) reaches the layout's <head>.
    Lookbook.config.preview_single_pass_rendering = true
    # Redmine's translations are loaded only after Rails has booted, and the
    # language names come from them, so the toolbar options are built then.
    if Rails.application.initialized?
      Lookbook.config.preview_display_options = Display.options
    else
      Rails.application.config.after_initialize do
        Lookbook.config.preview_display_options = Display.options
      end
    end

    ApplicationController.prepend(ApplicationControllerPatch) unless ApplicationController < ApplicationControllerPatch
    Setting.singleton_class.prepend(SettingsOverride::SettingMethods) unless Setting.singleton_class < SettingsOverride::SettingMethods
    # The reloader is not reloaded itself, so the guard is prepended only once.
    reloader = Rails.application.reloader.singleton_class
    unless reloader.ancestors.any? { |mod| mod.name == ReloadGuard::ReloaderMethods.name }
      reloader.prepend(ReloadGuard::ReloaderMethods)
    end
    load File.join(root, "lookbook", "previews_controller.rb")
    load File.join(root, "lookbook", "page_component.rb")
    load_previews(paths)
  end

  def load_previews(paths)
    paths.each do |path|
      Dir[File.join(path, "**", "*_preview.rb")].sort.each { |file| load file }
    end
  end
end
