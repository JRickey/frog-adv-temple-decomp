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

echo "decomp-permuter setup complete. Test with:"
echo "  vendor/decomp-permuter/.venv/bin/python vendor/decomp-permuter/permuter.py --help"
