#!/usr/bin/env bash
set -euo pipefail

if ! docker info >/dev/null 2>&1; then
  echo "Docker daemon is not accessible for this user."
  echo "On Linux, add your user to the docker group, then re-login:"
  echo "  sudo usermod -aG docker \$USER"
  echo "  newgrp docker"
  exit 1
fi

docker compose up -d --build

echo
echo "Stack is starting. Streaming logs (Ctrl+C to stop)."
echo "Look for the Odysseus temporary admin password in the odysseus logs."
echo

docker compose logs -f --tail=200 odysseus ollama
