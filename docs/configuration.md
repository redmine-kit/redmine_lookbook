# Configuration

Redmine Lookbook is configured with environment variables of the Redmine process. It has no settings page in Redmine.

## Environment variables

| Variable | Default | Description |
| --- | --- | --- |
| `REDMINE_LOOKBOOK` | `1` in development, `0` otherwise | Turns the previews on (`1`) or off (`0`). Keep it off in production (see [Security](security.md)). |
| `REDMINE_LOOKBOOK_PATH` | `/lookbook` | Where Lookbook is mounted. |
| `REDMINE_LOOKBOOK_PREVIEW_PATHS` | (none) | More preview directories, separated by `:` (see [Writing previews](writing-previews.md#where-previews-go)). |
| `REDMINE_LOOKBOOK_SERVERS` | (none) | Other Redmine servers that run this plugin, as `label=url,label=url`. A "Server" option then appears in the toolbar (see [Several servers](#several-servers)). |

When the previews are off, the plugin does nothing: Lookbook is not mounted and no Lookbook code is loaded.

## Several servers

`REDMINE_LOOKBOOK_SERVERS` links Redmines that show the same previews, for example two Redmines with different themes or plugins:

```sh
REDMINE_LOOKBOOK_SERVERS="local=http://127.0.0.1:3000,second=http://127.0.0.1:3001"
```

The "Server" option of the toolbar lists "This server" (with its Redmine version) and these servers. When another server is chosen, the preview pane is redirected to the same preview on that server, with the same toolbar options, so the preview is rendered by that Redmine. Lookbook's navigation stays on this server.

Your browser opens the other server directly, so it must be reachable from your browser, and it must have the same previews.

## Docker

The Docker setup has its own variables for the port, the address and the themes directory (see [Installation](installation.md#docker)). It passes `REDMINE_LOOKBOOK_SERVERS` to Redmine.

## Redmine's settings

The toolbar options do not change Redmine's settings. Everything else follows the settings of the Redmine that runs the previews, for example the default language and the text formatting in Administration » Settings. Previews show what that Redmine shows.
