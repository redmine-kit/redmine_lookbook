# frozen_string_literal: true

# Redmine Kit Lookbook as a gem (docs/installation.md, "An existing Redmine"):
# Bundler requires this file when Redmine's Gemfile.local has
# `gem 'redmine_kit_lookbook'`.
#
# Redmine 7.0.3 loads plugins from its plugins/ folder only
# (Redmine::PluginLoader). This hands the gem's folder to the same loader, after
# Redmine's initializers have listed plugins/: Redmine then runs init.rb (which
# registers the plugin with this folder, `directory`) and serves its locales
# and views as for any plugin; the folder's lib/ and app/ go to Rails' code
# loader (Zeitwerk) as Redmine adds a plugin's (PluginLoader.add_autoload_paths);
# its routes come after Redmine's, as Redmine draws a plugin's. A plugin of the
# same id in plugins/ (a checkout or a link) wins, and nothing is done.
#
# No constant is defined here: RedmineKit::Lookbook comes from lib/ through the
# code loader, as in plugins/, so that it reloads and Zeitwerk checks it.
# Nothing here needs Lookbook: init.rb sets the plugin up only when it is on.
require 'active_support/lazy_load_hooks'

ActiveSupport.on_load(:before_configuration, yield: true) do |app|
  dir = File.expand_path('..', __dir__)
  app.initializer 'redmine_kit_lookbook.gem', after: :load_config_initializers do |application|
    loader = Redmine::PluginLoader
    next if loader.directories.any? { |path| File.basename(path.to_s) == 'redmine_kit_lookbook' }

    loader.directories << Redmine::PluginPath.new(dir)
    Rails::Engine::Configuration.new(dir).tap { |config| config.paths.add 'lib', eager_load: true }
                                .all_eager_load_paths.each do |path|
      Rails.autoloaders.main.push_dir(path)
      application.config.watchable_dirs[path] = [:rb]
    end
    routes = File.join(dir, 'config/routes.rb')
    application.routes.append { instance_eval(File.read(routes), routes) } if File.file?(routes)
  end
  # The plugin's rake tasks (lib/tasks): Redmine
  # loads plugins/*/lib/tasks/**/*.rake only (lib/tasks/redmine.rake).
  app.rake_tasks do
    next if File.directory?(Rails.root.join('plugins/redmine_kit_lookbook'))

    Dir[File.join(dir, 'lib/tasks/**/*.rake')].each { |task| load task }
  end
end
