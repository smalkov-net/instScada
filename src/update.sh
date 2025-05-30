#!/bin/bash

A="/opt/mplc4/"
B="/opt/SibMir_SCADA/"
C="$HOME/Desktop/monitoring.zip"

D() {
    local E=$1

    if [ -d "$E" ]; then
        echo "Обрабатываем директорию $E..."
        if [ -f "$C" ]; then
            sudo mv "$C" "$E" && \
            sudo rm -rf "$E/cfg" "$E/htdocs" && \
            sudo unzip -o -q "$E/monitoring.zip" -d "$E" && \
            sudo rm "$E/monitoring.zip"
        else
            echo "Файл $C не найден."
            exit 1
        fi
    else
        :
    fi
}

D "$A"
D "$B"
