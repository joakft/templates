#!/usr/bin/env bash
set -e

if [ -f ".env" ]; then
    export $(cat .env | xargs)
fi

uv run python app/main.py
