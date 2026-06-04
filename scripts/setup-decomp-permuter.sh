#!/usr/bin/env bash
# Setup script for decomp-permuter.
# Creates a Python venv inside vendor/decomp-permuter and installs its deps.
#
# Adapted from mizuchi (https://github.com/macabeus/mizuchi).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PERMUTER_DIR="$SCRIPT_DIR/../vendor/decomp-permuter"

if [ ! -d "$PERMUTER_DIR" ]; then
  echo "Error: decomp-permuter not found at $PERMUTER_DIR"
  echo "Run 'git submodule update --init vendor/decomp-permuter' first."
  exit 1
fi

cd "$PERMUTER_DIR"

echo "Creating Python virtual environment in $PERMUTER_DIR/.venv..."
python3 -m venv .venv

echo "Installing decomp-permuter dependencies..."
# Pin pycparser<3 because decomp-permuter imports pycparser.plyparser,
# which was removed in pycparser 3.0 (PLY rewrite).
.venv/bin/pip install --quiet 'pycparser<3' toml Levenshtein

# Apply the project-local preprocess patch so base.c can be the real source file
# (#include "game.h" etc.) — preprocess.py runs base.c through the project
# pipeline with -Iinclude. Idempotent: skip if already applied.
PATCH="$SCRIPT_DIR/../tools/permuter-preprocess-iinclude.patch"
if [ -f "$PATCH" ]; then
  if git apply --check -p1 "$PATCH" >/dev/null 2>&1; then
    git apply -p1 "$PATCH" && echo "Applied permuter preprocess -Iinclude patch."
  else
    echo "permuter preprocess patch already applied (or conflicts) — skipping."
  fi
fi

echo "decomp-permuter setup complete. Test with:"
echo "  vendor/decomp-permuter/.venv/bin/python vendor/decomp-permuter/permuter.py --help"
