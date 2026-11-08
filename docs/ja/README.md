# Redmine Lookbook

[![CI](https://github.com/redmine-theme/redmine_lookbook/actions/workflows/ci.yml/badge.svg)](https://github.com/redmine-theme/redmine_lookbook/actions/workflows/ci.yml)

Redmine Lookbook は、Redmine のコンポーネントと画面を [Lookbook](https://lookbook.build/) で見られるようにするプラグインです。テーマの作者が、Redmine の画面を一つずつ開かなくても、多くの画面、言語、レイアウトでテーマを確認できます。

[English](../../README.md)

> **状態:** 開発の初期段階です(0.1.0)。Redmine 7.0 に対応し、Redmine 7.0.3 で動作を確認しています。

## 機能

- **Redmine がレンダリングしたもの:** コンポーネントは Redmine のヘルパーと部分テンプレートで、画面は Redmine のコントローラーでレンダリングします。手で写した HTML は使いません。
- **多くの画面:** 72 のプレビューがあります。コンポーネントが 21(ボタン、バッジ、フォーム、絞り込み、チケットの一覧と履歴、タブ、カレンダー、差分など)、画面が 51 です。画面には、チケット、ガントチャート、カレンダー、wiki、ニュース、文書、ファイル、フォーラム、作業時間、個人のページ、管理の画面、エラーの画面などがあります。
- **ツールバーでの切り替え:** プレビューを見ながら、テーマ、言語、レイアウトを切り替えられます。既定は Redmine の設定に合わせます。
- **wiki の書式:** CommonMark と Textile のテスト用の文章で、Redmine の書式、Redmine のオブジェクト(チケット、wiki のページ、バージョン、ユーザー、添付ファイル)へのリンク、マクロ(`toc`、`collapse`、`child_pages`、`thumbnail`)を確認できます。書式はプレビューのパラメーターで選びます。Redmine の設定は変えません。
- **テストデータ:** Redmine 自身のテストデータ(`test/fixtures`)で、プロジェクト、チケット、wiki のページなどを表示します。
- **独自のプレビュー:** テーマやプラグインのプレビューを、別のディレクトリから追加できます。

## 動作環境

- Redmine 7.0
- Redmine 7.0 が対応する Ruby
- [Lookbook](https://github.com/lookbook-hq/lookbook) 2.3。Lookbook は、依存関係として [ViewComponent](https://viewcomponent.org/) をインストールします。Redmine Lookbook は、ViewComponent のコンポーネントを使いません。

Redmine Lookbook は、プレビューを見るために用意した Redmine でだけ使ってください(下の「セキュリティ」)。

## Docker でのクイックスタート

```sh
git clone https://github.com/redmine-theme/redmine_lookbook.git
cd redmine_lookbook
docker compose -f docker/compose.yml up --build
```

起動したら <http://127.0.0.1:3000/lookbook> を開きます。すべてのプレビューがレンダリングできるかは、`bin/check-previews` で確認できます。初めて起動したときは、Redmine 7.0.3 をダウンロードして SHA256 を確認し、Redmine のテストデータを読み込んで、Redmine を開発モードで起動します。Redmine そのものには、`admin` / `admin` でログインできます。

| 変数 | 既定値 | 内容 |
| --- | --- | --- |
| `REDMINE_LOOKBOOK_BIND` | `127.0.0.1` | 待ち受けるアドレス。ローカルネットワークの他の端末から見るときは `0.0.0.0` にします。 |
| `REDMINE_LOOKBOOK_PORT` | `3000` | ホスト側のポート。 |
| `REDMINE_LOOKBOOK_THEMES` | `./themes`(`docker/` の下) | プレビューで使うテーマのディレクトリ。テーマごとにディレクトリを分けて置きます。 |

## 既存の Redmine へのインストール

1. 開発モードで動かす Redmine 7.0 の `plugins/redmine_lookbook` に、このリポジトリを配置します。
2. `bundle install` を実行します。Lookbook は、プラグインの `Gemfile` の `development` のグループにあります。
3. Redmine のテストデータを読み込みます。**Redmine のデータベースの行が置き換わる**ので、プレビューを見るために用意した Redmine でだけ実行してください。

   ```sh
   bin/rails redmine_lookbook:load_test_data CONFIRM=yes
   ```

4. Redmine を開発モードで起動し、`/lookbook` を開きます。

## ツールバーの切り替え

| 切り替え | 選択肢 | 既定 |
| --- | --- | --- |
| テーマ | Default と、Redmine が見つけたすべてのテーマ | Default(Redmine の既定のテーマ) |
| 言語 | Default と、Redmine が対応するすべての言語 | Default(管理画面の設定の、Redmine の既定の言語) |
| レイアウト | None(コンポーネントだけ)、Redmine layout | None |

- **レイアウト:** 「None」は、Redmine の CSS、JavaScript、テーマを読み込み、ヘッダー、メニュー、サイドバー、フッターを表示しません。「Redmine layout」は、画面の全体を表示します。
- **右から左に書く言語:** アラビア語やヘブライ語を選ぶと、右から左の表示でテーマを確認できます。

## 自作のテーマのプレビュー

1. テーマを、Redmine の `themes/` のディレクトリに置きます(Docker では `docker/themes/` か、`REDMINE_LOOKBOOK_THEMES` のディレクトリ)。
2. 新しいテーマを Redmine に認識させるため、Redmine を再起動し、ツールバーでそのテーマを選びます。
3. テーマを編集し、プレビューを再読み込みします。

## プレビューを書く

プレビューは [Lookbook のプレビュー](https://lookbook.build/guide/previews)です。プレビューのテンプレートの中では、Redmine のヘルパーを使えます。

**コンポーネント:**

```ruby
# previews/components/badges_preview.rb
module Components
  class BadgesPreview < Lookbook::Preview
    # @label Badges
    def default
      render_with_template
    end
  end
end
```

```erb
<%# previews/components/badges_preview/default.html.erb %>
<span class="badge badge-private"><%= l(:field_is_private) %></span>
```

**画面:** `RedmineLookbook::PagePreview` を include し、Redmine の画面のパスを渡します。画面は、渡したユーザー(`:admin`、`:anonymous`、またはログイン名)として、Redmine がレンダリングします。

```ruby
# previews/pages/my_plugin_preview.rb
module Pages
  class MyPluginPreview < Lookbook::Preview
    include RedmineLookbook::PagePreview

    # @label My plugin settings
    def settings
      render_page("/settings/plugin/my_plugin", user: :admin)
    end
  end
end
```

プレビューを、このリポジトリの外(たとえば、テーマの中)に置くときは、そのディレクトリを `REDMINE_LOOKBOOK_PREVIEW_PATHS` に `:` で区切って書きます。

## 設定

| 環境変数 | 既定値 | 内容 |
| --- | --- | --- |
| `REDMINE_LOOKBOOK` | 開発モードでは `1`、ほかは `0` | プレビューを有効(`1`)か無効(`0`)にします。 |
| `REDMINE_LOOKBOOK_PATH` | `/lookbook` | Lookbook を置くパス。 |
| `REDMINE_LOOKBOOK_PREVIEW_PATHS` | なし | 追加するプレビューのディレクトリ。`:` で区切ります。 |
| `REDMINE_LOOKBOOK_SERVERS` | なし | このプラグインをインストールしたほかの Redmine のサーバー。`名前=URL,名前=URL` の形式で指定します。指定すると、ツールバーに「Server」の切り替えが表示され、選んだサーバーで同じプレビューを開きます。 |

## 仕組み

- **コンポーネント:** Lookbook は、`RedmineLookbook::PreviewsController` でプレビューをレンダリングします。このコントローラーは Redmine の `ApplicationController` を継承しているので、Redmine のヘルパー、レイアウト、テーマの仕組みを使えます。
- **画面:** 画面のプレビューは、Rails のアプリケーションの中で GET のリクエストを送り、Redmine が返した HTML を表示します。そのリクエストのユーザー、テーマ、言語は、Rack の env のキーで渡します。このキーは、同じプロセスの中のコードだけが設定できます。HTTP のヘッダーは `HTTP_*` のキーになるので、外部からは設定できません。
- **テーマと言語:** 選んだテーマは Redmine の `current_theme` と同じ方法で、選んだ言語は Redmine の言語の仕組みで適用します。データベースの中の Redmine の設定は変えません。

## セキュリティ

- **開発環境専用:** 本番のサーバーでは、決して有効にしないでください。`/lookbook` を開ける人は、管理者としてレンダリングした画面を見られます。Lookbook には、ログインの仕組みがありません。
- **外部に公開しない:** Docker の設定は、既定では `127.0.0.1` でだけ待ち受けます。ローカルネットワークに開くのは、そのネットワークのだれにデータを見られてもよいときだけにしてください。
- **テストデータは既存のデータを置き換える:** `redmine_lookbook:load_test_data` は、Redmine のテストデータに含まれるテーブルの行を置き換えます。本番では動かず、`CONFIRM=yes` を付けたときだけ動きます。

脆弱性の報告の方法は、[SECURITY.md](../../SECURITY.md) を参照してください。

## 制限事項

- 対応するのは Redmine 7.0 だけです。
- プレビューをレンダリングするコントローラーは、Lookbook のプレビューのコントローラーの内部のメソッドのいくつかを、同じ内容で実装しています(Lookbook 2.3)。Lookbook の今後のリリースで、修正が必要になる可能性があります。
- 画面のプレビューは GET のリクエストだけを使うので、画面を最初に開いたときの状態(たとえば、送信する前のフォーム)を表示します。
- プレビューの中の画像やファイル(添付ファイル、サムネイル)は、ブラウザーが Redmine から直接読み込みます。非公開のプロジェクトや非公開のチケットのファイルは、同じブラウザーで Redmine にログインしているときだけ表示されます。
- Redmine のテストデータには、ファイルのない画像の添付ファイルがあります。`redmine_lookbook:load_test_data` は、テストデータの画像を元に、その画像のファイルを作成します。

## ライセンス

Redmine Lookbook は、GNU General Public License バージョン 2 またはそれ以降のバージョンで公開しています。[LICENSE](../../LICENSE) を参照してください。

- Redmine は Jean-Philippe Lang の著作物で、GPL で公開されています。
- Lookbook は MIT License で公開されています。
