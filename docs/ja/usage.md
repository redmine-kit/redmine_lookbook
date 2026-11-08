# プレビューの使い方

`/lookbook`(たとえば <http://127.0.0.1:3000/lookbook>)を開きます。ナビゲーションには、プレビューが 2 つのグループに分かれて表示されます。

- **Components:** Redmine の画面の部品(ボタン、フォーム、チケットの一覧、メニューなど)です。Redmine のヘルパーと部分テンプレートでレンダリングします。「Layout」のグループには Redmine のレイアウトの部品と、見本の内容を入れたレイアウトの全体が、「Menus」のグループにはクリックしたあとのように開いたメニューがあります。
- **Pages:** Redmine の画面の全体です。Redmine のコントローラーでレンダリングします。

すべてのプレビューは、[プレビューの一覧](previews.md)にあります。

<a id="toolbar-options"></a>

## ツールバーの切り替え

ツールバーの表示オプションは、すべてのプレビューに適用されます。

| 切り替え | 選択肢 | 既定 |
| --- | --- | --- |
| Theme | Default と、Redmine が見つけたすべてのテーマ | Default: Redmine のテーマの設定 |
| Language | Default と、Redmine が対応するすべての言語 | Default: 管理画面の設定の、Redmine の既定の言語 |
| Layout | None(コンポーネントだけ)、Redmine layout | None |

- **テーマ:** 選んだテーマは、そのプレビューのリクエストにだけ使います。データベースの中の Redmine の設定は変わりません。
- **レイアウト:** 「None」は、Redmine の CSS、JavaScript、テーマを読み込み、ヘッダー、メニュー、サイドバー、フッターを表示しません。「Redmine layout」は、Redmine と同じように画面の全体を表示します。コンポーネントの「Layout」と「Menus」のグループは、常に Redmine のレイアウトと同じ形でレンダリングするので、この切り替えでは変わりません。
- **サーバー:** `REDMINE_LOOKBOOK_SERVERS` を設定すると、「Server」の切り替えで、同じプレビューを別の Redmine がレンダリングしたものを表示できます([設定](configuration.md#several-servers))。

<a id="checking-a-theme"></a>

## テーマの確認

1. テーマを、Redmine の `themes/` のディレクトリに置きます(Docker では `docker/themes/` か、`REDMINE_LOOKBOOK_THEMES` のディレクトリ)。
2. Redmine を再起動します。Redmine はテーマのファイルを起動のときに登録するので、新しいテーマには再起動が必要です([Redmine 7 のテーマ](themes.md#restart-and-reload))。
3. ツールバーでそのテーマを選びます。
4. テーマを編集し、プレビューを再読み込みします。

テーマが対応する必要のある項目は、[テーマのチェックリスト](theme-checklist.md)で順に確認できます。

<a id="right-to-left-languages"></a>

## 右から左に書く言語

言語の切り替えでアラビア語、ペルシア語、ヘブライ語を選ぶと、右から左の表示でテーマを確認できます。これらの言語では、Redmine は `<html>` に `dir="rtl"` を付けます。

<a id="narrow-screens"></a>

## 狭い画面

Redmine の `responsive.css` は、幅が 900 ピクセルより狭いときのレイアウトを変えます。次のどちらかの方法で確認できます。

- Lookbook のプレビュー欄の、大きさを変えるハンドルをドラッグします。
- プレビューを単独で開き(プレビューの URL は `/lookbook/preview/` で始まります)、ブラウザーの開発者ツールのレスポンシブのモードを使います。

狭い画面のメニューとサイドバーは、「Redmine layout」で確認します。

<a id="printing"></a>

## 印刷

Redmine の `application.css` には、印刷用のスタイル(`@media print`)があります。画面のプレビューを「Redmine layout」で単独で開き、ブラウザーの印刷プレビューで確認します。

<a id="wiki-formatting"></a>

## wiki の書式

「Wiki formatting」のコンポーネントには、`format` のパラメーターがあります。CommonMark(Redmine 7 の既定)か Textile を、プレビューの Params のパネルで選びます。Redmine のテキストの書式の設定は変わりません。

テスト用の文章には、文字の書式、引用、リスト、テーブル、シンタックスハイライトのあるコードブロック、画像、すべての段階の見出しがあり、CommonMark では脚注、タスクリスト、アラートもあります。Redmine のオブジェクト(チケット、注記、wiki のページ、バージョン、プロジェクト、文書、ニュース、フォーラム、ユーザー、添付ファイル)へのリンクと、マクロ `toc`、`issue`、`collapse`、`child_pages`、`thumbnail` もあります。

<a id="images-and-files"></a>

## 画像とファイル

プレビューの中の画像やファイル(添付ファイル、サムネイル、アバター)は、ブラウザーが Redmine から直接読み込みます。非公開のプロジェクトや非公開のチケットのファイルは、同じブラウザーで Redmine にログインしているときだけ表示されます。
