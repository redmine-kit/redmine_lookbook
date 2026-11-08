# Redmine Lookbook

[![CI](https://github.com/redmine-theme/redmine_lookbook/actions/workflows/ci.yml/badge.svg)](https://github.com/redmine-theme/redmine_lookbook/actions/workflows/ci.yml)

Redmine Lookbook previews Redmine's components and pages in [Lookbook](https://lookbook.build/), so that theme authors can check a theme across many screens, languages and layouts without clicking through Redmine.

[日本語](docs/ja/README.md)

> **Status:** early development (0.1.0). It supports Redmine 7.0 and has been tested with Redmine 7.0.3.

## Features

- **Real Redmine output:** components are rendered with Redmine's own helpers and partials, and pages are rendered by Redmine's own controllers. Nothing is copied by hand.
- **Many screens:** 58 previews, including issues, the Gantt chart, the calendar, the wiki, news, documents, files, forums, spent time, personal pages, administration and error pages.
- **Toolbar options:** switch the theme, the language and the layout while you look at a preview. The defaults follow Redmine's own settings.
- **Test data:** Redmine's own test data (`test/fixtures`) fills the screens with projects, issues, wiki pages and more.
- **Your own previews:** add previews for your theme or plugin from another directory.

## Requirements

- Redmine 7.0
- A Ruby version that Redmine 7.0 supports
- [Lookbook](https://github.com/lookbook-hq/lookbook) 2.3. Lookbook installs [ViewComponent](https://viewcomponent.org/) as a dependency; Redmine Lookbook does not use ViewComponent components.

Use Redmine Lookbook only in a Redmine that is set up for previews (see [Security](#security)).

## Quick start with Docker

```sh
git clone https://github.com/redmine-theme/redmine_lookbook.git
cd redmine_lookbook
docker compose -f docker/compose.yml up --build
```

Then open <http://127.0.0.1:3000/lookbook>. To check that every preview renders, run `bin/check-previews`. The first start downloads Redmine 7.0.3 (checked against its SHA256), loads Redmine's test data and starts Redmine in development mode. To sign in to Redmine itself, use `admin` / `admin`.

| Variable | Default | Description |
| --- | --- | --- |
| `REDMINE_LOOKBOOK_BIND` | `127.0.0.1` | The address to listen on. Use `0.0.0.0` to open it to other devices on your local network. |
| `REDMINE_LOOKBOOK_PORT` | `3000` | The port on your computer. |
| `REDMINE_LOOKBOOK_THEMES` | `./themes` (under `docker/`) | A directory of themes to preview. Each theme goes in its own subdirectory. |

## Installing into an existing Redmine

1. Clone this repository into `plugins/redmine_lookbook` of a Redmine 7.0 that runs in development mode.
2. Run `bundle install`. Lookbook is in the `development` group of the plugin's `Gemfile`.
3. Load Redmine's test data. **This replaces the rows in the Redmine database**, so do it only in a Redmine that is used for previews:

   ```sh
   bin/rails redmine_lookbook:load_test_data CONFIRM=yes
   ```

4. Start Redmine in development mode and open `/lookbook`.

## Toolbar options

| Option | Choices | Default |
| --- | --- | --- |
| Theme | Default, and every theme that Redmine finds | Default (Redmine's default theme) |
| Language | Default, and every language that Redmine supports | Default (Redmine's default language, from the administration settings) |
| Layout | None (component only), Redmine layout | None |

- **Layout:** "None" keeps Redmine's stylesheets, scripts and theme, and leaves out the header, menus, sidebar and footer. "Redmine layout" shows the whole page.
- **Right-to-left languages:** choose Arabic or Hebrew to check a theme in right-to-left layout.

## Previewing your theme

1. Put your theme in Redmine's `themes/` directory (with Docker, in `docker/themes/` or the directory in `REDMINE_LOOKBOOK_THEMES`).
2. Restart Redmine so that it finds the new theme, then choose it in the toolbar.
3. Edit the theme and reload the preview.

## Writing previews

Previews are [Lookbook previews](https://lookbook.build/guide/previews). Redmine's helpers are available in preview templates.

**A component:**

```ruby
# previews/components/badges_preview.rb
module Components
  class BadgesPreview < Lookbook::Preview
    # @label Badges
    def default
      render_with_template
    end
  end
end
```

```erb
<%# previews/components/badges_preview/default.html.erb %>
<span class="badge badge-private"><%= l(:field_is_private) %></span>
```

**A page:** include `RedmineLookbook::PagePreview` and give the path of a Redmine page. The page is rendered by Redmine as the given user (`:admin`, `:anonymous`, or a login).

```ruby
# previews/pages/my_plugin_preview.rb
module Pages
  class MyPluginPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label My plugin settings
    def settings
      render_page("/settings/plugin/my_plugin", user: :admin)
    end
  end
end
```

To keep previews outside this repository (for example, in your theme), list their directories in `REDMINE_LOOKBOOK_PREVIEW_PATHS`, separated by `:`.

## Configuration

| Environment variable | Default | Description |
| --- | --- | --- |
| `REDMINE_LOOKBOOK` | `1` in development, `0` otherwise | Turns the previews on (`1`) or off (`0`). |
| `REDMINE_LOOKBOOK_PATH` | `/lookbook` | Where Lookbook is mounted. |
| `REDMINE_LOOKBOOK_PREVIEW_PATHS` | (none) | More preview directories, separated by `:`. |
| `REDMINE_LOOKBOOK_SERVERS` | (none) | Other Redmine servers that run this plugin, as `label=url,label=url`. A "Server" option then appears in the toolbar and opens the same preview on the chosen server. |

## How it works

- **Components:** Lookbook renders previews through `RedmineLookbook::PreviewsController`, which is based on Redmine's `ApplicationController`. Redmine's helpers, layouts and theme handling are therefore available.
- **Pages:** a page preview sends an internal GET request through the Rails application and shows the HTML that Redmine returns. The user, theme and language of that request are passed in Rack env keys. Only code in the same process can set these keys; HTTP headers become `HTTP_*` keys and cannot reach them.
- **Theme and language:** the chosen theme is applied in the same way as Redmine's `current_theme`, and the chosen language with Redmine's own language handling. Redmine's settings in the database are not changed.

## Security

- **Development only.** Never enable Redmine Lookbook on a production server. Anyone who can open `/lookbook` can see pages rendered as an administrator, and Lookbook has no sign-in of its own.
- **Keep it private.** The Docker setup listens only on `127.0.0.1` by default. Open it to your local network only when everyone on that network may see the data.
- **Test data replaces data.** `redmine_lookbook:load_test_data` replaces the rows of the tables in Redmine's test data. It refuses to run in production and runs only with `CONFIRM=yes`.

See [SECURITY.md](SECURITY.md) to report a vulnerability.

## Limitations

- Redmine 7.0 only.
- The preview controller repeats a few private methods of Lookbook's own preview controller (Lookbook 2.3). A future Lookbook release may need changes here.
- Page previews use GET requests only, so they show pages as they first appear (for example, a form before it is sent).

## License

Redmine Lookbook is released under the GNU General Public License, version 2 or (at your option) any later version. See [LICENSE](LICENSE).

- Redmine is © Jean-Philippe Lang and released under the GPL.
- Lookbook is released under the MIT License.
