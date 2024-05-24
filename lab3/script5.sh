#!/bin/bash
 
# Имя именованного канала
FIFO_NAME="channel"
 
# Создание именованного канала
mkfifo $FIFO_NAME 2>/dev/null
 
# Функция для генерации данных
function generate_data() {
    echo "+"
    sleep 1
    echo "10"
    sleep 1
    echo "*"
    sleep 1
    echo "5"
    sleep 1
    echo "QUIT"
}
 
# Запись данных в именованный канал
generate_data > $FIFO_NAME
 
echo "Генератор завершил работу"
