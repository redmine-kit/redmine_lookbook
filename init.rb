Redmine::Plugin.register :redmine_kit_lookbook do
  name "Redmine Kit Lookbook"
  author "Redmine Kit"
  description "Preview Redmine components and pages with Lookbook, switching themes, languages and layouts."
  version RedmineKit::Lookbook::VERSION
  url "https://github.com/redmine-kit/redmine_lookbook"
  author_url "https://github.com/redmine-kit"
  requires_redmine version_or_higher: "7.0.0"
end

RedmineKit::Lookbook.setup if RedmineKit::Lookbook.enabled?
