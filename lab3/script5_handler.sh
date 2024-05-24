#!/bin/bash
 
# Имя именованного канала
FIFO_NAME="channel"
 
# Режим обработки
mode="add"
result=1
 
# Обработка данных из именованного канала
while true; do
    read line < $FIFO_NAME
    case "$line" in
        "+")
            mode="add"
            echo "Режим: сложение"
            ;;
        "*")
            mode="multiply"
            echo "Режим: умножение"
            ;;
        "QUIT")
            echo "Обработчик завершает работу"
            exit 0
            ;;
        [0-9]*)
            case "$mode" in
                "add")
                    result=$((result + line))
                    echo "Результат: $result"
                    ;;
                "multiply")
                    result=$((result * line))
                    echo "Результат: $result"
                    ;;
            esac
            ;;
        *)
            echo "Ошибка: неверные входные данные"
            exit 1
            ;;
    esac
done
