# Odysseus + Ollama Local Docker Stack

This repository provides a portable two-container setup:

- **odysseus**: self-hosted workspace UI/API
- **ollama**: local model runtime with persistent model cache

## Quick start

```bash
cp .env.example .env
docker compose up -d --build
docker compose logs -f --tail=200 odysseus ollama
```

Open `http://localhost:7000`.

On first startup, Odysseus prints a temporary admin password in the `odysseus` logs.  
Log in with user `admin` (or `ODYSSEUS_ADMIN_USER` if overridden) and change the password in Settings.

## Persistent caching

- `./data` and `./logs` are mounted for Odysseus data/log retention.
- `ollama_data` volume stores pulled Ollama models under `/root/.ollama`.
- On container restart, Ollama checks whether `OLLAMA_MODEL` already exists and only pulls it if missing.

## Model endpoint wiring

Odysseus is preconfigured with:

`OLLAMA_BASE_URL=http://ollama:11434/v1`

so requests stay inside the Docker network.

