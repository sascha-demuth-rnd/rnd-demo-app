#!/usr/bin/env bash
set -euo pipefail

# optional: Build-Args (Vite liest nur VITE_* zur Buildzeit)
# Beispiel: VITE_API_BASE=${VITE_API_BASE:-https://api.example.com}
# export VITE_API_BASE

echo "→ npm ci"
npm ci --no-audit --no-fund

echo "→ npm run build"
npm run build

echo "✓ Build fertig in ./dist"