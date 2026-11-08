# Writing previews

Previews are [Lookbook previews](https://lookbook.build/guide/previews): Ruby classes whose methods are the previews, with an ERB template for each. Redmine's helpers are available in the templates, and Redmine's test data is in the database.

## Where previews go

| Directory | Contents |
| --- | --- |
| `previews/components/` | The built-in component previews (`Components::*Preview`) |
| `previews/pages/` | The built-in page previews (`Pages::*Preview`) |
| A directory in `REDMINE_LOOKBOOK_PREVIEW_PATHS` | Your own previews, for example in your theme's repository |

To keep previews outside this repository, list their directories in `REDMINE_LOOKBOOK_PREVIEW_PATHS`, separated by `:`. Inside such a directory, use the same layout: a class per file, named after the path (`components/my_theme_preview.rb` defines `Components::MyThemePreview`), and the templates in a directory with the same name.

Redmine reloads previews in development mode when their files change.

## A component

A component preview renders a template with Redmine's helpers:

```ruby
# previews/components/my_theme_preview.rb
module Components
  class MyThemePreview < Lookbook::Preview
    # @label Badges
    def badges
      render_with_template
    end
  end
end
```

```erb
<%# previews/components/my_theme_preview/badges.html.erb %>
<span class="badge badge-private"><%= l(:field_is_private) %></span>
<span class="badge badge-status-closed"><%= l(:label_closed_issues) %></span>
```

- **Layout:** with the "None" layout option, the template is rendered in a page with Redmine's stylesheets, scripts and theme, and without Redmine's header, menus, sidebar and footer. With the "Redmine layout" option, it is rendered in Redmine's layout.
- **User:** component previews render as the first active administrator, so links that need permissions are shown.
- **Helpers:** the preview controller has the helpers of Redmine's issues pages (`issues`, `journals`, `projects`, `custom_fields`, `issue_relations`, `watchers`, `attachments`, `queries`, `repositories`, `timelog`, `versions`) and `activities`, besides Redmine's `ApplicationHelper`. It does not use `helper :all`: some of Redmine's helpers redefine the same methods, and the issue list would render empty cells.
- **Instance variables:** some of Redmine's partials expect instance variables such as `@project` or `@issue`. Set them in the template before rendering the partial.

## A page

A page preview renders a Redmine page through Redmine's own controllers. Include `RedmineLookbook::PagePreview` and call `render_page` with the path of the page:

```ruby
# previews/pages/my_plugin_preview.rb
module Pages
  class MyPluginPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label My plugin settings
    def settings
      render_page("/settings/plugin/my_plugin", user: :admin)
    end

    # @label My plugin, as a project member
    def project_tab
      render_page(user: "jsmith") { "/projects/#{RedmineLookbook::TestData.project.identifier}/my_plugin" }
    end
  end
end
```

- **Path:** a string, or a block that returns the path when the preview renders (to look up the test data).
- **User:** `:admin` (the default: the first active administrator), `:anonymous` (not signed in) or a login such as `"jsmith"`.
- **Redirects:** up to three redirects on the same host are followed.
- **Toolbar:** the theme and language options apply to the page. With the "None" layout option, Redmine's header, menus, sidebar and footer are removed from the page.

A page preview sends a GET request, so it shows the page as it first appears (see [How it works](how-it-works.md#pages)).

## Test data

`RedmineLookbook::TestData` finds records of Redmine's test data:

| Method | Record |
| --- | --- |
| `TestData.project` | The "eCookbook" project (`ecookbook`) |
| `TestData.issue` | An issue of that project |
| `TestData.version` | A version of that project |
| `TestData.wiki_page` | A wiki page of that project |
| `TestData.news`, `TestData.document`, `TestData.board`, `TestData.topic` | A news item, a document, a forum and a forum topic |
| `TestData.user` | The user `jsmith` |

They return `nil` when the test data is not loaded. Show a message in that case instead of raising an error, as the built-in previews do.

## Settings for one preview

`RedmineLookbook::SettingsOverride.with` changes some of Redmine's settings while a block renders, without changing Redmine's settings in the database:

```erb
<%= RedmineLookbook::SettingsOverride.with(thumbnails_enabled: true) {
      link_to_attachments(issue, thumbnails: true)
    } %>
```

| Setting | Value |
| --- | --- |
| `text_formatting` | `"common_mark"` or `"textile"` |
| `ui_theme` | A theme id. The toolbar's theme option uses this setting. |
| `thumbnails_enabled` | `true` or `false` |

Other settings cannot be changed this way yet.

## Wiki text

`RedmineLookbook::TextFormatting` renders wiki text with a chosen formatting:

```erb
<% RedmineLookbook::TextFormatting.with("textile") do %>
  <div class="wiki"><%= textilizable("h2. A heading\n\n*Bold* text") %></div>
<% end %>
```

`TextFormatting.sample("common_mark")` and `TextFormatting.sample("textile")` return the sample texts of the "Wiki formatting" preview.

## Parameters

Lookbook's [dynamic parameters](https://lookbook.build/guide/previews/params) work as usual. The "Wiki formatting" preview uses one to choose the formatting:

```ruby
# @label Wiki formatting
# @param format select { choices: [common_mark, textile] }
def wiki(format: "common_mark")
  render_with_template(locals: { format: format })
end
```

## Checking previews

Run `bin/check-previews` against the development Redmine after adding previews (see [Installation](installation.md#checking-the-previews)).
