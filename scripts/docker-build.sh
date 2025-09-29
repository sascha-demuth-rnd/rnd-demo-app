#!/usr/bin/env bash
set -euo pipefail

IMAGE="${IMAGE:-rnd-demo-app}"
TAG="${TAG:-dev}"

echo "→ docker build -t ${IMAGE}:${TAG} ."
docker build -t "${IMAGE}:${TAG}" .
echo "✓ gebaut: ${IMAGE}:${TAG}"