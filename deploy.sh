#!/bin/bash

REPO_DIR="/etc/hackaton/backend"
GIT_REPO_URL="git@github.com:yung96/new-world.git"
SSH_KEY="/root/.ssh/id_ed25519"


echo "Starting deployment..."

# Добавляем GitHub в доверенные хосты
mkdir -p ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts

# Переходим в директорию репозитория
mkdir -p "$REPO_DIR"
cd "$REPO_DIR" || exit 1

# Клонируем или обновляем репозиторий с использованием конкретного SSH-ключа
if [ ! -d ".git" ]; then
    GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git clone -b dev "$GIT_REPO_URL" .
else
    GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git fetch origin dev
    GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git reset --hard origin/dev
fi

# Сборка и запуск контейнеров
docker compose down
docker compose up -d --build