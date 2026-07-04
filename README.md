# Odysseus + Ollama Local Docker Stack

This repository provides a portable two-container setup:

- **odysseus**: self-hosted workspace UI/API
- **ollama**: local model runtime with persistent model cache

## Quick start

```bash
cp .env.example .env
./scripts/up.sh
```

Open `http://localhost:7000`.

On first startup, Odysseus prints a temporary admin password in the `odysseus` logs.  
Log in with user `admin` (or `ODYSSEUS_ADMIN_USER` if overridden) and change the password in Settings.

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
