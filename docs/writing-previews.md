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
- **Scripts and stylesheets:** helpers that add tags to `<head>` with `content_for :header_tags` (for example `context_menu` and `wikitoolbar_for`) work, because previews are rendered in one pass with their layout.

## Layout parts

The header, the top menu, the flyout menu and the footer belong directly in `#wrapper`, not in `#content`. Use the layout `redmine_lookbook/bare`, which has Redmine's stylesheets, scripts and theme and puts the preview directly in `#wrapper`:

```ruby
module Components
  class MyThemeLayoutPreview < Lookbook::Preview
    layout "redmine_lookbook/bare"

    # @label Header
    def header
      render_with_template
    end
  end
end
```

The built-in "Layout" previews have partials for Redmine's layout parts, which your previews can render, for example `render partial: 'components/layout_preview/parts/header'` (also `top_menu`, `flyout` and `footer`).

## Open menus

To show a menu open, add a script that opens it as a click does, for example `$('.contextual .drdn-trigger').trigger('click')` for an actions menu. Some parts are loaded by Redmine with JavaScript, as the user who is signed in to Redmine in the browser, often nobody (for example the context menu). Render them on the server with `RedmineLookbook::PageRenderer#fragment`, which requests a Redmine path as the given user and returns its HTML:

```erb
<% menu = RedmineLookbook::PageRenderer.new(controller).fragment(issues_context_menu_path(ids: [1, 2])) %>
<%= javascript_tag "$(window).on('load', function() { $('#context-menu').html(#{menu.to_json}).show(); });" %>
```

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
- **User:** `:admin` (the default: the first active administrator), `:anonymous` (not signed in) or a login such as `"jsmith"`. A login that is not an active user raises an error.
- **Redirects:** up to three redirects on the same host are followed.
- **Settings:** `settings:` changes Redmine settings for this page only, for example `render_page("/admin/webhooks", settings: { webhooks_enabled: true })` (see [Settings for one preview](#settings-for-one-preview)).
- **Status:** `status:` is the HTTP status that the page returns, 200 by default. Give it for error pages, for example `render_page("/issues/0", status: 404)`. When the page returns another status, `bin/check-previews` reports the preview.
- **Sudo mode:** Redmine's password confirmation (sudo mode) counts as done, so pages such as Administration » Settings show their content. `sudo: false` shows the password form instead, for example `render_page("/my/api_key", sudo: false)`.
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

The test repositories are the repositories of eCookbook: `TestData.project.repository` (Subversion, the default) and `TestData.project.repositories.find_by(identifier: "git")` (also `"mercurial"`).

They return `nil` when the test data is not loaded. Show a message in that case instead of raising an error, as the built-in previews do.

## Settings for one preview

`RedmineLookbook::SettingsOverride.with` changes Redmine's settings while a block renders, without changing Redmine's settings in the database. Page previews take the same settings with `settings:`.

```erb
<%= RedmineLookbook::SettingsOverride.with(thumbnails_enabled: true) {
      link_to_attachments(issue, thumbnails: true)
    } %>
```

- **Any setting:** the names are those of Redmine's `config/settings.yml`, for example `text_formatting`, `ui_theme`, `thumbnails_enabled`, `self_registration` or `new_item_menu_tab`. Redmine reads every setting through `Setting[]`, which the override replaces. A name that is not a Redmine setting raises an error.
- **Values:** use the values that Redmine stores, as strings (`"common_mark"`, `"2"`). `true` and `false` become `"1"` and `"0"`.
- **Toolbar:** the toolbar's theme option uses `ui_theme` in the same way.

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
