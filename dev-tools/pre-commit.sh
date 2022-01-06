#!/usr/bin/env bash

BASEDIR="$(git rev-parse --show-toplevel)"

# Runs script pipeline over python sources
find "$BASEDIR" -name "*.py" -not -path "*.venv*" |
  while read -r PYFILE; do
    echo "$PYFILE"
    isort "$PYFILE" &&
      black "$PYFILE" &&
      pylint "$PYFILE"
  done || exit 1

git add $(git diff --cached --name-only --diff-filter=d)
