# プレビューを書く

プレビューは [Lookbook のプレビュー](https://lookbook.build/guide/previews)です。Ruby のクラスのメソッドが一つずつのプレビューになり、それぞれに ERB のテンプレートがあります。テンプレートの中では Redmine のヘルパーを使え、データベースには Redmine のテストデータがあります。

<a id="where-previews-go"></a>

## プレビューの置き場所

| ディレクトリ | 内容 |
| --- | --- |
| `previews/components/` | 組み込みのコンポーネントのプレビュー(`Components::*Preview`) |
| `previews/pages/` | 組み込みの画面のプレビュー(`Pages::*Preview`) |
| `REDMINE_LOOKBOOK_PREVIEW_PATHS` のディレクトリ | 独自のプレビュー(たとえば、テーマのリポジトリの中) |

このリポジトリの外にプレビューを置くときは、そのディレクトリを `REDMINE_LOOKBOOK_PREVIEW_PATHS` に `:` で区切って書きます。そのディレクトリの中も同じ構成にします。1 つのファイルに 1 つのクラスを、パスに合わせた名前で書き(`components/my_theme_preview.rb` には `Components::MyThemePreview`)、テンプレートは同じ名前のディレクトリに置きます。

開発モードでは、ファイルを変更すると、Redmine がプレビューを読み込み直します。

<a id="a-component"></a>

## コンポーネント

コンポーネントのプレビューは、Redmine のヘルパーを使うテンプレートをレンダリングします。

```ruby
# previews/components/my_theme_preview.rb
module Components
  class MyThemePreview < Lookbook::Preview
    # @label Badges
    def badges
      render_with_template
    end
  end
end
```

```erb
<%# previews/components/my_theme_preview/badges.html.erb %>
<span class="badge badge-private"><%= l(:field_is_private) %></span>
<span class="badge badge-status-closed"><%= l(:label_closed_issues) %></span>
```

- **レイアウト:** 「None」では、Redmine の CSS、JavaScript、テーマを読み込み、Redmine のヘッダー、メニュー、サイドバー、フッターのない画面でテンプレートをレンダリングします。「Redmine layout」では、Redmine のレイアウトの中でレンダリングします。
- **ユーザー:** コンポーネントのプレビューは、最初の有効な管理者としてレンダリングするので、権限が必要なリンクも表示されます。
- **ヘルパー:** プレビューのコントローラーには、Redmine の `ApplicationHelper` に加えて、Redmine のチケットの画面のヘルパー(`issues`、`journals`、`projects`、`custom_fields`、`issue_relations`、`watchers`、`attachments`、`queries`、`repositories`、`timelog`、`versions`)と `activities` があります。`helper :all` は使いません。Redmine のヘルパーには同じメソッドを定義し直すものがあり、チケットの一覧のセルが空になるためです。
- **インスタンス変数:** Redmine の部分テンプレートには、`@project` や `@issue` などのインスタンス変数を必要とするものがあります。部分テンプレートをレンダリングする前に、テンプレートの中で設定してください。

<a id="a-page"></a>

## 画面

画面のプレビューは、Redmine のコントローラーで Redmine の画面をレンダリングします。`RedmineLookbook::PagePreview` を include し、画面のパスを渡して `render_page` を呼びます。

```ruby
# previews/pages/my_plugin_preview.rb
module Pages
  class MyPluginPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label My plugin settings
    def settings
      render_page("/settings/plugin/my_plugin", user: :admin)
    end

    # @label My plugin, as a project member
    def project_tab
      render_page(user: "jsmith") { "/projects/#{RedmineLookbook::TestData.project.identifier}/my_plugin" }
    end
  end
end
```

- **パス:** 文字列か、プレビューをレンダリングするときにパスを返すブロックで渡します(テストデータを検索するとき)。
- **ユーザー:** `:admin`(既定: 最初の有効な管理者)、`:anonymous`(ログインしていない状態)、または `"jsmith"` のようなログイン名です。
- **リダイレクト:** 同じホストへのリダイレクトを、3 回までたどります。
- **ツールバー:** テーマと言語の切り替えが、画面に適用されます。「None」では、画面から Redmine のヘッダー、メニュー、サイドバー、フッターを取り除きます。

画面のプレビューは GET のリクエストを送るので、画面を最初に開いたときの状態を表示します([仕組み](how-it-works.md#pages))。

<a id="test-data"></a>

## テストデータ

`RedmineLookbook::TestData` は、Redmine のテストデータのレコードを返します。

| メソッド | レコード |
| --- | --- |
| `TestData.project` | 「eCookbook」のプロジェクト(`ecookbook`) |
| `TestData.issue` | そのプロジェクトのチケット |
| `TestData.version` | そのプロジェクトのバージョン |
| `TestData.wiki_page` | そのプロジェクトの wiki のページ |
| `TestData.news`、`TestData.document`、`TestData.board`、`TestData.topic` | ニュース、文書、フォーラム、フォーラムのトピック |
| `TestData.user` | ユーザー `jsmith` |

テストデータを読み込んでいないときは `nil` を返します。そのときは、組み込みのプレビューと同じように、エラーにせずメッセージを表示してください。

<a id="settings-for-one-preview"></a>

## プレビューごとの設定

`RedmineLookbook::SettingsOverride.with` は、ブロックをレンダリングするあいだだけ、Redmine の設定の一部を変えます。データベースの中の Redmine の設定は変わりません。

```erb
<%= RedmineLookbook::SettingsOverride.with(thumbnails_enabled: true) {
      link_to_attachments(issue, thumbnails: true)
    } %>
```

| 設定 | 値 |
| --- | --- |
| `text_formatting` | `"common_mark"` か `"textile"` |
| `ui_theme` | テーマの id。ツールバーのテーマの切り替えは、この設定を使います。 |
| `thumbnails_enabled` | `true` か `false` |

今のところ、ほかの設定はこの方法では変えられません。

<a id="wiki-text"></a>

## wiki のテキスト

`RedmineLookbook::TextFormatting` は、選んだ書式で wiki のテキストをレンダリングします。

```erb
<% RedmineLookbook::TextFormatting.with("textile") do %>
  <div class="wiki"><%= textilizable("h2. A heading\n\n*Bold* text") %></div>
<% end %>
```

`TextFormatting.sample("common_mark")` と `TextFormatting.sample("textile")` は、「Wiki formatting」のプレビューのテスト用の文章を返します。

<a id="parameters"></a>

## パラメーター

Lookbook の[動的なパラメーター](https://lookbook.build/guide/previews/params)は、通常どおり使えます。「Wiki formatting」のプレビューは、パラメーターで書式を選びます。

```ruby
# @label Wiki formatting
# @param format select { choices: [common_mark, textile] }
def wiki(format: "common_mark")
  render_with_template(locals: { format: format })
end
```

<a id="checking-previews"></a>

## プレビューの確認

プレビューを追加したら、開発用の Redmine に対して `bin/check-previews` を実行します([インストール](installation.md#checking-the-previews))。
