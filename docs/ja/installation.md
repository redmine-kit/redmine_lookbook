# インストール

Redmine Lookbook は、プレビューのためだけに用意した、開発モードの Redmine 7.0 で動かします。実際のデータがある Redmine にはインストールしないでください([セキュリティ](security.md))。

<a id="requirements"></a>

## 動作環境

- Redmine 7.0(Redmine 7.0.3 で確認)
- Redmine 7.0 が対応する Ruby
- [Lookbook](https://github.com/lookbook-hq/lookbook) 2.3(2.3.15 で確認)。Lookbook は、依存関係として [ViewComponent](https://viewcomponent.org/) をインストールします。Redmine Lookbook は、ViewComponent のコンポーネントを使いません。
- リポジトリのプレビューには、テスト用のリポジトリを作って読む `svnadmin`、`git`、`hg`(Mercurial)が必要です。ないときは、それらのプレビューに Redmine のエラーの画面が表示されます。Docker のイメージには入っています。

<a id="docker"></a>

## Docker

Docker の環境は、このプラグインと Redmine のテストデータを入れた Redmine 7.0.3 をビルドします。必要なのは Docker だけです。

```sh
git clone https://github.com/redmine-theme/redmine_lookbook.git
cd redmine_lookbook
docker compose -f docker/compose.yml up --build
```

起動したら <http://127.0.0.1:3000/lookbook> を開きます。初めて起動したときは、次のことを行います。

1. Redmine 7.0.3 をダウンロードし、SHA256 を確認します。
2. 新しいデータベースを作り、Redmine のテストデータとテスト用のリポジトリを読み込みます。
3. Redmine を開発モードで起動します。

2 回目からの起動では `redmine_lookbook:update_test_data` を実行し、新しいコンテナーではテスト用のリポジトリを作り直します(リポジトリはコンテナーの `tmp/` にあるため)。

Redmine そのものには、`admin` / `admin`(管理者)か `jsmith` / `jsmith`(プロジェクトのメンバー)でログインできます。

| 変数 | 既定値 | 内容 |
| --- | --- | --- |
| `REDMINE_LOOKBOOK_BIND` | `127.0.0.1` | 待ち受けるアドレス。ローカルネットワークの他の端末から見るときは `0.0.0.0` にします。 |
| `REDMINE_LOOKBOOK_PORT` | `3000` | ホスト側のポート。 |
| `REDMINE_LOOKBOOK_THEMES` | `./themes`(`docker/` の下) | プレビューで使うテーマのディレクトリ。テーマごとにディレクトリを分けて置きます。 |

たとえば、`~/themes` のテーマを、同じネットワークのタブレットからプレビューするときは、次のように起動します。

```sh
REDMINE_LOOKBOOK_THEMES=~/themes REDMINE_LOOKBOOK_BIND=0.0.0.0 docker compose -f docker/compose.yml up
```

データベースとアップロードしたファイルは、Docker のボリュームに残ります。新しいテストデータからやり直すときは、ボリュームを削除します: `docker compose -f docker/compose.yml down -v`

<a id="an-existing-redmine"></a>

## 既存の Redmine

1. プレビュー用の新しい Redmine 7.0 を、新しい空のデータベースで用意します。`bin/rails db:migrate` は実行し、`redmine:load_default_data` は実行しません。
2. このリポジトリを `plugins/redmine_lookbook` に配置します。
3. `bundle install` を実行します。Lookbook は、プラグインの `Gemfile` の `development` のグループにあります。
4. Redmine のテストデータを読み込みます。

   ```sh
   bin/rails redmine_lookbook:load_test_data
   ```

5. Redmine を開発モードで起動し、`/lookbook` を開きます。

<a id="test-data"></a>

## テストデータ

`redmine_lookbook:load_test_data` は、Redmine のソースの `test/fixtures` にある、Redmine 自身のテストデータを読み込みます。43 のテーブルに、プロジェクト、チケット、バージョン、wiki のページ、ニュース、文書、フォーラム、ユーザー、グループがあります。

- **空のデータベースにだけ:** データベースにすでにプロジェクト、チケット、トラッカー、`admin` 以外のユーザーがあるときと、本番のときは、このタスクは実行されません。既存のデータを置き換えることはありません。
- **画像:** テストデータには、ファイルのない画像の添付ファイルがあります。このタスクは、テスト用の画像を元にそのファイルを作るので、サムネイルとインラインの画像が表示されます。
- **子チケット:** テストデータには親子のチケットがないので、このタスクはチケット 1 に子チケットを 1 つ追加します。
- **リポジトリ:** このタスクは、`rake test:scm:setup` と同じように、`test/fixtures/repositories` から Redmine のテストのリポジトリを `tmp/test/` に作ります。テストデータが参照する Subversion のリポジトリ(eCookbook の既定のリポジトリ)と、eCookbook に追加する Git と Mercurial のリポジトリです。リビジョンを読み込み、メッセージが参照するチケットにリビジョンを関連付けます。
- **Webhook:** Redmine のテストデータには Webhook(Redmine 7 の新機能)がないので、このタスクが 1 つ追加します。
- **ユーザー:** `admin` / `admin` と `jsmith` / `jsmith` でログインできます。画面のプレビューは、プレビューが別のユーザーを指定しない限り `admin` としてレンダリングします。

`redmine_lookbook:update_test_data` は、ファイル、子チケット、Webhook、テスト用のリポジトリのうち、ないものを追加します。Redmine のテストデータがある Redmine でだけ動き、本番では動かず、何度でも実行できます。Redmine Lookbook を更新したあとや、`tmp/test/` のテスト用のリポジトリを消したあとに実行します。

```sh
bin/rails redmine_lookbook:update_test_data
```

<a id="checking-the-previews"></a>

## プレビューの確認

`bin/check-previews` は、すべてのプレビューを 3 つのツールバーの設定(既定、日本語と Redmine のレイアウト、アラビア語)でレンダリングし、失敗したプレビューを表示します。画面のプレビューで、Redmine の画面がプレビューの期待と違う HTTP のステータスを返したとき(たとえばエラーの画面)も失敗にします。動いている Redmine に対して実行します。

```sh
bin/check-previews                        # http://127.0.0.1:3000
bin/check-previews http://192.0.2.10:3000 # 別の Redmine
```
