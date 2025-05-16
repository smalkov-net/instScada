#!/bin/bash

A="/opt/mplc4/"
B="/opt/SibMir_SCADA/"
C="$HOME/Desktop/linux-x64.zip"
D="$HOME/Desktop/linux-x64_key.zip"

read N

E() {
    echo "$1"
    exit 1
}

F() {
    for G in "$@"; do
        if [ ! -f "$G" ]; then
            E "File $G not exist."
        fi
    done
}

H() {
    for I in "$@"; do
        if [ ! -d "$I" ]; then
            return 1
        fi
    done
    return 0
}

J() {
    H "$A" "$B" || E "Склада сейчас отсутствует"
    echo "all file good..."
    sudo rm -r "$A" "$B" 2>/dev/null
}

K() {
    F "$C" "$D"
    for L in "$C" "$D"; do
        if [ -f "$L" ]; then
            M="$HOME/Desktop/unzipped/$(basename "$L" .zip)"
            mkdir -p "$M"
            unzip -q "$L" -d "$M"
            mv "$M/"* /tmp/
        fi
    done
    cd /tmp/ || exit
    chmod u+x install.sh
    sudo ./install.sh #--enable-log --with-reports
    rm -f /tmp/version.rtf /tmp/rtsp.tar.gz /tmp/nginx.tar.gz /tmp/netcore.tar.gz /tmp/mplc4.tar.gz /tmp/SibMir_SCADA.tar.gz /tmp/install.sh /tmp/dotnet-runtime.tar.gz
    H "$A" "$B"
    [ -d "$A" ] && sudo /etc/init.d/mplc4 restart
    [ -d "$B" ] && sudo /etc/init.d/SibMir_SCADA restart
}

P() {
    Q="$(dirname "$0")/srt"
    cp "$Q"/update.sh "$Q"/restartScada.sh "$Q"/startScada.sh "$Q"/stopScada.sh "$HOME/Desktop/" || E "error copy fyle from $Q on Desktop"
    cd "$HOME/Desktop" || E "fail in $HOME/Desktop"
    F update.sh restartScada.sh startScada.sh stopScada.sh
    chmod +x update.sh restartScada.sh startScada.sh stopScada.sh || E "error change scrypt"
}

R=(J K P)
case $N in
    1)
        ${R[0]}
        ;;
    2)
        for S in "${R[@]}"; do
            $S
        done
        ;;
    3)
        ${R[2]}
        ;;
    *)
        echo
        ;;
esac
