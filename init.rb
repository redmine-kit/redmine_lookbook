Redmine::Plugin.register :redmine_lookbook do
  name "Redmine Lookbook"
  author "Tsuyoshi Tsurushima"
  description "Preview Redmine components and pages with Lookbook, switching themes, languages and layouts."
  version RedmineLookbook::VERSION
  url "https://github.com/redmine-theme/redmine_lookbook"
  author_url "https://github.com/redmine-theme"
  requires_redmine version_or_higher: "7.0.0"
end

RedmineLookbook.setup if RedmineLookbook.enabled?
