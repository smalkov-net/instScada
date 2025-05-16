#!/bin/bash

a="/opt/mplc4/"; b="/opt/SibMir_SCADA/"; c="$HOME/Desktop/linux-x64.zip"; d="$HOME/Desktop/linux-x64_key.zip"

read n

e() { echo "$1"; exit 1; }

f() { for x in "$@"; do [ ! -f "$x" ] && e "$x don't exist"; done; }

g() { for y in "$@"; do [ ! -d "$y" ] && return 1; done; return 0; }

h() { g "$a" "$b" || e "scada don't exist"; echo "let's start..."; sudo rm -r "$a" "$b" 2>/dev/null; echo "good delete"; }

i() { f "$c" "$d"; for z in "$c" "$d"; do [ -f "$z" ] && { u="$HOME/Desktop/unzipped/$(basename "$z" .zip)"; mkdir -p "$u"; unzip -q "$z" -d "$u"; mv "$u/"* /tmp/; }; done; cd /tmp/ || exit; chmod u+x install.sh; sudo ./install.sh; rm -f /tmp/version.rtf /tmp/rtsp.tar.gz /tmp/nginx.tar.gz /tmp/netcore.tar.gz /tmp/mplc4.tar.gz /tmp/SibMir_SCADA.tar.gz /tmp/install.sh /tmp/dotnet-runtime.tar.gz; g "$a" "$b"; [ -d "$a" ] && sudo /etc/init.d/mplc4 restart; [ -d "$b" ] && sudo /etc/init.d/SibMir_SCADA restart; echo "good install"; }

j() { k="$(dirname "$0")/srt"; cp "$k"/update.sh "$k"/restartScada.sh "$k"/startScada.sh "$k"/stopScada.sh "$HOME/Desktop/" || e "error copy file from $k to Desktop"; cd "$HOME/Desktop" || e "error connect to $HOME/Desktop"; f update.sh restartScada.sh startScada.sh stopScada.sh; chmod +x update.sh restartScada.sh startScada.sh stopScada.sh || e "files update don't exist"; echo "good update"; }

p=(h i j)

case $n in
    1) ${p[0]};;
    2) for q in "${p[@]}"; do $q; done;;
    3) ${p[2]};;
    *) echo "no way";;
esac
