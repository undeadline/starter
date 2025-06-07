#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Использование: $0 <название проекта>"
    echo "Пример: $0 example"
    exit 1
fi

if [ -d ".git" ]; then
    echo "Найдена папка .git, начинаю удаление..."
    
    rm -rf .git
    
    if [ $? -eq 0 ]; then
        echo "Папка .git успешно удалена"
    else
        echo "Ошибка при удалении папки .git" >&2
        exit 1
    fi
else
    echo "Папка .git не найдена в текущей директории" >&2
fi

self_destruct() {
    echo "Удаляю этот скрипт..."
    rm -f "$0"
}

CURRENT_DIR=$(dirname "$(readlink -f "$0")")
DIR_NAME=$(basename "$CURRENT_DIR")

replacements=(
    "\$PROJECT_NAME\$* $1"
)

for replacement in "${replacements[@]}"; do
    old_text="${replacement%% *}"
    new_text="${replacement#* }"

    echo "Замена: '$old_text' → '$new_text'"

    find "./" -type f -not -name "install.sh" -exec sed -i "s/$old_text/$new_text/g" {} +
done

echo "Все замены выполнены!"

if [ "$1" = "$DIR_NAME" ]; then
    echo "Новое имя совпадает с текущим. Ничего не изменяем."
    exit 0
fi

NEW_DIR=$(dirname "$CURRENT_DIR")"/$1"

if [ -e "$NEW_DIR" ]; then
    echo "Ошибка: '$NEW_DIR' уже существует" >&2
    exit 1
fi

if mv "$CURRENT_DIR" "$NEW_DIR"; then
    echo "Папка успешно переименована в '$NEW_NAME'"
else
    echo "Ошибка при переименовании папки" >&2
    exit 1
fi

self_destruct
exit 0