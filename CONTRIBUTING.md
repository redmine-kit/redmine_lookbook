# Contributing

Thank you for helping with Redmine Kit Lookbook. Issues and pull requests are welcome.

## Development

1. Start the development Redmine:

   ```sh
   bin/dev
   ```

   It uses Apple container when it is installed and running, else Docker Compose (`CONTAINER_CLI=container` or `CONTAINER_CLI=docker` chooses).

2. Open <http://127.0.0.1:3000/lookbook>. The plugin directory is mounted into the container, so changes to previews and templates show up when you reload.
3. Before you send a pull request, check that every preview renders:

   ```sh
   bin/dev check
   ```

4. Run the plugin's tests (Redmine 7.0.3 and PostgreSQL 16 in a container, without Lookbook) and check the plugin installed as a gem:

   ```sh
   bin/test
   bin/test-gem
   bin/services --down   # stops PostgreSQL
   ```

   A run stops the service containers it started (it doesn't remove them) when it ends, whether the tests pass, fail
   or are interrupted. Containers that were running before the run, or that another run of this repository still uses,
   are left running. `KEEP_SERVICES=1` keeps them running after the run.

## Guidelines

- **Redmine stays unchanged.** Use Redmine's plugin mechanisms (hooks, `prepend`) and do not edit Redmine's own files.
- **Development only.** Code must not affect a Redmine where the plugin is off. Anything that needs the Lookbook gem must be loaded only when the plugin is enabled, because production servers do not install it.
- **Redmine's output.** Previews render with Redmine's own helpers, partials and controllers. Do not copy Redmine's HTML by hand.
- **Documentation in two languages.** The documentation is in English (`README.md`, `docs/`) and Japanese (`README.ja.md`, `docs/ja/`). Update both in the same pull request. `docs/` is published to https://redmine-kit.github.io/redmine_lookbook/ when it changes on `main`.
- **Screenshots.** The images in `docs/img/` (and `docs/img/ja/`, in Japanese) are taken from the development Redmine with `bin/capture-screenshots`, which needs Node.js 22 or later and Chrome. Take them again when a change shows in them.
- **Commit messages** are in English, in the imperative mood ("Add …", "Fix …").

By contributing, you agree that your contribution is released under the project's license (GPL-2.0-or-later).
