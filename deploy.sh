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

if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Updating repo..."
    GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git fetch origin main
    GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git reset --hard origin/main
else
    echo "Cloning repo..."
    rm -rf "$REPO_DIR"
    mkdir -p "$REPO_DIR"
    cd "$REPO_DIR"
    GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git clone -b main "$GIT_REPO_URL" .
fi

# Сборка и запуск контейнеров
echo "Stopping old containers..."
docker compose down --remove-orphans || true
echo "Starting new containers..."
docker compose up -d --build