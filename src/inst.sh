#!/bin/bash

DIR1="/opt/mplc4/"
DIR2="/opt/SibMir_SCADA/"
FILE1="$HOME/Desktop/linux-x64.zip"
FILE2="$HOME/Desktop/linux-x64_key.zip"

read number

handle_error() {
    echo "$1"
    exit 1
}

check_files() {
    for file in "$@"; do
        if [ ! -f "$file" ]; then
            handle_error "$file don't exist"
        fi
    done
}

check_dirs() {
    for dir in "$@"; do
        if [ ! -d "$dir" ]; then
            return 1
        fi
    done
    return 0
}

function part_one {
	check_dirs "$DIR1" "$DIR2" || handle_error "scada don't exist"
	echo "let's start..."
	echo "good delete"
}

function part_two {
    echo "good install"
}

function part_three {
    echo "good update"
}

parts=(part_one part_two part_three)

case $number in
    1)
        ${parts[0]}
        ;;
    2)
        for part in "${parts[@]}"; do
            $part
        done
        ;;
    3)
        ${parts[2]}
        ;;
    *)
        echo "no way"
        ;;
esac
