# 仕組み

Redmine Lookbook は、3 つの所で Lookbook と Redmine をつなぎます。プレビューをレンダリングするコントローラー、画面のプレビューの内部のリクエスト、ツールバーの切り替えのための設定の上書きです。

<a id="loading"></a>

## 読み込み

- **有効かどうか:** Lookbook の gem がインストールされ、`REDMINE_LOOKBOOK` が `1`(開発モードの既定)のとき、このプラグインは有効です。
- **準備:** Redmine は、プラグインの `init.rb` を、Rails のオートローダーの準備のあとの `to_prepare` のコールバックで実行し、開発モードではコードを読み込み直すたびに再び実行します。Lookbook はプレビューがオートロードされることを前提にしているので、このプラグインは、プレビューとプレビューのコントローラーを自身で読み込みます。
- **無効のときは何もしない:** プレビューのコントローラーと画面のコンポーネントは Lookbook と ViewComponent を参照するので、Redmine がオートロードするディレクトリの外の `lookbook/` に置いています。プラグインが無効のときは何も Lookbook を参照しないので、本番の Redmine は Lookbook なしで eager load できます。

<a id="components"></a>

## コンポーネント

Lookbook は、`RedmineLookbook::PreviewsController` でプレビューをレンダリングします。このコントローラーは Redmine の `ApplicationController` を継承しているので、Redmine のヘルパー、レイアウト、テーマの仕組みが、Redmine 自身の画面と同じように動きます。

- **レイアウト:** 「None」では、Redmine の CSS、JavaScript、テーマを読み込み、Redmine のヘッダー、メニュー、サイドバー、フッターのないレイアウトを使います。「Redmine layout」では、Redmine の `base` のレイアウトを使います。
- **ユーザー:** 最初の有効な管理者としてレンダリングします。
- **言語とテーマ:** 言語はレンダリングのあいだだけ設定し、テーマは設定の上書き(下記)で適用します。
- **1 回のレンダリング:** プレビューはレイアウトと一緒に 1 回でレンダリングします(Lookbook の `preview_single_pass_rendering`)。Redmine のヘルパーの `content_for :header_tags` が、レイアウトの `<head>` に届くようにするためです。
- **レイアウトの部品:** 「Layout」と「Menus」のプレビューは、`redmine_lookbook/bare` のレイアウトを使います。このレイアウトは、Redmine の base のレイアウトのヘッダーやメニューと同じように、プレビューを `#wrapper` の直下に置きます。

<a id="pages"></a>

## 画面

画面のプレビューは、Rails のアプリケーションの中で GET のリクエストを送り(`Rails.application.call`)、Redmine が返した HTML を表示します。

- **ユーザー、テーマ、言語:** リクエストの Rack の env のキー(`redmine_lookbook.user`、`redmine_lookbook.theme`、`redmine_lookbook.locale`)で渡します。Redmine の `ApplicationController` へのパッチがこれを読み、そのリクエストだけ、指定したユーザーでログインし、言語を設定し、テーマを適用します。このキーは、同じプロセスの中のコードだけが設定できます。HTTP のヘッダーは `HTTP_*` のキーになるので、外部からのリクエストでは設定できません。
- **Source の欄:** `render_page` は、テンプレートをレンダリングする代わりにコンポーネント(`RedmineLookbook::PageComponent`)を返します。そのため、Lookbook の Source の欄には、画面のパスを含むプレビューのメソッド(たとえば `render_page("/issues/1", user: :admin)`)が表示されます。
- **リダイレクト:** 同じホストへのリダイレクトを、3 回までたどります。
- **設定とステータス:** リクエストは、プレビューが渡す設定(下記)で動きます。最後の HTTP のステータスがプレビューの期待と違うときは、プレビューのレスポンスに `X-Redmine-Lookbook-Unexpected-Status` のヘッダーを付け、`bin/check-previews` がそれを表示します。
- **コードの再読み込み:** 開発モードでも、内部のリクエストでは変更したコードを読み込み直しません。プレビュー自身のリクエストがすでに読み込み直しており、その途中で読み込み直すと、使っている定数が取り除かれてしまうためです。
- **状態:** 内部のリクエストのあと、プレビュー自身のリクエストの `User.current` と言語を元に戻します。
- **レイアウト:** 「None」では、HTML からヘッダー、メニュー、サイドバー、フッター、フライアウトメニューを取り除き、`#main` に `nosidebar` のクラスを付けます。

<a id="settings-overrides"></a>

## 設定の上書き

ツールバーのテーマ、wiki の書式のパラメーター、画面のプレビューの `settings:` は、1 回のレンダリングのあいだだけ Redmine の設定を変えます。`RedmineLookbook::SettingsOverride` は `Setting` に prepend され、Redmine のすべての設定の読み出し(`Setting.ui_theme`、`Setting.thumbnails_enabled?` など)が使う `Setting[]` を置き換えて、今のスレッドに値があればその値を返します。データベースの中の Redmine の設定は変わりません。

Redmine は、いくつかの所(スタイルシート、アイコン、ファビコン、`<body>` の `theme-*` のクラス)で `Setting.ui_theme` からテーマを読みます。そのため、この設定を上書きすると、Redmine 自身と同じように、すべての所にテーマが適用されます。

<a id="test-repositories"></a>

## テスト用のリポジトリ

`RedmineLookbook::TestRepositories` は、Redmine の `rake test:scm:setup` と同じように、Redmine のテストのリポジトリを `tmp/test/` に作ります。Subversion は `svnadmin load`、Mercurial はバンドルからの `hg pull`、Git は `tar` で作ります。Subversion のリポジトリは、Redmine のテストデータが参照するものです。Git と Mercurial のリポジトリは、Redmine のリポジトリのテストと同じく、パスの文字コードを ISO-8859-1 にして eCookbook に追加します。Redmine がリビジョンを読み込み(`fetch_changesets`)、メッセージからチケットに関連付けます(`scan_comment_for_issue_ids`)。

<a id="toolbar-options"></a>

## ツールバーの切り替え

テーマ、言語、レイアウトの切り替えは、Lookbook の[表示オプション](https://lookbook.build/guide/previews/display-options)です。言語の名前は Redmine の翻訳から取るので、言語の選択肢は Rails の起動のあとで作ります。

<a id="lookbooks-ui-on-ipad-and-iphone"></a>

## iPad と iPhone での Lookbook の画面

Lookbook は、画面の高さを `100vh` で決めています。Safari は、ツールバーの裏の部分も `100vh` に含めるので、画面の下が隠れていました。このプラグインは、Lookbook の部分テンプレート `lookbook/partials/_user_styles.html.erb` を置き換え、同じ高さを `100dvh` で指定します。Lookbook のユーザーのスタイルは、これまでどおり出力します。

<a id="limitations"></a>

## 制限事項

- 対応するのは Redmine 7.0 だけです。
- プレビューのコントローラーは、Lookbook のプレビューのコントローラーの内部のメソッドのいくつかを同じ内容で実装し、このプラグインは Lookbook の部分テンプレートを 1 つ置き換えています(Lookbook 2.3)。Lookbook の今後のリリースで、修正が必要になる可能性があります。
- 画面のプレビューは GET のリクエストだけを使うので、画面を最初に開いたときの状態を表示します。
