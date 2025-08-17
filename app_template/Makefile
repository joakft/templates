.PHONY: setup run docker test clean export

setup:
	uv sync
	@if [ ! -f ".env" ]; then cp .env.example .env; fi
	uv export --format requirements-txt > requirements.txt

run:
	@if [ -f ".env" ]; then export $$(cat .env | xargs); fi; \
	uv run python app/main.py

docker:
	docker build -t app_template .
	docker run --env-file .env app_template

test:
	uv run pytest tests

export:
	uv export --format requirements-txt > requirements.txt

clean:
	rm -rf .venv __pycache__ */__pycache__ uv.lock .pytest_cache .mypy_cache
