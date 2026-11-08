# Redmine Lookbook

Redmine Lookbook は、Redmine のコンポーネントと画面を [Lookbook](https://lookbook.build/) で見られるようにするプラグインです。テーマの作者が、Redmine の画面を一つずつ開かなくても、多くの画面、言語、レイアウトでテーマを確認できます。

[English](../../README.md)

> **状態:** 作り始めの段階です(0.1.0)。Redmine 7.0 に対応し、Redmine 7.0.3 で動作を確認しています。

## 機能

- **Redmine がレンダリングしたもの:** コンポーネントは Redmine のヘルパーと部分テンプレートで、画面は Redmine のコントローラーでレンダリングします。手で写した HTML は使いません。
- **多くの画面:** 58 のプレビューがあります。チケット、ガントチャート、カレンダー、wiki、ニュース、文書、ファイル、フォーラム、作業時間、個人のページ、管理の画面、エラーの画面などです。
- **ツールバーでの切り替え:** プレビューを見ながら、テーマ、言語、レイアウトを切り替えられます。既定は Redmine の設定に合わせます。
- **テストのデータ:** Redmine 自身のテストのデータ(`test/fixtures`)で、プロジェクト、チケット、wiki のページなどを画面に出します。
- **自分のプレビュー:** テーマやプラグインのプレビューを、別のディレクトリから足せます。

## 動作環境

- Redmine 7.0
- Redmine 7.0 が対応する Ruby
- [Lookbook](https://github.com/lookbook-hq/lookbook) 2.3。Lookbook は、依存として [ViewComponent](https://viewcomponent.org/) を入れます。Redmine Lookbook は、ViewComponent のコンポーネントは使いません。

Redmine Lookbook は、プレビューを見るために用意した Redmine でだけ使ってください(下の「セキュリティ」)。

## Docker でのクイックスタート

```sh
git clone https://github.com/redmine-theme/redmine_lookbook.git
cd redmine_lookbook
docker compose -f docker/compose.yml up --build
```

起動したら <http://127.0.0.1:3000/lookbook> を開きます。すべてのプレビューがレンダリングできるかは、`bin/check-previews` で確認できます。初めて起動したときは、Redmine 7.0.3 を取ってきて(SHA256 を確認する)、Redmine のテストのデータを入れ、Redmine を開発のモードで起動します。Redmine そのものには、`admin` / `admin` でログインできます。

| 変数 | 既定値 | 内容 |
| --- | --- | --- |
| `REDMINE_LOOKBOOK_BIND` | `127.0.0.1` | 待ち受けるアドレス。ローカルネットワークの他の端末から見るときは `0.0.0.0` にします。 |
| `REDMINE_LOOKBOOK_PORT` | `3000` | 手元の端末のポート。 |
| `REDMINE_LOOKBOOK_THEMES` | `./themes`(`docker/` の下) | プレビューで使うテーマのディレクトリ。テーマごとにディレクトリを分けて置きます。 |

## 既存の Redmine へのインストール

1. 開発のモードで動かす Redmine 7.0 の `plugins/redmine_lookbook` に、このリポジトリを置きます。
2. `bundle install` を実行します。Lookbook は、プラグインの `Gemfile` の `development` のグループにあります。
3. Redmine のテストのデータを入れます。**Redmine のデータベースの行が置き換わる**ので、プレビューを見るために用意した Redmine でだけ行ってください。

   ```sh
   bin/rails redmine_lookbook:load_test_data CONFIRM=yes
   ```

4. Redmine を開発のモードで起動し、`/lookbook` を開きます。

## ツールバーの切り替え

| 切り替え | 選べるもの | 既定 |
| --- | --- | --- |
| テーマ | Default と、Redmine が見つけたすべてのテーマ | Default(Redmine の既定のテーマ) |
| 言語 | Default と、Redmine が対応するすべての言語 | Default(管理画面の設定の、Redmine の既定の言語) |
| レイアウト | None(コンポーネントだけ)、Redmine layout | None |

- **レイアウト:** 「None」は、Redmine の CSS、JavaScript、テーマを読み込み、ヘッダー、メニュー、サイドバー、フッターを外します。「Redmine layout」は、画面の全体を出します。
- **右から左に書く言語:** アラビア語やヘブライ語を選ぶと、右から左の表示でテーマを確認できます。

## 自作のテーマのプレビュー

1. テーマを、Redmine の `themes/` のディレクトリに置きます(Docker では `docker/themes/` か、`REDMINE_LOOKBOOK_THEMES` のディレクトリ)。
2. 新しいテーマを Redmine に見つけさせるため、Redmine を起動し直し、ツールバーでそのテーマを選びます。
3. テーマを書き換えて、プレビューを読み直します。

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

**画面:** `RedmineLookbook::PagePreview` を入れ、Redmine の画面のパスを渡します。画面は、渡した利用者(`:admin`、`:anonymous`、またはログイン名)として、Redmine がレンダリングします。

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
| `REDMINE_LOOKBOOK` | 開発のモードでは `1`、ほかは `0` | プレビューを有効(`1`)か無効(`0`)にします。 |
| `REDMINE_LOOKBOOK_PATH` | `/lookbook` | Lookbook を置くパス。 |
| `REDMINE_LOOKBOOK_PREVIEW_PATHS` | なし | 足すプレビューのディレクトリ。`:` で区切ります。 |
| `REDMINE_LOOKBOOK_SERVERS` | なし | このプラグインを入れたほかの Redmine のサーバー。`名前=URL,名前=URL` の形で書きます。書くと、ツールバーに「Server」の切り替えが出て、選んだサーバーで同じプレビューを開きます。 |

## 仕組み

- **コンポーネント:** Lookbook は、`RedmineLookbook::PreviewsController` でプレビューをレンダリングします。このコントローラーは Redmine の `ApplicationController` を土台にしているので、Redmine のヘルパー、レイアウト、テーマの仕組みを使えます。
- **画面:** 画面のプレビューは、Rails のアプリケーションの中で GET のリクエストを送り、Redmine が返した HTML を出します。そのリクエストの利用者、テーマ、言語は、Rack の env のキーで渡します。このキーは、同じプロセスの中のコードだけが入れられます。HTTP のヘッダーは `HTTP_*` のキーになるので、外からは入れられません。
- **テーマと言語:** 選んだテーマは Redmine の `current_theme` と同じ形で、選んだ言語は Redmine の言語の仕組みで当てます。データベースの中の Redmine の設定は変えません。

## セキュリティ

- **開発でだけ使う:** 本番のサーバーでは、決して有効にしないでください。`/lookbook` を開ける人は、管理者としてレンダリングした画面を見られます。Lookbook には、ログインの仕組みがありません。
- **外に開かない:** Docker の設定は、既定では `127.0.0.1` でだけ待ち受けます。ローカルネットワークに開くのは、そのネットワークのだれにデータを見られてもよいときだけにしてください。
- **テストのデータはデータを置き換える:** `redmine_lookbook:load_test_data` は、Redmine のテストのデータにある表の行を置き換えます。本番では動かず、`CONFIRM=yes` を付けたときだけ動きます。

脆弱性を見つけたときの連絡のしかたは、[SECURITY.md](../../SECURITY.md) にあります。

## 制限事項

- 対応するのは Redmine 7.0 だけです。
- プレビューをレンダリングするコントローラーは、Lookbook のプレビューのコントローラーの内部のメソッドを、いくつか同じ形で持っています(Lookbook 2.3)。Lookbook の今後のリリースで、直す必要が出るかもしれません。
- 画面のプレビューは GET のリクエストだけを使うので、画面を最初に開いたときの形(たとえば、送る前のフォーム)を出します。

## ライセンス

Redmine Lookbook は、GNU General Public License のバージョン 2、または(お好みで)それより後のバージョンで公開します。[LICENSE](../../LICENSE) を見てください。

- Redmine は Jean-Philippe Lang の著作物で、GPL で公開されています。
- Lookbook は MIT License で公開されています。
