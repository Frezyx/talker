#!/bin/bash

# Путь к файлу относительно расположения самого скрипта
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
input_file="$SCRIPT_DIR/version.txt"

# Чтение строк
old_version=$(sed -n '1p' "$input_file" | xargs)
new_version=$(sed -n '2p' "$input_file" | xargs)
description=$(sed -n '3p' "$input_file" | xargs)
contributor=$(sed -n '4p' "$input_file" | xargs)

# Проверка что всё заполнено
if [[ -z "$old_version" || -z "$new_version" || -z "$description" || -z "$contributor" ]]; then
  echo "❌ version.txt is missing required values."
  exit 1
fi

echo "🚀 Updating from $old_version → $new_version by $contributor"
"$SCRIPT_DIR/update_version.sh" "$old_version" "$new_version"
"$SCRIPT_DIR/update_changelog.sh" "$new_version" "$description" "$contributor"
echo "✅ Done!"
