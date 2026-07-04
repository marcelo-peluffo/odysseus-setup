# Odysseus + Ollama Local Docker Stack

This repository provides a portable two-container setup:

- **odysseus**: self-hosted workspace UI/API
- **ollama**: local model runtime with persistent model cache

## Quick start

1. Open a terminal.
2. Install Git (run the command for your system):

```bash
# Ubuntu / Debian
sudo apt update && sudo apt install -y git
```

```bash
# macOS (Homebrew)
brew install git
```

```bash
# Windows (winget)
winget install --id Git.Git -e --source winget
```

3. Install Docker:

```bash
# Ubuntu / Debian
sudo apt update && sudo apt install -y docker.io docker-compose-v2
sudo usermod -aG docker "$USER"
```

```bash
# macOS: install Docker Desktop (required)
brew install --cask docker
open -a Docker
```

```bash
# Windows (winget)
winget install -e --id Docker.DockerDesktop
```

On macOS, Docker Desktop provides Docker dependencies. For day-to-day usage in this repo, use the CLI commands shown below (`docker compose ...`).

4. In GitHub, click **Code** -> **HTTPS** and copy the repository URL.
5. In your terminal, clone the repository (replace the URL if needed):

```bash
git clone https://github.com/marcelo-peluffo/odysseus-setup.git
cd odysseus-setup
```

6. Start the stack:

```bash
cp .env.example .env
./scripts/up.sh
```

Open `http://localhost:7000`.

7. Find the temporary admin password (show only Odysseus logs):

```bash
# Show recent Odysseus logs (not all Docker logs)
docker compose logs --tail=300 odysseus

# If you do not see it yet, keep watching only Odysseus logs
docker compose logs -f --tail=50 odysseus
```

Optional filter to highlight likely password lines:

```bash
docker compose logs --tail=500 odysseus | grep -Ei "temp|temporary|password|admin"
```

Log in with user `admin` (or `ODYSSEUS_ADMIN_USER` if overridden), then change the password in Settings.

## Persistent caching

- `./data` and `./logs` are mounted for Odysseus data/log retention.
- `ollama_data` volume stores pulled Ollama models under `/root/.ollama`.
- On container restart, Ollama checks whether `OLLAMA_MODEL` already exists and only pulls it if missing.
- Docker build cache keeps Odysseus dependency layers unless `--no-cache` is used.

## Model endpoint wiring

Odysseus is preconfigured with:

`OLLAMA_BASE_URL=http://ollama:11434/v1`

so requests stay inside the Docker network.

## Commands

```bash
# First-time startup (build + run + logs)
./scripts/up.sh

# Background run without log streaming
docker compose up -d --build

# Watch only Odysseus and Ollama logs
docker compose logs -f --tail=200 odysseus ollama

# Stop stack
docker compose down
```

## Notes from upstream docs

- Odysseus generates a temporary admin password on first run and prints it in logs.
- Odysseus expects Ollama/OpenAI-compatible endpoints to include `/v1`.
- Ollama Docker model cache should be persisted at `/root/.ollama`.
