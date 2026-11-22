#!/usr/bin/env bash
# Builds the Talker DevTools extension and copies output to extension/devtools/build.
# Run from packages/talker_flutter/extension (or from repo root: packages/talker_flutter/extension/build_extension.sh).
#
# Alternative (per Flutter DevTools extensions article):
#   flutter pub run devtools_extensions build_and_copy --source . --dest devtools

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="${SCRIPT_DIR}"
DEST_DIR="${SCRIPT_DIR}/devtools/build"

echo "[build_extension] Building Flutter web app..."
(cd "$APP_DIR" && flutter build web --release --pwa-strategy=offline-first --no-tree-shake-icons)

echo "[build_extension] Copying to extension/devtools/build..."
rm -rf "$DEST_DIR"
cp -r "$APP_DIR/build/web" "$DEST_DIR"

echo "[build_extension] Done. Extension output is in extension/devtools/build/"
echo "[build_extension] Validate: flutter pub run devtools_extensions validate --package ../"
