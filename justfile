@lint:
  echo black
  just --justfile {{justfile()}} black
  echo mypy
  just --justfile {{justfile()}} mypy
  echo ruff
  just --justfile {{justfile()}} ruff
  echo fmt
  just --justfile {{justfile()}} fmt
  echo clippy
  just --justfile {{justfile()}} clippy

@black:
  poetry run black meilisearch_tui tests

@mypy:
  poetry run mypy .

@ruff:
  poetry run ruff check .

@clippy:
  cargo clippy

@fmt:
  cargo fmt

@check:
  cargo check

@test: start-meilisearch-detached && stop-meilisearch
  -poetry run pytest

@start-meilisearch:
  docker compose up

@start-meilisearch-detached:
  docker compose up -d

@stop-meilisearch:
  docker compose down

@dev-cli:
  textual console

@dev: start-meilisearch-detached && stop-meilisearch
  -textual run --dev meilisearch_tui/__main__.py

@dev-with-data: start-meilisearch-detached && stop-meilisearch
  echo Loading data
  poetry run python scripts/load_data.py
  echo Loading data successful, starting TUI
  -textual run --dev meilisearch_tui/__main__.py
