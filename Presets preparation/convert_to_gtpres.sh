#!/bin/bash

# Проверка аргументов
if [ "$#" -ne 2 ]; then
    echo "Использование: $0 input.json output.gtpres"
    exit 1
fi

INPUT_JSON="$1"
OUTPUT_GTPRES="$2"

# Проверка наличия jq
if ! command -v jq &> /dev/null; then
    echo "Ошибка: Установи jq (например: brew install jq)"
    exit 1
fi

# Проверка наличия входного файла
if [ ! -f "$INPUT_JSON" ]; then
    echo "Ошибка: файл '$INPUT_JSON' не найден."
    exit 1
fi

TMP_FILE=$(mktemp)

# Начало JSON-обёртки
echo '{ "theVocabularyHive": {' >> "$TMP_FILE"

# Получаем ключи верхнего уровня
TOP_KEYS=$(jq -r 'keys[]' "$INPUT_JSON")
LAST_KEY=$(echo "$TOP_KEYS" | tail -n 1)

# Обрабатываем каждый блок
for KEY in $TOP_KEYS; do
    # имя Hive в camelCase + Hive
    HIVE_KEY="$(tr '[:upper:]' '[:lower:]' <<< ${KEY:0:1})${KEY:1}Hive"

    # Вставляем как объект с полем "theHive"
    echo -n "  \"$HIVE_KEY\": { \"theHive\": " >> "$TMP_FILE"
    jq ".$KEY" "$INPUT_JSON" >> "$TMP_FILE"
    echo -n " }" >> "$TMP_FILE"

    # запятая, если не последний элемент
    if [ "$KEY" != "$LAST_KEY" ]; then
        echo "," >> "$TMP_FILE"
    else
        echo "" >> "$TMP_FILE"
    fi
done


# Добавляем блок theSettingsHive и версию
echo "}" >> "$TMP_FILE"
echo "," >> "$TMP_FILE"
echo '  "theSettingsHive": { "theHive": [] },' >> "$TMP_FILE"
echo '  "version": "1.0.0.0"' >> "$TMP_FILE"

# Закрываем JSON
echo "}" >> "$TMP_FILE"

# Перемещаем в финальный файл
mv "$TMP_FILE" "$OUTPUT_GTPRES"

echo "✅ Готово! Файл сохранён как: $OUTPUT_GTPRES"
