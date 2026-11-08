# Theme checklist

What a Redmine 7 theme has to handle, and the previews to check each item with. The previews are named as in Lookbook's navigation (see the [preview list](previews.md)). For how Redmine applies a theme, see [Redmine 7 themes](themes.md).

Check each item with the toolbar's defaults first, then with:

- the "Redmine layout" option, for the header, the menus and the sidebar,
- a right-to-left language (Arabic, Persian or Hebrew),
- a language with long words (for example German) and a language with other scripts (for example Japanese),
- a narrow preview pane (below 900 pixels wide), for `responsive.css`.

## Setup

| Item | What to check | Previews |
| --- | --- | --- |
| Redmine's styles | `application.css` imports Redmine's `application.css` or replaces all of it | Any |
| Colors and fonts | The custom properties (`--color-header-background`, `--fonts-main`, Open Color's `--oc-*`) give the colors you want | Pages » Projects » Project overview |
| Replaced stylesheets | `gantt.css`, `context_menu.css`, `jstoolbar.css`, `scm.css`, `dropdown.css` and `responsive.css` of the theme, if any, cover what Redmine's files cover | Gantt chart, Context menu, Text area with the wiki toolbar, Diff |
| Favicon and `theme.js` | The favicon shows, and `theme.js` has no errors in the browser console | Any page with the Redmine layout |

## Layout

| Item | What to check | Previews |
| --- | --- | --- |
| Top menu and account menu | Links, the avatar, signed in and signed out | Top menu and account menu; Pages » Account » Sign in |
| Header | Title, quick search, "Jump to a project" | Any page with the Redmine layout |
| Project menu | Tabs, the selected tab, many modules | Project menu; Pages » Projects » Project overview |
| Sidebar | Width, links, the selected link, sidebar forms | Issue sidebar; Pages » Issues » Issues |
| Content | Title and breadcrumbs, `.contextual` links, splitcontent | Title with breadcrumbs; Pages » Projects » Project overview |
| No sidebar | `#main.nosidebar` | Pages » Issues » New issue |
| Footer | | Any page with the Redmine layout |
| Narrow screens | The header bar, the flyout menu, tables that scroll | Any page with the Redmine layout and a narrow pane |
| Printing | Menus and controls are hidden | Any page, in the browser's print preview |

## Navigation

| Item | What to check | Previews |
| --- | --- | --- |
| Tabs | Selected, many tabs (scroll buttons) | Tabs; Pages » Settings |
| Administration menu | Icons and the selected item | Administration menu; Pages » Administration » Administration |
| Pagination | Current page, per page | Pagination |

## Basic elements

| Item | What to check | Previews |
| --- | --- | --- |
| Flash messages | Notice, warning and error | Flash messages |
| Buttons and links | Buttons, icon links, disabled | Buttons and icon links |
| Badges | Private, closed, locked and others | Badges |
| Icons | Every icon of the sprite, sizes, icons next to text | Icons (SVG sprite) |
| Avatars and users | Sizes, user links, groups | Avatars and user links |
| Progress bars | Done and closed parts, legends | Progress bar; Pages » Projects » Roadmap |
| Tables | `table.list`, odd and even rows, selected rows, sorting, empty lists | Tables; Issue list |
| Boxes | `.box`, fieldsets, collapsible fieldsets | Boxes and fieldsets |
| Modal dialogs | The dialog, its title and buttons | Modal dialog |
| Tooltips | The issue tooltip | Issue tooltip |

## Forms

| Item | What to check | Previews |
| --- | --- | --- |
| Fields | Text, select, check boxes, radio buttons, dates, required fields, help text | Form fields; Pages » Issues » New issue |
| Errors | The error box and fields with errors | Error messages |
| Wiki toolbar | The toolbar, the preview tab, the text area fonts | Text area with the wiki toolbar; Pages » Content » Wiki edit |
| Filters | Filters, options, the "Apply" and "Clear" links | Issue filters; Pages » Issues » New query |
| Large forms | Tabular forms and tabs | Pages » Settings; Pages » Administration » Edit role, Workflow |

## Issues

| Item | What to check | Previews |
| --- | --- | --- |
| Issue list | Columns, priorities and statuses as classes, grouped rows, totals, the context menu | Issue list; Pages » Issues » Issues, Issues grouped, with totals, Context menu |
| Issue page | Attributes, description, the sticky header, private and closed issues | Pages » Issues » Issue, Closed issue, Private issue |
| History | Notes, changes, reactions | History; Pages » Issues » Issue |
| Attachments | File list, thumbnails | Attachments |
| Related issues and subtasks | The tables and their buttons | Related issues; Subtasks; Pages » Issues » Issue with related issues |
| Watchers and custom fields | | Watchers; Custom fields |

## Planning

| Item | What to check | Previews |
| --- | --- | --- |
| Gantt chart | Bars, versions, today's line, relations | Pages » Issues » Gantt chart |
| Calendar | Days, today, issues that start and end | Calendar; Pages » Issues » Calendar |
| Roadmap and versions | Version overview, progress | Version overview; Pages » Projects » Roadmap, Version |
| Spent time | List and report | Pages » Issues » Spent time, Spent time report |

## Content

| Item | What to check | Previews |
| --- | --- | --- |
| Wiki formatting | Headings, lists, tables, code and syntax highlighting, quotes, alerts, footnotes, task lists, images, macros, links to Redmine objects. Check both formats | Wiki formatting (`format` parameter); Pages » Content |
| Wiki pages | Sections with edit links, history, diff, annotate, index | Pages » Content » Wiki page with sections, Wiki history, Wiki diff, Wiki annotate |
| Diffs | Inline and side by side | Diff; Pages » Content » Wiki diff |
| News, documents, files and forums | Lists, comments, replies | News; Pages » Content |
| Activity | Days, event icons | Activity; Pages » Projects » Activity |
| Members | Roles and members | Members |
| Help | The wiki syntax help (its own stylesheet, see [Redmine 7 themes](themes.md#other-stylesheets)) | Pages » Help |

## Pages

| Item | What to check | Previews |
| --- | --- | --- |
| Signed out | Sign in, lost password, register | Pages » Account |
| Personal pages | My page blocks, my account | Pages » Account » My page, My account |
| Administration | Lists, forms, the information page | Pages » Administration |
| Errors | 404, 403, sign-in required | Pages » Errors |
| Search | Results of all types | Pages » Projects » Search results (all types) |

## Not covered by the previews

Check these in a Redmine of your own:

- **Repositories:** the repository browser, changesets and repository diffs. Redmine's test data refers to repositories that Redmine's tests create separately, so these pages are not previewed. The Diff component shows the diff markup.
- **States after JavaScript:** page previews are opened with a GET request and show pages as they first appear. Open dropdowns, autocomplete lists (issues, wiki pages and mentions), drag and drop, and forms after they are sent are not shown.
- **Hover and focus:** check them by pointing at and tabbing through the previews.
- **Other users:** most page previews render as an administrator, who sees every link. "Change password" renders as `jsmith`, "Forbidden (403)" as `dlopper`, and the signed-out pages as an anonymous user.
- **Private notes:** Redmine's test data has no private notes.
- **Settings that change pages:** for example Gravatar, the text area font of a user, table sorting in wiki pages and disabled reactions. The previews use the settings of the test data; only the attachments preview turns thumbnails on.
- **Plugins:** pages and stylesheets of plugins. Add [your own previews](writing-previews.md) for them.
- **Emails, PDF and CSV exports, and Atom feeds:** themes do not apply to them.
