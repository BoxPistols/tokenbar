#!/bin/sh
# macOS 13 (Intel) 向けに TokenBar.app をビルドする
set -e
cd "$(dirname "$0")"
app=TokenBar.app
rm -rf "$app" && mkdir -p "$app/Contents/MacOS"
swiftc -O -target x86_64-apple-macos13 TokenBar.swift -o "$app/Contents/MacOS/TokenBar"
cat > "$app/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleExecutable</key><string>TokenBar</string>
<key>CFBundleIdentifier</key><string>local.tokenbar</string>
<key>CFBundleName</key><string>TokenBar</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>LSMinimumSystemVersion</key><string>13.0</string>
<key>LSUIElement</key><true/>
</dict></plist>
PLIST
codesign --force -s - "$app"
echo "built $app"
