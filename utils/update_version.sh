#!/bin/bash

# Проверка на наличие двух аргументов
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <old_version> <new_version>"
  echo "Example: $0 4.7.4 4.7.5"
  exit 1
fi

old_version="$1"
new_version="$2"

# Ищем нужные файлы и заменяем версию
find . -type f \( -name "README.md" -o -name "pubspec.yaml" \) -print0 | while IFS= read -r -d '' file; do
  echo "Updating version in: $file"
  sed -i '' "s/${old_version//./\\.}/${new_version}/g" "$file"
done

echo "Done!"
