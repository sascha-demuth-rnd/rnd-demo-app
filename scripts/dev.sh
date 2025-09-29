#!/usr/bin/env bash
set -euo pipefail

# Node-Version prüfen (Vite 7 braucht >= 20.19 oder >= 22.12)
REQ="20"
CUR=$(node -v | sed 's/v\([0-9]*\).*/\1/')
if [ "${CUR:-0}" -lt "$REQ" ]; then
  echo "WARN: Node >= 20 empfohlen (gefunden: $(node -v))"
fi

# Dependencies installieren & Dev-Server starten
if [ ! -d node_modules ]; then
  echo "→ npm ci"
  npm ci --no-audit --no-fund
fi

echo "→ npm run dev (http://localhost:5173)"
npm run dev