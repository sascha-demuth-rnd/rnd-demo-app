#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <dockerhub-user> <version>  # z.B. ./scripts/release.sh saschademuth 1.0.0"
  exit 1
fi

USER="$1"
VER="$2"
IMAGE="${USER}/rnd-demo-app"

echo "→ Git-Tag v${VER}"
git tag -a "v${VER}" -m "release v${VER}"
git push origin "v${VER}"

echo "→ Buildx Multi-Arch amd64+arm64 & Push"
docker buildx create --use --name multi >/dev/null 2>&1 || true
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t "${IMAGE}:${VER}" \
  -t "${IMAGE}:latest" \
  --push .
echo "✓ Release ${IMAGE}:${VER} & latest"