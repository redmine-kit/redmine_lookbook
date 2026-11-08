# Changelog

## 0.1.0 (unreleased)

- First version: component and page previews for Redmine 7.0 in Lookbook, with theme, language and layout options in the toolbar, Redmine's test data, and a Docker setup for development.
- Documentation site in English and Japanese, with a preview list, a theme checklist and the theme specification of Redmine 7.
- `redmine_lookbook:load_test_data` loads only into an empty database.
- The Lookbook UI fits the visible height on iPad and iPhone.
- 265 previews: Redmine's layout parts and whole layout, menus shown open (the context menu, "Jump to a project", the "+" menu, the actions menu and the account menu), the repository pages, and many more account, project, issue, content and administration pages.
- Test repositories (Subversion, Git and Mercurial) from Redmine's own tests, linked to issues, and a webhook. `redmine_lookbook:update_test_data` adds them to a Redmine with Redmine's test data.
- Page previews can change Redmine settings (`settings:`) and expect an HTTP status (`status:`). `bin/check-previews` reports pages that return another status.
- Fixed: the scripts and stylesheets that Redmine's helpers add to `<head>` (the context menu and the wiki toolbar) were missing in component previews.
- Fixed: page previews could fail right after a code change in development.
- Fixed: the "Import issues" preview used a path that Redmine 7 does not have.
- Screenshots in the documentation and README, in English and Japanese, taken with `bin/capture-screenshots`.
- Fixed: the open context menu and flyout menu previews did not always open.
