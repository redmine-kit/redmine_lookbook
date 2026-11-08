# プレビューの一覧

Redmine Lookbook には 143 のプレビューがあります。コンポーネントが 35、画面が 108 です。「名前」は Lookbook のナビゲーションに表示される名前で、「パス」はプレビューの URL の `/lookbook/inspect/` のあとの部分です。

画面のプレビューは、「画面」の列の Redmine の画面を、「ユーザー」の列のユーザーとしてレンダリングします。ユーザーは、`admin`(管理者)、`jsmith` と `dlopper`(プロジェクトのメンバー)、匿名ユーザー(ログインしていない状態)のいずれかです。

この一覧は、`previews/` のファイルから作っています。

<a id="components"></a>

## コンポーネント

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

<a id="forms"></a>

### フォーム

| 名前 | パス |
| --- | --- |
| Form fields | `components/forms/fields` |
| Error messages | `components/forms/errors` |
| Text area with the wiki toolbar | `components/forms/wiki_toolbar` |
| Issue filters | `components/forms/filters` |

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

<a id="navigation"></a>

### ナビゲーション

| 名前 | パス |
| --- | --- |
| Tabs | `components/navigation/tabs` |
| Project menu | `components/navigation/main_menu` |
| Top menu and account menu | `components/navigation/top_menu` |
| Administration menu | `components/navigation/admin_menu` |
| Title with breadcrumbs | `components/navigation/breadcrumbs` |
| Issue sidebar | `components/navigation/sidebar` |

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

<a id="pages"></a>

## 画面

<a id="projects"></a>

### プロジェクト

| 名前 | 画面 | ユーザー |
| --- | --- | --- |
| Home | `/` | `admin` |
| Projects | `/projects` | `admin` |
| New project | `/projects/new` | `admin` |
| Project overview | `/projects/ecookbook` | `admin` |
| Subproject overview | `/projects/subproject1` | `admin` |
| Copy project | `/projects/ecookbook/copy` | `admin` |
| Activity | `/projects/ecookbook/activity` | `admin` |
| Roadmap | `/projects/ecookbook/roadmap` | `admin` |
| Version | `/versions/2` | `admin` |
| New version | `/projects/ecookbook/versions/new` | `admin` |
| Edit version | `/versions/2/edit` | `admin` |
| Project settings | `/projects/ecookbook/settings` | `admin` |
| Project settings: modules | `/projects/ecookbook/settings/modules` | `admin` |
| Project settings: members | `/projects/ecookbook/settings/members` | `admin` |
| Project settings: versions | `/projects/ecookbook/settings/versions` | `admin` |
| Project settings: issue categories | `/projects/ecookbook/settings/categories` | `admin` |
| Search results | `/search?q=issue` | `admin` |
| Search results (all types) | `/search?q=cookbook&all_words=1&titles_only=0&issues=1&news=1&documents=1&changesets=1&wiki_pages=1&messages=1&projects=1` | `admin` |

<a id="issues-and-spent-time"></a>

### チケットと作業時間

| 名前 | 画面 | ユーザー |
| --- | --- | --- |
| Issues | `/projects/ecookbook/issues` | `admin` |
| Issues grouped, with totals | `/projects/ecookbook/issues?set_filter=1&f%5B%5D=&group_by=status&t%5B%5D=estimated_hours&t%5B%5D=spent_hours&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=estimated_hours&c%5B%5D=spent_hours` | `admin` |
| Issues of all projects | `/issues` | `admin` |
| Issue | `/issues/1` | `admin` |
| Issue with related issues | `/issues/2` | `admin` |
| Closed issue | `/issues/8` | `admin` |
| Private issue | `/issues/14` | `admin` |
| New issue | `/projects/ecookbook/issues/new` | `admin` |
| Edit issue | `/issues/1/edit` | `admin` |
| Copy issue | `/projects/ecookbook/issues/1/copy` | `admin` |
| Bulk edit | `/issues/bulk_edit?ids%5B%5D=1&ids%5B%5D=2` | `admin` |
| Context menu | `/issues/context_menu?ids%5B%5D=1&ids%5B%5D=2` | `admin` |
| New query | `/projects/ecookbook/queries/new` | `admin` |
| Import issues | `/projects/ecookbook/issues/imports/new` | `admin` |
| Gantt chart | `/projects/ecookbook/issues/gantt` | `admin` |
| Calendar | `/projects/ecookbook/issues/calendar` | `admin` |
| Issue summary | `/projects/ecookbook/issues/report` | `admin` |
| Spent time | `/projects/ecookbook/time_entries` | `admin` |
| Spent time report | `/projects/ecookbook/time_entries/report?columns=month&criteria%5B%5D=user` | `admin` |
| Log time | `/projects/ecookbook/time_entries/new` | `admin` |
| Edit spent time | `/time_entries/1/edit` | `admin` |

<a id="wiki-news-documents-files-and-forums"></a>

### wiki、ニュース、文書、ファイル、フォーラム

| 名前 | 画面 | ユーザー |
| --- | --- | --- |
| Wiki page | `/projects/ecookbook/wiki` | `admin` |
| Wiki page with sections | `/projects/ecookbook/wiki/Page_with_sections` | `admin` |
| Wiki page with an inline image | `/projects/ecookbook/wiki/Page_with_an_inline_image` | `admin` |
| Wiki edit | `/projects/ecookbook/wiki/CookBook_documentation/edit` | `admin` |
| Wiki history | `/projects/ecookbook/wiki/CookBook_documentation/history` | `admin` |
| Wiki diff | `/projects/ecookbook/wiki/CookBook_documentation/2/diff` | `admin` |
| Wiki annotate | `/projects/ecookbook/wiki/CookBook_documentation/2/annotate` | `admin` |
| Wiki rename | `/projects/ecookbook/wiki/Another_page/rename` | `admin` |
| Wiki index | `/projects/ecookbook/wiki/index` | `admin` |
| Wiki index by date | `/projects/ecookbook/wiki/date_index` | `admin` |
| News | `/projects/ecookbook/news` | `admin` |
| News item | `/news/1` | `admin` |
| New news | `/projects/ecookbook/news/new` | `admin` |
| Documents | `/projects/ecookbook/documents` | `admin` |
| Document | `/documents/1` | `admin` |
| New document | `/projects/ecookbook/documents/new` | `admin` |
| Files | `/projects/ecookbook/files` | `admin` |
| New file | `/projects/ecookbook/files/new` | `admin` |
| Forums | `/projects/ecookbook/boards` | `admin` |
| Forum | `/projects/ecookbook/boards/1` | `admin` |
| Forum topic | `/boards/1/topics/1` | `admin` |
| New forum topic | `/boards/1/topics/new` | `admin` |

<a id="account-and-users"></a>

### アカウントとユーザー

| 名前 | 画面 | ユーザー |
| --- | --- | --- |
| Sign in | `/login` | 匿名ユーザー |
| Lost password | `/account/lost_password` | 匿名ユーザー |
| Register | `/account/register` | 匿名ユーザー |
| My page | `/my/page` | `admin` |
| My account | `/my/account` | `admin` |
| Change password | `/my/password` | `jsmith` |
| User profile | `/users/2` | `admin` |

<a id="administration"></a>

### 管理

| 名前 | 画面 | ユーザー |
| --- | --- | --- |
| Administration | `/admin` | `admin` |
| Projects (admin) | `/admin/projects` | `admin` |
| Users | `/users` | `admin` |
| New user | `/users/new` | `admin` |
| Edit user | `/users/2/edit` | `admin` |
| Groups | `/groups` | `admin` |
| Edit group | `/groups/10/edit` | `admin` |
| Roles and permissions | `/roles` | `admin` |
| Edit role | `/roles/1/edit` | `admin` |
| Permissions report | `/roles/permissions` | `admin` |
| Trackers | `/trackers` | `admin` |
| Edit tracker | `/trackers/1/edit` | `admin` |
| Issue statuses | `/issue_statuses` | `admin` |
| Workflow | `/workflows/edit` | `admin` |
| Workflow: field permissions | `/workflows/permissions` | `admin` |
| Custom fields | `/custom_fields` | `admin` |
| New custom field | `/custom_fields/new?type=IssueCustomField` | `admin` |
| Edit custom field | `/custom_fields/1/edit` | `admin` |
| Enumerations | `/enumerations` | `admin` |
| LDAP authentication | `/auth_sources` | `admin` |
| Plugins | `/admin/plugins` | `admin` |
| Information | `/admin/info` | `admin` |

<a id="settings"></a>

### 設定

| 名前 | 画面 | ユーザー |
| --- | --- | --- |
| Settings: General | `/settings?tab=general` | `admin` |
| Settings: Display | `/settings?tab=display` | `admin` |
| Settings: Authentication | `/settings?tab=authentication` | `admin` |
| Settings: API | `/settings?tab=api` | `admin` |
| Settings: Projects | `/settings?tab=projects` | `admin` |
| Settings: Users | `/settings?tab=users` | `admin` |
| Settings: Issue tracking | `/settings?tab=issues` | `admin` |
| Settings: Time tracking | `/settings?tab=timelog` | `admin` |
| Settings: Files | `/settings?tab=attachments` | `admin` |
| Settings: Email notifications | `/settings?tab=notifications` | `admin` |
| Settings: Incoming emails | `/settings?tab=mail_handler` | `admin` |
| Settings: Repositories | `/settings?tab=repositories` | `admin` |

<a id="help"></a>

### ヘルプ

| 名前 | 画面 | ユーザー |
| --- | --- | --- |
| Wiki syntax quick reference | `/help/wiki_syntax` | `admin` |
| Wiki syntax, detailed | `/help/wiki_syntax/detailed` | `admin` |
| Code highlighting | `/help/code_highlighting` | `admin` |

<a id="errors"></a>

### エラー

| 名前 | 画面 | ユーザー |
| --- | --- | --- |
| Not found (404) | `/issues/0` | `admin` |
| Forbidden (403) | `/admin` | `dlopper` |
| Sign-in required | `/projects/private-child` | 匿名ユーザー |
