# 設定

Redmine Lookbook は、Redmine のプロセスの環境変数で設定します。Redmine の中に設定の画面はありません。

<a id="environment-variables"></a>

## 環境変数

| 環境変数 | デフォルト値 | 内容 |
| --- | --- | --- |
| `REDMINE_LOOKBOOK` | 開発モードでは `1`、ほかは `0` | プレビューを有効(`1`)か無効(`0`)にします。本番では無効のままにしてください([セキュリティ](security.md))。 |
| `REDMINE_LOOKBOOK_PATH` | `/lookbook` | Lookbook をマウントするパス。 |
| `REDMINE_LOOKBOOK_PREVIEW_PATHS` | なし | 追加するプレビューのディレクトリ。`:` で区切ります([プレビューを書く](writing-previews.md#where-previews-go))。 |
| `REDMINE_LOOKBOOK_SERVERS` | なし | このプラグインをインストールしたほかの Redmine のサーバー。`名前=URL,名前=URL` の形式で指定します。指定すると、ツールバーに「Server」の切り替えが表示されます([複数のサーバー](#several-servers))。 |

プレビューが無効のときは、このプラグインは何もしません。Lookbook はマウントされず、Lookbook のコードも読み込まれません。

<a id="several-servers"></a>

## 複数のサーバー

`REDMINE_LOOKBOOK_SERVERS` は、同じプレビューを持つ Redmine をつなぎます。たとえば、テーマやプラグインが違う 2 つの Redmine です。

```sh
REDMINE_LOOKBOOK_SERVERS="local=http://127.0.0.1:3000,second=http://127.0.0.1:3001"
```

ツールバーの「Server」の切り替えには、「This server」(その Redmine のバージョン付き)と、これらのサーバーが表示されます。ほかのサーバーを選ぶと、プレビュー欄は、そのサーバーの同じプレビューに同じツールバーの設定でリダイレクトされ、そのサーバーの Redmine がプレビューをレンダリングします。Lookbook のナビゲーションは、元のサーバーのままです。

ブラウザーがほかのサーバーを直接開くので、そのサーバーはブラウザーからアクセスでき、同じプレビューを持っている必要があります。開くのは `REDMINE_LOOKBOOK_SERVERS` のサーバーだけで、それ以外の値は無視します。

Lookbook は、ツールバーの切り替えを cookie に保存します。ブラウザーは同じホストのポート違いで cookie を共有するので、1 つのホストでポートを変えて 2 つのサーバーを動かすと、選んだサーバーはもう一方でも有効になります。元に戻すときは、そちらで「This server」を選んでください。

<a id="docker"></a>

## Docker

Docker の環境には、ポート、アドレス、テーマのディレクトリの変数があります([インストール](installation.md#docker))。`REDMINE_LOOKBOOK_SERVERS` は Redmine に渡します。

<a id="redmines-settings"></a>

## Redmine の設定

ツールバーの切り替えは、Redmine の設定を変えません。それ以外は、プレビューを動かしている Redmine の設定(たとえば、管理 » 設定のデフォルトの言語やテキストの書式)に従います。プレビューには、その Redmine が表示するとおりの画面が表示されます。
