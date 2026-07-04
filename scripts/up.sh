#!/usr/bin/env bash
set -euo pipefail

docker compose up -d --build

echo
echo "Stack is starting. Streaming logs (Ctrl+C to stop)."
echo "Look for the Odysseus temporary admin password in the odysseus logs."
echo

docker compose logs -f --tail=200 odysseus ollama

