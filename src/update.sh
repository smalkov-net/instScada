#!/bin/bash

DIR1="/opt/mplc4/"
DIR2="/opt/SibMir_SCADA/"
ZIP_FILE="$HOME/Desktop/monitoring.zip"  # Используем переменную $HOME

# Функция для обработки директории
process_directory() {
    local dir=$1

    if [ -d "$dir" ]; then
        echo "Обрабатываем директорию $dir..."
        if [ -f "$ZIP_FILE" ]; then
            sudo mv "$ZIP_FILE" "$dir" && \
            sudo rm -rf "$dir/cfg" "$dir/htdocs" && \
            sudo unzip -o -q "$dir/monitoring.zip" -d "$dir" && \
            sudo rm "$dir/monitoring.zip"
        else
            echo "Файл $ZIP_FILE не найден."
            exit 1
        fi
    else
        # echo "Директория $dir не существует."
    fi
}

# Обработка директорий
process_directory "$DIR1"
process_directory "$DIR2"
