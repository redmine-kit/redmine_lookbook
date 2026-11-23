# The plugins this one requires (config/dependencies.yml): without one,
# Redmine stops here and names it.
load File.expand_path('config/dependencies.rb', __dir__)

Redmine::Plugin.register :redmine_kit_lookbook do
  name "Redmine Kit Lookbook"
  author "Redmine Kit"
  description "Previews of Redmine's components and pages"
  version RedmineKit::Lookbook::VERSION
  url "https://github.com/redmine-kit/redmine_lookbook"
  author_url "https://github.com/redmine-kit"
  requires_redmine version_or_higher: "7.0.0"
  # This folder, as Redmine's plugin loader found it: plugins/redmine_kit_lookbook
  # (a checkout or a link, kept unresolved), or the installed gem's folder
  # (boot/redmine_kit_lookbook.rb). Redmine's default is plugins/<id>, which a
  # gem doesn't have.
  directory File.dirname(__FILE__)
end

RedmineKit::Lookbook.setup if RedmineKit::Lookbook.enabled?
