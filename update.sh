#!/bin/bash

a="/opt/mplc4/"
b="/opt/SibMir_SCADA/"
c="$HOME/Desktop/monitoring.zip"

d() {
    local e=$1
    if [ -d "$e" ]; then
        if [ -f "$c" ]; then
            sudo mv "$c" "$e" && sudo rm -rf "$e/cfg" "$e/htdocs" && sudo unzip -o -q "$e/monitoring.zip" -d "$e" && sudo rm "$e/monitoring.zip"
        else
            exit 1
        fi
    fi
}

d "$a"; d "$b"
