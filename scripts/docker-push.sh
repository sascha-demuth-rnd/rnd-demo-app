#!/usr/bin/env bash
set -euo pipefail

# Erwartet DOCKERHUB_USER gesetzt ODER IMAGE wie user/repo
IMAGE="${IMAGE:-}"
TAG="${TAG:-dev}"

if [[ -z "$IMAGE" ]]; then
  if [[ -z "${DOCKERHUB_USER:-}" ]]; then
    echo "ERROR: Setze entweder IMAGE=<user/repo> oder DOCKERHUB_USER."
    exit 1
  fi
  IMAGE="${DOCKERHUB_USER}/rnd-demo-app"
fi

echo "→ docker push ${IMAGE}:${TAG}"
docker push "${IMAGE}:${TAG}"
echo "✓ gepusht: ${IMAGE}:${TAG}"