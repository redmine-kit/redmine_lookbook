# AGENTS.md

Guidelines for people and coding agents working in this repository. See [README.md](README.md) for an overview and [CONTRIBUTING.md](CONTRIBUTING.md) for the development setup.

## Rules

- **Redmine 7.0 only.** Do not add code for older Redmine versions.
- **Do not edit Redmine.** Extend Redmine through plugin mechanisms only.
- **Off means off.** With the plugin disabled (production, or `REDMINE_LOOKBOOK=0`), nothing may reference the Lookbook gem. Keep such code out of the autoloaded directories (`app/`, `lib/`); `lookbook/` holds it and `RedmineLookbook.setup` loads it.
- **Autoloading.** Redmine autoloads `lib/` with Zeitwerk: one constant per file, named after the path. Do not `require` files from `lib/`.
- **Check before committing.** Run `bin/check-previews` against the development Redmine and keep it passing.

## Documentation

- **Two languages.** English is the source; the Japanese translation is in `docs/ja/`. Change both together.
- **Facts.** State only what has been checked. Mark anything not yet checked, and say which Redmine and Lookbook versions were used.
- **Japanese wording.** Write plain, precise Japanese. Keep established technical terms instead of replacing them with everyday words: "プレビュー" (preview), "コンポーネント" (component), "リクエスト" (request), "脆弱性" (vulnerability), "プラグイン", "ヘルパー", "部分テンプレート". Do not use "版" for a version.

## Commits

- English, imperative mood, 72 characters or fewer in the first line, no trailing period.
- One purpose per commit.
