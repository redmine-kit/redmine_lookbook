# Installation

Redmine Lookbook runs in a Redmine 7.0 in development mode that is set up only for previews. Do not install it in a Redmine with real data (see [Security](security.md)).

## Requirements

- Redmine 7.0 (checked with Redmine 7.0.3)
- A Ruby version that Redmine 7.0 supports
- [Lookbook](https://github.com/lookbook-hq/lookbook) 2.3 (checked with 2.3.15). Lookbook installs [ViewComponent](https://viewcomponent.org/) as a dependency; Redmine Lookbook does not use ViewComponent components.
- For the repository previews: `svnadmin`, `git` and `hg` (Mercurial), which create and read the test repositories. Without them, those previews show Redmine's error pages. The Docker image has them.

## Docker

The Docker setup builds a Redmine 7.0.3 with this plugin and Redmine's test data. It needs only Docker.

```sh
git clone https://github.com/redmine-kit/redmine_lookbook.git
cd redmine_lookbook
docker compose -f docker/compose.yml up --build
```

Then open <http://127.0.0.1:3000/lookbook>. The first start:

1. downloads Redmine 7.0.3 and checks it against its SHA256,
2. creates a new database and loads Redmine's test data into it, with the test repositories,
3. starts Redmine in development mode.

Later starts run `redmine_lookbook:update_test_data`, which creates the test repositories again in a new container (they are kept in the container's `tmp/`).

To sign in to Redmine itself, use `admin` / `admin` (an administrator) or `jsmith` / `jsmith` (a project member).

| Variable | Default | Description |
| --- | --- | --- |
| `REDMINE_LOOKBOOK_BIND` | `127.0.0.1` | The address to listen on. Use `0.0.0.0` to open it to other devices on your local network. |
| `REDMINE_LOOKBOOK_PORT` | `3000` | The port on your computer. |
| `REDMINE_LOOKBOOK_THEMES` | `./themes` (under `docker/`) | A directory of themes to preview. Each theme goes in its own subdirectory. |

For example, to preview the themes in `~/themes` from a tablet on the same network:

```sh
REDMINE_LOOKBOOK_THEMES=~/themes REDMINE_LOOKBOOK_BIND=0.0.0.0 docker compose -f docker/compose.yml up
```

The database and the uploaded files are kept in Docker volumes. To start again from new test data, remove the volumes: `docker compose -f docker/compose.yml down -v`.

## An existing Redmine

1. Set up a new Redmine 7.0 for previews, with a new, empty database. Run `bin/rails db:migrate`, but not `redmine:load_default_data`.
2. Clone this repository into `plugins/redmine_lookbook`.
3. Run `bundle install`. Lookbook is in the `development` group of the plugin's `Gemfile`.
4. Load Redmine's test data:

   ```sh
   bin/rails redmine_lookbook:load_test_data
   ```

5. Start Redmine in development mode and open `/lookbook`.

## Test data

`redmine_lookbook:load_test_data` loads Redmine's own test data from `test/fixtures` of the Redmine source: 43 tables with projects, issues, versions, wiki pages, news, documents, forums, users and groups.

- **Only into an empty database.** The task refuses to run when the database already has projects, issues, trackers or users other than `admin`, and it refuses to run in production. It never replaces data.
- **Images.** Some image attachments in the test data have no file. The task creates their files from a test image, so thumbnails and inline images show.
- **Subtask.** The test data has no parent and child issues, so the task adds one subtask to issue 1.
- **Repositories.** The task creates the test repositories of Redmine's own tests in `tmp/test/` from `test/fixtures/repositories`, as `rake test:scm:setup` does: the Subversion repository that the test data refers to (the default repository of eCookbook), and Git and Mercurial repositories that it adds to eCookbook. It reads their revisions and links the revisions to the issues their messages refer to.
- **Webhook.** Redmine's test data has no webhooks (new in Redmine 7), so the task adds one.
- **Email address.** Redmine's test data has no additional email addresses, so the task adds one to `jsmith`.
- **Users.** `admin` / `admin` and `jsmith` / `jsmith` can sign in. The page previews render as `admin` unless a preview chooses another user.

`redmine_lookbook:update_test_data` adds the files, the subtask, the webhook, the email address and the test repositories when they are missing. It runs only on a Redmine with Redmine's test data, never in production, and can run any number of times. Run it after updating Redmine Lookbook, or after the test repositories in `tmp/test/` were removed:

```sh
bin/rails redmine_lookbook:update_test_data
```

## Checking the previews

`bin/check-previews` renders every preview with three toolbar settings (the defaults, Japanese with the Redmine layout, and Arabic) and reports the previews that fail, including page previews whose Redmine page returns another HTTP status than the preview expects (for example an error page), and pages that show a missing translation. Run it against a running Redmine:

```sh
bin/check-previews                        # http://127.0.0.1:3000
bin/check-previews http://192.0.2.10:3000 # another Redmine
```
