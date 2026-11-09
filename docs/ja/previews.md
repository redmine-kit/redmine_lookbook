# プレビューの一覧

Redmine Lookbook には 266 のプレビューがあります。コンポーネントが 57、画面が 209 です。「名前」は Lookbook のナビゲーションに表示される名前で、「パス」はプレビューの URL の `/lookbook/inspect/` のあとの部分です。

- **コンポーネント**は、Redmine のヘルパーと部分テンプレートで Redmine の部品をレンダリングします。「Layout」と「Menus」のグループは、Redmine がヘッダー、メニュー、フッターを置く `#wrapper` の直下にレンダリングするので、ツールバーの「Layout」の切り替えは適用されません。メニューは開いた状態で表示します。
- **画面**は、「画面」の列の Redmine の画面を、「ユーザー」の列のユーザーとしてレンダリングします。ユーザーは、`admin`(管理者)、`jsmith` と `dlopper`(プロジェクトのメンバー)、匿名ユーザー(ログインしていない状態)のいずれかです。「備考」には、プレビューがその画面のためだけに変える設定、エラーの画面の HTTP のステータス、Redmine の sudo モードのパスワードのフォームを表示する画面の `sudo: false` を書いています。
- **プレースホルダー:** `<Subversion>` と `<Git>` はテスト用のリポジトリの id で、プレビューがテストデータから取得します。`deff712f…` は Git のリビジョンを省略して書いたものです。

この一覧は、`previews/` のファイルから作っています。

<a id="components"></a>

## コンポーネント

<a id="layout"></a>

### レイアウト

| 名前 | パス |
| --- | --- |
| Whole layout | `components/layout/whole` |
| Whole layout without a project | `components/layout/whole_without_project` |
| Whole layout, signed out | `components/layout/whole_signed_out` |
| Whole layout with the sidebar hidden | `components/layout/whole_sidebar_hidden` |
| Whole layout with the flyout menu open (narrow screens) | `components/layout/whole_flyout_open` |
| Whole layout of a closed project | `components/layout/whole_closed_project` |
| Top menu | `components/layout/top_menu` |
| Top menu with the account menu open | `components/layout/account_menu` |
| Top menu, signed out | `components/layout/top_menu_signed_out` |
| Header with the project menu | `components/layout/header` |
| Sidebar | `components/layout/sidebar` |
| Footer | `components/layout/footer` |

<a id="menus"></a>

### メニュー

| 名前 | パス |
| --- | --- |
| Jump to a project, open | `components/menus/project_jump` |
| New object menu ("+") in the project menu, open | `components/menus/new_object` |
| Actions menu ("..."), open | `components/menus/actions` |
| Context menu of the issue list, open | `components/menus/context_menu` |
| Account menu, open | `components/menus/account` |
| Tabs with scroll buttons | `components/menus/many_tabs` |

<a id="navigation"></a>

### ナビゲーション

| 名前 | パス |
| --- | --- |
| Tabs | `components/navigation/tabs` |
| Project menu | `components/navigation/main_menu` |
| Administration menu | `components/navigation/admin_menu` |
| Title with breadcrumbs | `components/navigation/breadcrumbs` |
| Issue sidebar | `components/navigation/sidebar` |

<a id="basics"></a>

### 基本

| 名前 | パス |
| --- | --- |
| Flash messages | `components/basics/flash` |
| Icons (SVG sprite) | `components/basics/icons` |
| Buttons and icon links | `components/basics/buttons` |
| Badges | `components/basics/badges` |
| Avatars and user links | `components/basics/users` |
| Progress bar | `components/basics/progress` |
| Pagination | `components/basics/pagination` |
| Tables | `components/basics/tables` |
| Boxes and fieldsets | `components/basics/boxes` |
| Modal dialog | `components/basics/modal` |
| Headings and text | `components/basics/typography` |
| Notices and empty states | `components/basics/notices` |
| Color palette | `components/basics/colors` |

<a id="forms"></a>

### フォーム

| 名前 | パス |
| --- | --- |
| Form fields | `components/forms/fields` |
| Error messages | `components/forms/errors` |
| Text area with the wiki toolbar | `components/forms/wiki_toolbar` |
| Issue filters | `components/forms/filters` |
| File upload field | `components/forms/attachments_field` |

<a id="issues"></a>

### チケット

| 名前 | パス |
| --- | --- |
| Issue list | `components/issues/list` |
| History | `components/issues/history` |
| Attachments | `components/issues/attachments` |
| Watchers | `components/issues/watchers` |
| Related issues | `components/issues/relations` |
| Custom fields | `components/issues/custom_fields` |
| Issue tooltip | `components/issues/tooltip` |
| Subtasks | `components/issues/subtasks` |

<a id="content"></a>

### コンテンツ

| 名前 | パス |
| --- | --- |
| Wiki formatting | `components/content/wiki` |
| Calendar | `components/content/calendar` |
| Diff | `components/content/diff` |
| Version overview | `components/content/version` |
| News | `components/content/news` |
| Activity | `components/content/activity` |
| Members | `components/content/members` |
| Source file with syntax highlighting | `components/content/source_file` |

<a id="pages"></a>

## 画面

<a id="projects"></a>

### プロジェクト

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Home | `/` | `admin` |  |
| Projects | `/projects` | `admin` |  |
| New project | `/projects/new` | `admin` |  |
| Project overview | `/projects/ecookbook` | `admin` |  |
| Subproject overview | `/projects/subproject1` | `admin` |  |
| Copy project | `/projects/ecookbook/copy` | `admin` |  |
| Activity | `/projects/ecookbook/activity` | `admin` |  |
| Roadmap | `/projects/ecookbook/roadmap` | `admin` |  |
| Version | `/versions/2` | `admin` |  |
| New version | `/projects/ecookbook/versions/new` | `admin` |  |
| Edit version | `/versions/2/edit` | `admin` |  |
| Project settings | `/projects/ecookbook/settings` | `admin` |  |
| Project settings: modules | `/projects/ecookbook/settings/modules` | `admin` |  |
| Project settings: members | `/projects/ecookbook/settings/members` | `admin` |  |
| Project settings: versions | `/projects/ecookbook/settings/versions` | `admin` |  |
| Project settings: issue categories | `/projects/ecookbook/settings/categories` | `admin` |  |
| Search results | `/search?q=issue` | `admin` |  |
| Search results (all types) | `/search?q=cookbook&all_words=1&titles_only=0&issues=1&news=1&documents=1&changesets=1&wiki_pages=1&messages=1&projects=1` | `admin` |  |
| Projects as a board | `/projects?display_type=board` | `admin` |  |
| Projects as a list | `/projects?display_type=list` | `admin` |  |
| New subproject | `/projects/new?parent_id=ecookbook` | `admin` |  |
| Overview of another project | `/projects/onlinestore` | `admin` |  |
| Overview of a private subproject | `/projects/private-child` | `admin` |  |
| Project overview as a member | `/projects/ecookbook` | `jsmith` |  |
| Project overview, signed out | `/projects/ecookbook` | 匿名ユーザー |  |
| Project settings: issue tracking | `/projects/ecookbook/settings/issues` | `admin` |  |
| Project settings: forums | `/projects/ecookbook/settings/boards` | `admin` |  |
| Project settings: time tracking | `/projects/ecookbook/settings/activities` | `admin` |  |
| New member | `/projects/ecookbook/memberships/new` | `admin` |  |
| Edit member | `/memberships/1/edit` | `admin` |  |
| New issue category | `/projects/ecookbook/issue_categories/new` | `admin` |  |
| Edit issue category | `/issue_categories/1/edit` | `admin` |  |
| Closed version | `/versions/1` | `admin` |  |
| Open version | `/versions/3` | `admin` |  |
| Search without results | `/search?q=zzzz` | `admin` |  |
| Search in a project and its subprojects | `/projects/ecookbook/search?q=issue&scope=subprojects` | `admin` |  |

<a id="issues-and-spent-time"></a>

### チケットと作業時間

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Issues | `/projects/ecookbook/issues` | `admin` |  |
| Issues grouped, with totals | `/projects/ecookbook/issues?set_filter=1&f%5B%5D=&group_by=status&t%5B%5D=estimated_hours&t%5B%5D=spent_hours&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=estimated_hours&c%5B%5D=spent_hours` | `admin` |  |
| Issues of all projects | `/issues` | `admin` |  |
| Issue | `/issues/1` | `admin` |  |
| Issue with related issues | `/issues/2` | `admin` |  |
| Closed issue | `/issues/8` | `admin` |  |
| Private issue | `/issues/14` | `admin` |  |
| New issue | `/projects/ecookbook/issues/new` | `admin` |  |
| Edit issue | `/issues/1/edit` | `admin` |  |
| Copy issue | `/projects/ecookbook/issues/1/copy` | `admin` |  |
| Bulk edit | `/issues/bulk_edit?ids%5B%5D=1&ids%5B%5D=2` | `admin` |  |
| Context menu | `/issues/context_menu?ids%5B%5D=1&ids%5B%5D=2` | `admin` |  |
| New query | `/projects/ecookbook/queries/new` | `admin` |  |
| Import issues | `/issues/imports/new?project_id=ecookbook` | `admin` |  |
| Gantt chart | `/projects/ecookbook/issues/gantt` | `admin` |  |
| Calendar | `/projects/ecookbook/issues/calendar` | `admin` |  |
| Issue summary | `/projects/ecookbook/issues/report` | `admin` |  |
| Spent time | `/projects/ecookbook/time_entries` | `admin` |  |
| Spent time report | `/projects/ecookbook/time_entries/report?columns=month&criteria%5B%5D=user` | `admin` |  |
| Log time | `/projects/ecookbook/time_entries/new` | `admin` |  |
| Edit spent time | `/time_entries/1/edit` | `admin` |  |
| New issue: another tracker | `/projects/ecookbook/issues/new?issue%5Btracker_id%5D=2` | `admin` |  |
| Issue with associated revisions | `/issues/3` | `admin` |  |
| Issue of another project | `/issues/4` | `admin` |  |
| Issue as a member | `/issues/1` | `jsmith` |  |
| Issue, signed out | `/issues/1` | 匿名ユーザー |  |
| Description diff | `/journals/3/diff?detail_id=4` | `admin` |  |
| Saved query | `/projects/ecookbook/issues?query_id=1` | `admin` |  |
| Issues grouped by a custom field | `/issues?query_id=9` | `admin` |  |
| Issues with description and last notes | `/issues?set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=subject&c%5B%5D=description&c%5B%5D=last_notes` | `admin` |  |
| Issues: nothing found | `/projects/ecookbook/issues?set_filter=1&f%5B%5D=subject&op%5Bsubject%5D=~&v%5Bsubject%5D%5B%5D=zzzz` | `admin` |  |
| Issue summary details | `/projects/ecookbook/issues/report/tracker` | `admin` |  |
| Edit query | `/queries/1/edit` | `admin` |  |
| New spent time query | `/queries/new?type=TimeEntryQuery` | `admin` |  |
| New project query | `/queries/new?type=ProjectQuery` | `admin` |  |
| New user query | `/queries/new?type=UserQuery` | `admin` |  |
| Bulk edit spent time | `/time_entries/bulk_edit?ids%5B%5D=1&ids%5B%5D=2` | `admin` |  |
| Spent time report by project and user | `/time_entries/report?columns=month&criteria%5B%5D=project&criteria%5B%5D=user` | `admin` |  |
| Import spent time | `/time_entries/imports/new?project_id=ecookbook` | `admin` |  |
| Edit attachments | `/attachments/issues/3/edit` | `admin` |  |

<a id="wiki-news-documents-files-and-forums"></a>

### wiki、ニュース、文書、ファイル、フォーラム

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Wiki page | `/projects/ecookbook/wiki` | `admin` |  |
| Wiki page with sections | `/projects/ecookbook/wiki/Page_with_sections` | `admin` |  |
| Wiki page with an inline image | `/projects/ecookbook/wiki/Page_with_an_inline_image` | `admin` |  |
| Wiki edit | `/projects/ecookbook/wiki/CookBook_documentation/edit` | `admin` |  |
| Wiki history | `/projects/ecookbook/wiki/CookBook_documentation/history` | `admin` |  |
| Wiki diff | `/projects/ecookbook/wiki/CookBook_documentation/2/diff` | `admin` |  |
| Wiki annotate | `/projects/ecookbook/wiki/CookBook_documentation/2/annotate` | `admin` |  |
| Wiki rename | `/projects/ecookbook/wiki/Another_page/rename` | `admin` |  |
| Wiki index | `/projects/ecookbook/wiki/index` | `admin` |  |
| Wiki index by date | `/projects/ecookbook/wiki/date_index` | `admin` |  |
| News | `/projects/ecookbook/news` | `admin` |  |
| News item | `/news/1` | `admin` |  |
| New news | `/projects/ecookbook/news/new` | `admin` |  |
| Documents | `/projects/ecookbook/documents` | `admin` |  |
| Document | `/documents/1` | `admin` |  |
| New document | `/projects/ecookbook/documents/new` | `admin` |  |
| Files | `/projects/ecookbook/files` | `admin` |  |
| New file | `/projects/ecookbook/files/new` | `admin` |  |
| Forums | `/projects/ecookbook/boards` | `admin` |  |
| Forum | `/projects/ecookbook/boards/1` | `admin` |  |
| Forum topic | `/boards/1/topics/1` | `admin` |  |
| New forum topic | `/boards/1/topics/new` | `admin` |  |
| New wiki page | `/projects/ecookbook/wiki/new` | `admin` |  |
| Old version of a wiki page | `/projects/ecookbook/wiki/CookBook_documentation/1` | `admin` |  |
| Wiki page with child pages | `/projects/ecookbook/wiki/Another_page` | `admin` |  |
| Wiki child page | `/projects/ecookbook/wiki/Child_1` | `admin` |  |
| Wiki export | `/projects/ecookbook/wiki/export` | `admin` |  |
| Wiki page, signed out | `/projects/ecookbook/wiki` | 匿名ユーザー |  |
| News of all projects | `/news` | `admin` |  |
| Edit news | `/news/1/edit` | `admin` |  |
| Edit document | `/documents/1/edit` | `admin` |  |
| New forum | `/projects/ecookbook/boards/new` | `admin` |  |
| Edit forum | `/projects/ecookbook/boards/1/edit` | `admin` |  |
| Forum topic with replies | `/boards/1/topics/2` | `admin` |  |
| Edit forum topic | `/boards/1/topics/1/edit` | `admin` |  |
| Attachment: source file | `/attachments/4` | `admin` |  |
| Attachment: diff | `/attachments/5` | `admin` |  |
| Attachment: image | `/attachments/3` | `admin` |  |
| Attachment: other file | `/attachments/6` | `admin` |  |

<a id="repository"></a>

### リポジトリ

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Repository | `/projects/ecookbook/repository` | `admin` |  |
| Directory | `/projects/ecookbook/repository/<Subversion>/show/subversion_test` | `admin` |  |
| Revisions | `/projects/ecookbook/repository/<Subversion>/revisions` | `admin` |  |
| Revision with related issues | `/projects/ecookbook/repository/<Subversion>/revisions/11` | `admin` |  |
| Revision diff | `/projects/ecookbook/repository/<Subversion>/revisions/15/diff` | `admin` |  |
| Revision diff, side by side | `/projects/ecookbook/repository/<Subversion>/revisions/15/diff?type=sbs` | `admin` |  |
| Statistics | `/projects/ecookbook/repository/<Subversion>/statistics` | `admin` |  |
| Git repository | `/projects/ecookbook/repository/git` | `admin` |  |
| Git directory | `/projects/ecookbook/repository/git/show/sources` | `admin` |  |
| File with syntax highlighting | `/projects/ecookbook/repository/git/entry/sources/watchers_controller.rb` | `admin` |  |
| Text file | `/projects/ecookbook/repository/git/entry/README` | `admin` |  |
| Image file | `/projects/ecookbook/repository/git/entry/images/edit.png` | `admin` |  |
| Annotate | `/projects/ecookbook/repository/git/annotate/sources/watchers_controller.rb` | `admin` |  |
| File history | `/projects/ecookbook/repository/git/changes/sources/watchers_controller.rb` | `admin` |  |
| Git revisions with the graph | `/projects/ecookbook/repository/git/revisions` | `admin` |  |
| Git revision with every kind of change | `/projects/ecookbook/repository/git/revisions/deff712f…` | `admin` |  |
| Git revision diff | `/projects/ecookbook/repository/git/revisions/deff712f…/diff` | `admin` |  |
| Mercurial revisions with branches | `/projects/ecookbook/repository/mercurial/revisions` | `admin` |  |
| New repository | `/projects/ecookbook/repositories/new` | `admin` |  |
| Edit repository | `/repositories/<Git>/edit` | `admin` |  |
| Project settings: repositories | `/projects/ecookbook/settings/repositories` | `admin` |  |

<a id="account-and-users"></a>

### アカウントとユーザー

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Sign in | `/login` | 匿名ユーザー |  |
| Lost password | `/account/lost_password` | 匿名ユーザー |  |
| Register | `/account/register` | 匿名ユーザー |  |
| My page | `/my/page` | `admin` |  |
| My account | `/my/account` | `admin` |  |
| Change password | `/my/password` | `jsmith` |  |
| User profile | `/users/2` | `admin` |  |
| Confirm password (sudo mode) | `/my/api_key` | `admin` | `sudo: false` |
| Sign in without registration | `/login` | 匿名ユーザー | 設定: `self_registration: "0"` |
| User profile of another user | `/users/3` | `jsmith` |  |

<a id="administration"></a>

### 管理

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Administration | `/admin` | `admin` |  |
| Projects (admin) | `/admin/projects` | `admin` |  |
| Users | `/users` | `admin` |  |
| New user | `/users/new` | `admin` |  |
| Edit user | `/users/2/edit` | `admin` |  |
| Groups | `/groups` | `admin` |  |
| Edit group | `/groups/10/edit` | `admin` |  |
| Roles and permissions | `/roles` | `admin` |  |
| Edit role | `/roles/1/edit` | `admin` |  |
| Permissions report | `/roles/permissions` | `admin` |  |
| Trackers | `/trackers` | `admin` |  |
| Edit tracker | `/trackers/1/edit` | `admin` |  |
| Issue statuses | `/issue_statuses` | `admin` |  |
| Workflow | `/workflows/edit` | `admin` |  |
| Workflow: field permissions | `/workflows/permissions` | `admin` |  |
| Custom fields | `/custom_fields` | `admin` |  |
| New custom field | `/custom_fields/new?type=IssueCustomField` | `admin` |  |
| Edit custom field | `/custom_fields/1/edit` | `admin` |  |
| Enumerations | `/enumerations` | `admin` |  |
| LDAP authentication | `/auth_sources` | `admin` |  |
| Plugins | `/admin/plugins` | `admin` |  |
| Information | `/admin/info` | `admin` |  |
| Webhooks | `/admin/webhooks` | `admin` | 設定: `webhooks_enabled: true` |
| New webhook | `/webhooks/new` | `admin` | 設定: `webhooks_enabled: true` |
| Users: locked | `/users?set_filter=1&f[]=status&op[status]=%3D&v[status][]=3` | `admin` |  |
| Edit user: projects | `/users/2/edit?tab=memberships` | `admin` |  |
| Edit user: groups | `/users/2/edit?tab=groups` | `admin` |  |
| User email addresses | `/users/2/email_addresses` | `admin` |  |
| Add projects to a user | `/users/2/memberships/new` | `admin` |  |
| Import users | `/users/imports/new` | `admin` |  |
| Group | `/groups/10` | `admin` |  |
| New group | `/groups/new` | `admin` |  |
| Edit group: users | `/groups/10/edit?tab=users` | `admin` |  |
| Edit group: projects | `/groups/10/edit?tab=memberships` | `admin` |  |
| New role | `/roles/new` | `admin` |  |
| New tracker | `/trackers/new` | `admin` |  |
| New issue status | `/issue_statuses/new` | `admin` |  |
| Edit issue status | `/issue_statuses/1/edit` | `admin` |  |
| Workflow summary | `/workflows` | `admin` |  |
| Copy workflow | `/workflows/copy` | `admin` |  |
| New custom field: choose the type | `/custom_fields/new` | `admin` |  |
| New enumeration value | `/enumerations/new?type=IssuePriority` | `admin` |  |
| Edit enumeration value | `/enumerations/4/edit` | `admin` |  |
| New LDAP authentication | `/auth_sources/new` | `admin` |  |
| Edit LDAP authentication | `/auth_sources/1/edit` | `admin` |  |

<a id="settings"></a>

### 設定

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Settings: General | `/settings?tab=general` | `admin` |  |
| Settings: Display | `/settings?tab=display` | `admin` |  |
| Settings: Authentication | `/settings?tab=authentication` | `admin` |  |
| Settings: Integrations | `/settings?tab=integrations` | `admin` |  |
| Settings: Projects | `/settings?tab=projects` | `admin` |  |
| Settings: Users | `/settings?tab=users` | `admin` |  |
| Settings: Issue tracking | `/settings?tab=issues` | `admin` |  |
| Settings: Time tracking | `/settings?tab=timelog` | `admin` |  |
| Settings: Files | `/settings?tab=attachments` | `admin` |  |
| Settings: Email notifications | `/settings?tab=notifications` | `admin` |  |
| Settings: Incoming emails | `/settings?tab=mail_handler` | `admin` |  |
| Settings: Repositories | `/settings?tab=repositories` | `admin` |  |

<a id="help"></a>

### ヘルプ

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Wiki syntax quick reference | `/help/wiki_syntax` | `admin` |  |
| Wiki syntax, detailed | `/help/wiki_syntax/detailed` | `admin` |  |
| Code highlighting | `/help/code_highlighting` | `admin` |  |

<a id="errors"></a>

### エラー

| 名前 | 画面 | ユーザー | 備考 |
| --- | --- | --- | --- |
| Not found (404) | `/issues/0` | `admin` | ステータス 404 |
| Forbidden (403) | `/admin` | `dlopper` | ステータス 403 |
| Sign-in required | `/projects/private-child` | 匿名ユーザー |  |
