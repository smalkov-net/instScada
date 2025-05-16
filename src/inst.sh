#!/bin/bash

# Создание путей к файлам и папкам
DIR1="/opt/mplc4/"
DIR2="/opt/SibMir_SCADA/"
FILE1="$HOME/Desktop/linux-x64.zip"
FILE2="$HOME/Desktop/linux-x64_key.zip"

# Чтение ввода
read -p "Введите число (1 - первая часть, 2 - все части, 3 - третья часть): " number

# Функция для обработки ошибок
handle_error() {
    echo "$1"
    exit 1
}

# Функция для проверки наличия файлов
check_files() {
    for file in "$@"; do
        if [ ! -f "$file" ]; then
            handle_error "Файл $file отсутствует."
        fi
    done
}

# Функция для проверки наличия папок
check_dirs() {
    for dir in "$@"; do
        if [ ! -d "$dir" ]; then
            return 1
        fi
    done
    return 0
}

# Определение функций
function part_one {
    echo "Это первая часть программы."

    # Проверка наличия папок
    check_dirs "$DIR1" "$DIR2" || handle_error "Склада сейчас отсутствует"

    # Начало установки
    echo "Все присутствует, продолжаем..."

    # Удаление папок, если они существуют
    sudo rm -r "$DIR1" "$DIR2" 2>/dev/null
    echo "good delete"
}

function part_two {
    echo "Это вторая часть программы."

    # Проверка наличия файлов
    check_files "$FILE1" "$FILE2"

    # Распаковка файлов и перемещение содержимого
    for FILE in "$FILE1" "$FILE2"; do
        if [ -f "$FILE" ]; then
            # Определяем имя директории для распаковки
            UNZIP_DIR="$HOME/Desktop/unzipped/$(basename "$FILE" .zip)"
            mkdir -p "$UNZIP_DIR"
            unzip -q "$FILE" -d "$UNZIP_DIR"

            # Перемещаем содержимое в /tmp/
            mv "$UNZIP_DIR/"* /tmp/
        fi
    done

    # Переход в /tmp и выполнение установки
    cd /tmp/ || exit
    chmod u+x install.sh
    sudo ./install.sh #--enable-log --with-reports

    # Удаление временных файлов
    rm -f /tmp/version.rtf /tmp/rtsp.tar.gz /tmp/nginx.tar.gz /tmp/netcore.tar.gz /tmp/mplc4.tar.gz /tmp/SibMir_SCADA.tar.gz /tmp/install.sh /tmp/dotnet-runtime.tar.gz

    # Перезапуск сервисов
    check_dirs "$DIR1" "$DIR2"
    [ -d "$DIR1" ] && sudo /etc/init.d/mplc4 restart
    [ -d "$DIR2" ] && sudo /etc/init.d/SibMir_SCADA restart
    echo "good install"
}

function part_three {
    echo "Это третья часть программы."

    # Путь к подпапке srt относительно текущего положения
    SRC_DIR="$(dirname "$0")/srt"

    # Копирование файлов на рабочий стол
    cp "$SRC_DIR"/update.sh "$SRC_DIR"/restartScada.sh "$SRC_DIR"/startScada.sh "$SRC_DIR"/stopScada.sh "$HOME/Desktop/" || handle_error "Ошибка копирования файлов из $SRC_DIR на рабочий стол"

    # Установка прав на скрипты
    cd "$HOME/Desktop" || handle_error "Ошибка перехода в директорию $HOME/Desktop"
    check_files update.sh restartScada.sh startScada.sh stopScada.sh
    chmod +x update.sh restartScada.sh startScada.sh stopScada.sh || handle_error "Ошибка установки прав на скрипты"
    echo "good update"
}

# Массив функций
parts=(part_one part_two part_three)

# Выполнение частей программы в зависимости от ввода
case $number in
    1)
        ${parts[0]}  # Выполняем только первую часть
        ;;
    2)
        for part in "${parts[@]}"; do
            $part  # Выполняем все части
        done
        ;;
    3)
        ${parts[2]}  # Выполняем только третью часть
        ;;
    *)
        echo "Некорректный ввод. Пожалуйста, введите 1, 2 или 3."
        ;;
esac
