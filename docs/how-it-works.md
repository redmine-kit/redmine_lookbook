# How it works

Redmine Lookbook connects Lookbook to Redmine in three places: the controller that renders previews, internal requests for page previews, and settings overrides for the toolbar options.

## Loading

- **Enabled check:** the plugin is enabled when the Lookbook gem is installed and `REDMINE_LOOKBOOK` is `1` (the default in development).
- **Setup:** Redmine runs the plugin's `init.rb` in a `to_prepare` callback, after Rails' autoloader is set up, and again on every code reload in development. The plugin then loads its previews and the preview controller itself, because Lookbook expects them to be autoloaded.
- **Off means off:** the preview controller and the page component refer to Lookbook and ViewComponent, so they are kept in `lookbook/`, outside the directories that Redmine autoloads. With the plugin disabled, nothing refers to Lookbook, and Redmine eager loads without it in production.

## Components

Lookbook renders previews through `RedmineLookbook::PreviewsController`. It is based on Redmine's `ApplicationController`, so Redmine's helpers, layouts and theme handling work as in Redmine's own pages.

- **Layout:** with the "None" layout option, the controller uses a layout with Redmine's stylesheets, scripts and theme, but without Redmine's header, menus, sidebar and footer. With "Redmine layout", it uses Redmine's `base` layout.
- **User:** previews render as the first active administrator.
- **Language and theme:** the language is set for the duration of the render, and the theme through a settings override (see below).
- **One pass:** previews are rendered in one pass with their layout (Lookbook's `preview_single_pass_rendering`), so that `content_for :header_tags` from Redmine's helpers reaches the layout's `<head>`.
- **Layout parts:** the "Layout" and "Menus" previews use the layout `redmine_lookbook/bare`, which puts the preview directly in `#wrapper`, as Redmine's base layout does with its header and menus.

## Pages

A page preview sends an internal GET request through the Rails application (`Rails.application.call`) and shows the HTML that Redmine returns.

- **User, theme and language:** they are passed in Rack env keys of the request (`redmine_lookbook.user`, `redmine_lookbook.theme`, `redmine_lookbook.locale`). A patch of Redmine's `ApplicationController` reads them: it signs in the given user, sets the language and applies the theme for that request. Only code in the same process can set these keys. HTTP headers become `HTTP_*` keys, so a request from outside cannot set them.
- **Source panel:** `render_page` returns a component (`RedmineLookbook::PageComponent`) instead of rendering a template, so Lookbook's Source panel shows the preview method with the page's path, for example `render_page("/issues/1", user: :admin)`.
- **Redirects:** up to three redirects on the same host are followed.
- **Settings and status:** the request runs with the settings that the preview gives (see below). When the final HTTP status is not the one the preview expects, the preview's response gets the header `X-Redmine-Lookbook-Unexpected-Status`, which `bin/check-previews` reports.
- **Code reloading:** in development, the internal request does not reload changed code. The preview's own request has already done that, and reloading in the middle of it would unload the constants it is using.
- **State:** `User.current` and the language of the preview's own request are restored after the internal request.
- **Layout:** with the "None" layout option, the header, menus, sidebar, footer and the flyout menu are removed from the HTML, and `#main` gets the `nosidebar` class.

## Settings overrides

The toolbar's theme, the wiki formatting parameter and the `settings:` of page previews change Redmine's settings for one render only. `RedmineLookbook::SettingsOverride` is prepended to `Setting` and replaces `Setting[]`, which every setting reader of Redmine uses (`Setting.ui_theme`, `Setting.thumbnails_enabled?` and so on): it returns a value from the current thread when one is set. Redmine's settings in the database are not changed.

Redmine reads the theme from `Setting.ui_theme` in several places (the stylesheets, the icons, the favicon and the `theme-*` class on `<body>`), so overriding the setting applies the theme everywhere, as in Redmine itself.

## Test repositories

`RedmineLookbook::TestRepositories` creates the repositories of Redmine's own tests in `tmp/test/`, as Redmine's `rake test:scm:setup` does: `svnadmin load` for Subversion, `hg pull` from a bundle for Mercurial and `tar` for Git. The Subversion repository is the one that Redmine's test data refers to. The Git and Mercurial repositories are added to eCookbook with the path encoding ISO-8859-1, as Redmine's repository tests use them. Redmine reads their revisions (`fetch_changesets`) and links them to issues from their messages (`scan_comment_for_issue_ids`).

## Toolbar options

The theme, language and layout options are Lookbook [display options](https://lookbook.build/guide/previews/display-options). The language choices are built from Redmine's languages after Rails has booted, because the language names come from Redmine's translations.

## Lookbook's UI on iPad and iPhone

Lookbook sizes its UI with `100vh`. Safari counts the area behind its toolbars in `100vh`, so the bottom of the UI was cut off. The plugin replaces Lookbook's `lookbook/partials/_user_styles.html.erb` partial with one that sets the same heights with `100dvh`, and renders Lookbook's user styles as before.

## Limitations

- Redmine 7.0 only.
- The preview controller repeats a few private methods of Lookbook's preview controller, and the plugin replaces one of Lookbook's partials (Lookbook 2.3). A future Lookbook release may need changes here.
- Page previews use GET requests only, so they show pages as they first appear.
