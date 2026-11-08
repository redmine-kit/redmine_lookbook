# Security

Redmine Lookbook is a development tool. It renders Redmine's pages as an administrator for anyone who can open it.

## Use it only for previews

- **Development only.** Never enable Redmine Lookbook on a production server. The previews are off by default outside development mode; do not turn them on with `REDMINE_LOOKBOOK=1` there.
- **No sign-in.** Lookbook has no sign-in of its own. Anyone who can open `/lookbook` can see the pages that the previews render, as an administrator: users, settings, the information page with Redmine's environment, and the data of every project.
- **A Redmine for previews.** Use a Redmine that holds only Redmine's test data. `redmine_lookbook:load_test_data` refuses to run in production, and refuses to run when the database already has projects, issues, trackers or users other than `admin`, so it does not mix test data into a Redmine with data. `redmine_lookbook:update_test_data` runs only on a Redmine with Redmine's test data, and never in production.

## Network

- **Local by default.** The Docker setup listens only on `127.0.0.1`.
- **Local network.** `REDMINE_LOOKBOOK_BIND=0.0.0.0` opens it to the devices on your network, for example to check a theme on a tablet. Do this only on a network where everyone may see the previews, and never expose it to the internet.
- **Test passwords.** The test data has known passwords (`admin` / `admin`, `jsmith` / `jsmith`).

## Internal requests

Page previews pass the user to render as in Rack env keys of an internal request. Only code in the same Redmine process can set these keys; HTTP headers from outside become `HTTP_*` keys and cannot set them. See [How it works](how-it-works.md#pages).

## The Docker image

- The Dockerfile downloads Redmine from redmine.org and checks it against a fixed SHA256 before using it.
- The GitHub Actions of other parties in this repository are pinned to commit SHAs. The documentation workflow uses `redmine-kit/docs-skeleton` (of the same organization) from its `main` branch.
- CI checks that Redmine loads in production without Lookbook, as on a production server.
- The "Server" option opens only the servers in `REDMINE_LOOKBOOK_SERVERS`.

## Reporting a vulnerability

See [SECURITY.md](../SECURITY.md).
