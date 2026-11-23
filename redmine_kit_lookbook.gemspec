# frozen_string_literal: true

require 'yaml'

# The plugin as a gem on GitHub Packages (.github/workflows/gem.yml), with the
# plugin's run-time files: Bundler requires boot/redmine_kit_lookbook.rb, which
# hands the gem's folder to Redmine's plugin loader. Lookbook itself is not a
# dependency: it belongs in the development group of the Redmine that uses the
# previews, never in production.
version = File.read(File.join(__dir__, 'lib/redmine_kit/lookbook.rb'))[/VERSION = "([^"]+)"/, 1]

Gem::Specification.new do |spec|
  spec.name = 'redmine_kit_lookbook'
  spec.version = version
  spec.summary = "Previews of Redmine's components and pages"
  spec.authors = ['Redmine Kit']
  spec.license = 'GPL-2.0-or-later'
  spec.homepage = 'https://github.com/redmine-kit/redmine_lookbook'
  # The Ruby versions of Redmine 7.0 (its Gemfile: ruby '>= 3.2.0', '< 4.1.0').
  spec.required_ruby_version = ['>= 3.2', '< 4.1']
  spec.files = Dir['{init.rb,LICENSE}', '{app,boot,config,lib,lookbook,previews}/**/*']
  # boot/ only: lib/ is the code loader's (Zeitwerk), never required by name.
  spec.require_paths = ['boot']
  spec.metadata['github_repo'] = 'ssh://github.com/redmine-kit/redmine_lookbook'
  # The plugins it requires (config/dependencies.yml): installing the gem installs them.
  YAML.safe_load_file(File.join(__dir__, 'config/dependencies.yml'))['requires'].each do |name, range|
    spec.add_dependency name, range
  end
  spec.metadata['rubygems_mfa_required'] = 'true'
end
