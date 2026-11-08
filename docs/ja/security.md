# セキュリティ

Redmine Lookbook は開発用のツールです。`/lookbook` を開けるすべての人に、管理者としてレンダリングした Redmine の画面を表示します。

<a id="use-it-only-for-previews"></a>

## プレビューのためだけに使う

- **開発環境専用:** 本番のサーバーでは、決して有効にしないでください。開発モード以外では、プレビューは既定で無効です。本番で `REDMINE_LOOKBOOK=1` にしないでください。
- **ログインの仕組みがない:** Lookbook には、ログインの仕組みがありません。`/lookbook` を開ける人は、プレビューがレンダリングする画面を、管理者として見られます。ユーザー、設定、Redmine の環境を表示する情報の画面、すべてのプロジェクトのデータが含まれます。
- **プレビュー用の Redmine:** Redmine のテストデータだけがある Redmine で使ってください。`redmine_lookbook:load_test_data` は、本番のときと、データベースにプロジェクト、チケット、トラッカー、`admin` 以外のユーザーがあるときは実行されないので、データのある Redmine にテストデータが混ざることはありません。`redmine_lookbook:update_test_data` は、Redmine のテストデータがある Redmine でだけ動き、本番では動きません。

<a id="network"></a>

## ネットワーク

- **既定はローカルだけ:** Docker の環境は、`127.0.0.1` でだけ待ち受けます。
- **ローカルネットワーク:** `REDMINE_LOOKBOOK_BIND=0.0.0.0` にすると、同じネットワークの端末から開けます(たとえば、タブレットでテーマを確認するとき)。そのネットワークのだれにプレビューを見られてもよいときだけにし、インターネットには決して公開しないでください。
- **テスト用のパスワード:** テストデータのパスワードは公開されています(`admin` / `admin`、`jsmith` / `jsmith`)。

<a id="internal-requests"></a>

## 内部のリクエスト

画面のプレビューは、レンダリングするユーザーを、内部のリクエストの Rack の env のキーで渡します。このキーは、同じ Redmine のプロセスの中のコードだけが設定できます。外部からの HTTP のヘッダーは `HTTP_*` のキーになるので、設定できません。[仕組み](how-it-works.md#pages)を参照してください。

<a id="the-docker-image"></a>

## Docker のイメージ

- Dockerfile は、redmine.org から Redmine をダウンロードし、決まった SHA256 で確認してから使います。
- このリポジトリの外部の GitHub Actions は、コミットの SHA で固定しています。ドキュメントのワークフローは、同じ組織の `redmine-kit/docs-skeleton` を `main` のブランチから使います。
- CI では、本番のサーバーと同じく Lookbook のない本番の設定で、Redmine を読み込めることを確認しています。
- 「Server」の切り替えは、`REDMINE_LOOKBOOK_SERVERS` のサーバーだけを開きます。

<a id="reporting-a-vulnerability"></a>

## 脆弱性の報告

[SECURITY.md](../../SECURITY.md) を参照してください。
