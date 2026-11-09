# frozen_string_literal: true

# The plugin as a gem on GitHub Packages (.github/workflows/gem.yml), with the
# plugin's run-time files; the installed gem is linked into Redmine's
# plugins/. Lookbook itself is not a dependency: it belongs in the
# development group of the Redmine that uses the previews, never in
# production.
version = File.read(File.join(__dir__, 'lib/redmine_lookbook.rb'))[/VERSION = "([^"]+)"/, 1]

Gem::Specification.new do |spec|
  spec.name = 'redmine_lookbook'
  spec.version = version
  spec.summary = "Previews Redmine 7's components and pages in Lookbook, for theme authors"
  spec.authors = ['Redmine Kit']
  spec.license = 'GPL-2.0-or-later'
  spec.homepage = 'https://github.com/redmine-kit/redmine_lookbook'
  spec.required_ruby_version = '>= 3.2'
  spec.files = Dir['{init.rb,LICENSE}', '{app,config,lib,lookbook,previews}/**/*']
  spec.metadata['github_repo'] = 'ssh://github.com/redmine-kit/redmine_lookbook'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
