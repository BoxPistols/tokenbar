# TokenBar → Hachibu Lite

TokenBar は **Hachibu Lite** に名前を変え、[Hachibu のリポジトリ](https://github.com/BoxPistols/hachibu)の [`lite/`](https://github.com/BoxPistols/hachibu/tree/main/lite) に移りました。このリポジトリはアーカイブしていて、これ以上は更新しません。

TokenBar is now **Hachibu Lite** and lives in [`lite/`](https://github.com/BoxPistols/hachibu/tree/main/lite) of the [Hachibu repository](https://github.com/BoxPistols/hachibu). This repository is archived.

## 移り方

1. [Hachibu Lite の最新リリース](https://github.com/BoxPistols/hachibu/releases/tag/lite-v0.3.0)から `HachibuLite-macos-x86_64.zip` を落とし、`HachibuLite.app` を `~/Applications` か `/Applications` に置いて開きます（macOS 13 以降、Intel のみ）
2. 初めて起動したときに、TokenBar の設定と「ログイン時に起動」の登録を引き継ぎます
3. TokenBar を終了し、`TokenBar.app` を消します

statusLine は TokenBar の `statusline.sh` のままでも動きます。Hachibu の `statusline.sh` に替えておくと、Hachibu に移るときにも設定を変えずに済みます。詳しくは [lite/README.md](https://github.com/BoxPistols/hachibu/blob/main/lite/README.md) を見てください。

Hachibu と Hachibu Lite の違いは [Hachibu の README](https://github.com/BoxPistols/hachibu#hachibu-と-hachibu-lite) にあります。

## ライセンス

MIT
