#!/bin/bash

# Проверка аргументов
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <version> <description> <contributor_name>"
  echo "Example: $0 4.7.5 \"[talker_flutter] Improve widget logger\" mylukin"
  exit 1
fi

version="$1"
description="$2"
contributor="$3"

# Формируем текст вставки
entry="# $version
- $description

Thanks to [$contributor](https://github.com/$contributor)
"

# Находим все CHANGELOG.md и добавляем запись сверху
find . -type f -name "CHANGELOG.md" -print0 | while IFS= read -r -d '' file; do
  echo "Updating: $file"
  
  # Создаем временный файл с новой записью и содержимым старого CHANGELOG
  { echo "$entry"; cat "$file"; } > "${file}.tmp" && mv "${file}.tmp" "$file"
done

echo "✅ Done!"
