# TokenBar

Claude Code の 5 時間枠と週枠の使用率を、macOS のメニューバーと画面上の小さな帯に出しておくアプリです。[Hachibu](https://github.com/BoxPistols/hachibu) の軽量版で、Swift のファイル 1 つと AppKit だけで書いています。macOS 13 で止まっている Intel の MacBook で動かすために作りました。

A single-file AppKit version of Hachibu for macOS 13 on Intel Macs. It shows Claude Code's 5-hour and weekly usage in the menu bar and in a small strip on screen. The README is in Japanese.

TokenBar は個人が作った非公式のツールで、Anthropic, PBC とは関係がなく、同社の承認や支援も受けていません。

正式な製品は Hachibu です（macOS 14 以降、Apple Silicon と Intel）。ポリッシュや設定画面は Hachibu 側に入れていて、TokenBar は Hachibu に入れる前の試作場所も兼ねています。

## 表示の読み方

`Fable5.1• xhigh · S2 W39` は、モデル、effort、使用率の順です。モデル名の後ろの点は 1M コンテキストを表します。S は 5 時間枠、W は週枠です。

- 使用率が 80% 以上なら黄、90% 以上なら赤の札で数字を囲みます。閾値はメニューから変えられます（黄は 50〜80%、赤は 80〜95%）
- メニューバーの項目を開くと、各枠がいつリセットされるか、モデル、effort、最終更新の時刻が分かります
- 帯は押しても前面に出ません。フルスクリーンのアプリを含め、ほかの窓の上に出ます。ドラッグで動かせ、位置は覚えます。「帯を初期位置に戻す」でメニューバーのすぐ下の中央に戻ります
- 15 秒ごとにファイルを読み直します。⌘R で今すぐ読み直せます

### 帯の表示モード

| モード | 出るもの |
|---|---|
| 標準 | モデル、effort、使用率 |
| 使用率のみ | `S2 W39` のような使用率だけ |
| しまう | 小さな丸い取っ手だけ。輪の色で、いちばん高い使用率の段階を示す |
| 非表示 | 何も出さない |

マウスを乗せると一時的に標準へ広がります。帯の右クリックメニューとメニューバーの項目から、モード、不透明度（100〜30%）、閾値を切り替えられます。

ショートカットは 2 つで、固定です。⌥⌘/ で帯の表示と非表示を切り替え、⌥⌘. で標準、使用率のみ、しまうの順に切り替えます。Carbon のホットキーなので、アクセシビリティの許可は要りません。

### メニューバーの表示

アイコンのみ、週枠ゲージ（丸いメーターに週枠の使用率を数字 1 つで添える）、使用率、すべて（帯の標準と同じ文字列）から選べます。

## 値の出どころ

Claude Code の statusLine（公式の拡張点）が渡す JSON だけを読みます。キーチェーンを読まず、使用率の API も呼びません。

ネットワークに接続するのは、新しい版の確認だけです。起動時と、その後 1 日に 1 回、GitHub の最新リリース（`api.github.com`）を見ます。送るのは User-Agent（`TokenBar/版`）だけです。新しい版があれば、メニューの先頭に「TokenBar x.y.z が出ています」と出し、押すとリリースのページを開きます。

`statusline.sh` が JSON を `~/Library/Application Support/TokenBar/statusline.json` に保存し、TokenBar がそれを読みます。使用率（`rate_limits`）はセッションの最初の応答の後にしか入らないので、無いときは前回の値を残します。リセット時刻を過ぎた値は 0% として扱います。

## インストール

### ビルド済みのアプリを使う

[TokenBar-macos-x86_64.zip](https://github.com/BoxPistols/tokenbar/releases/latest/download/TokenBar-macos-x86_64.zip) を落として展開し、`TokenBar.app` を `~/Applications` か `/Applications` に置きます（macOS 13 以降、Intel のみ）。Apple の公証を受けていないため、初回の起動は macOS に止められます。「システム設定」＞「プライバシーとセキュリティ」で一度だけ許可してください。

`statusline.sh` も同じリリースから落とせます。

```sh
curl -L -o ~/.claude/tokenbar-statusline.sh https://github.com/BoxPistols/tokenbar/releases/latest/download/statusline.sh
chmod +x ~/.claude/tokenbar-statusline.sh
```

このときは下の statusLine の設定で、パスを `~/.claude/tokenbar-statusline.sh` にしてください。

### ソースからビルドする

Xcode のコマンドラインツールが必要です。

```sh
git clone https://github.com/BoxPistols/tokenbar.git
cd tokenbar
./build.sh
cp -R TokenBar.app ~/Applications/
open ~/Applications/TokenBar.app
```

`build.sh` は Intel（`x86_64-apple-macos13`）向けにビルドします。Apple Silicon で使うときは `-target` を `arm64-apple-macos13` に変えてください。署名はアドホックです。

次に `~/.claude/settings.json` の statusLine から `statusline.sh` を呼びます。パスはクローンした場所に合わせてください。

```json
{
  "statusLine": { "type": "command", "command": "/path/to/tokenbar/statusline.sh" }
}
```

`statusline.sh` は端末のステータスラインにモデル名だけを出します。すでに statusLine のコマンドを使っているときは、`statusline.sh` の最後のモデル名を出す部分を、そのコマンドに JSON を渡す行に差し替えてください。

メニューの「ログイン時に起動」を有効にすると、`~/Library/LaunchAgents/local.tokenbar.plist` を置いて、Mac を再起動しても戻ります。

## ライセンス

MIT
