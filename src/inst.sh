#!/bin/bash

a="/opt/mplc4/"
b="/opt/SibMir_SCADA/"
c="$HOME/Desktop/linux-x64.zip"
d="$HOME/Desktop/linux-x64_key.zip"

read e

f() {
	echo "$1"
	exit 1
}

g() {
	for h in "$@"; do
	if [ ! -f "$h" ]; then
		f "$h don't exist"
	fi
	done
}

i() {
	for j in "$@"; do
	if [ ! -d "$j" ]; then
		return 1
	fi
	done
	return 0
}

k() {
	if [ ! -d "$a" ] && [ ! -d "$b" ]; then
		echo "Склада сейчас отсутствует"
	fi

	if [ -d "$a" ]; then
		sudo rm -r "$a"
	fi
	if [ -d "$b" ]; then
		sudo rm -r "$b"
	fi

	echo "good delete"
}

l() {
	if [ ! -f "$c" ] && [ ! -f "$d" ]; then
		echo "Установленные файлы отсутствуют"
		exit 1
	fi

	echo "Все присутствует, продолжаем..."

	for m in "$c" "$d"; do
	if [ -f "$m" ]; then
		unzip -q "$m" -d "$HOME/Desktop/unzipped"
		mv "$HOME/Desktop/unzipped/linux-x64/"* /tmp/
	fi
	done

	for n in "$c" "$d"; do
	if [ -f "$n" ]; then
		if [[ "$n" == *"_key.zip" ]]; then
			o="$HOME/Desktop/unzipped/linux-x64_key"
		else
			o="$HOME/Desktop/unzipped/linux-x64"
		fi
        
		unzip -q "$n" -d "$HOME/Desktop/unzipped"
		mv "$o/"* /tmp/
	fi
	done

	cd /tmp/ || exit
	chmod u+x install.sh
	sudo ./install.sh

	rm -f /tmp/version.rtf /tmp/rtsp.tar.gz /tmp/nginx.tar.gz /tmp/netcore.tar.gz /tmp/mplc4.tar.gz /tmp/SibMir_SCADA.tar.gz /tmp/install.sh /tmp/dotnet-runtime.tar.gz

	echo "good install"
}

p() {
	cd "$HOME/Desktop" || exit
	chmod +x update.sh restartScada.sh startScada.sh stopScada.sh

	if [ -d "$a" ]; then
		sudo /etc/init.d/mplc4 restart
	fi

	if [ -d "$b" ]; then
		sudo /etc/init.d/SibMir_SCADA restart
	fi

	echo "good update"
}

q=(k l p)

case $e in
    1)
        ${q[0]}
        ;;
    2)
        for r in "${q[@]}"; do
            $r
        done
        ;;
    3)
        ${q[2]}
        ;;
    *)
        echo "no way"
        ;;
esac
