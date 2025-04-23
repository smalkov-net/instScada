#!/bin/bash

d1="/opt/mplc4/"
d2="/opt/SibMir_SCADA/"
f1="$HOME/Desktop/linux-x64.zip"
f2="$HOME/Desktop/linux-x64_key.zip"
z="$HOME/Desktop/monitoring.zip"

if [ ! -d "$d1" ] && [ ! -d "$d2" ]; then echo "Склада сейчас отсутствует"; fi
if [ ! -f "$f1" ] && [ ! -f "$f2" ]; then echo "Установленные файлы отсутствуют"; exit 1; fi

echo "Все присутствует, продолжаем..."

[ -d "$d1" ] && sudo rm -r "$d1"
[ -d "$d2" ] && sudo rm -r "$d2"

for f in "$f1" "$f2"; do
    [ -f "$f" ] && unzip -q "$f" -d "$HOME/Desktop/unzipped" && mv "$HOME/Desktop/unzipped/linux-x64/"* /tmp/
done

for f in "$f1" "$f2"; do
    [ -f "$f" ] && { [[ "$f" == *"_key.zip" ]] && u="$HOME/Desktop/unzipped/linux-x64_key" || u="$HOME/Desktop/unzipped/linux-x64"; unzip -q "$f" -d "$HOME/Desktop/unzipped"; mv "$u/"* /tmp/; }
done

cd /tmp/ || exit; chmod u+x install.sh; sudo ./install.sh

rm -f /tmp/version.rtf /tmp/rtsp.tar.gz /tmp/nginx.tar.gz /tmp/netcore.tar.gz /tmp/mplc4.tar.gz /tmp/SibMir_SCADA.tar.gz /tmp/install.sh /tmp/dotnet-runtime.tar.gz

cd "$HOME/Desktop" || exit; chmod +x update.sh restartScada.sh startScada.sh stopScada.sh

p() {
    local d=$1
    [ -d "$d" ] && { echo "Обрабатываем директорию $d..."; [ -f "$z" ] && { sudo mv "$z" "$d" && sudo rm -rf "$d/cfg" "$d/htdocs" && sudo unzip -o -q "$d/monitoring.zip" -d "$d" && sudo rm "$d/monitoring.zip"; } || { echo "Файл $z не найден."; exit 1; }; }
}

p "$d1"
p "$d2"

[ -d "$d1" ] && sudo /etc/init.d/mplc4 restart
[ -d "$d2" ] && sudo /etc/init.d/SibMir_SCADA restart
