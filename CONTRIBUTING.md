# Contributing

Thank you for helping with Redmine Lookbook. Issues and pull requests are welcome.

## Development

1. Start the development Redmine:

   ```sh
   docker compose -f docker/compose.yml up --build
   ```

2. Open <http://127.0.0.1:3000/lookbook>. The plugin directory is mounted into the container, so changes to previews and templates show up when you reload.
3. Before you send a pull request, check that every preview renders:

   ```sh
   bin/check-previews
   ```

## Guidelines

- **Redmine stays unchanged.** Use Redmine's plugin mechanisms (hooks, `prepend`) and do not edit Redmine's own files.
- **Development only.** Code must not affect a Redmine where the plugin is off. Anything that needs the Lookbook gem must be loaded only when the plugin is enabled, because production servers do not install it.
- **Redmine's output.** Previews render with Redmine's own helpers, partials and controllers. Do not copy Redmine's HTML by hand.
- **Documentation in two languages.** The documentation is in English (`README.md`, `docs/`) and Japanese (`README.ja.md`, `docs/ja/`). Update both in the same pull request. `docs/` is published to https://redmine-theme.github.io/redmine_lookbook/ when it changes on `main`.
- **Commit messages** are in English, in the imperative mood ("Add …", "Fix …").

By contributing, you agree that your contribution is released under the project's license (GPL-2.0-or-later).
