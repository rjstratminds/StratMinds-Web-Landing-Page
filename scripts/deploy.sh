#!/bin/bash
# Deploy to Firebase Hosting and clean up old releases
# Usage: ./scripts/deploy.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo "=== Deploying to Firebase Hosting ==="
firebase deploy

echo ""
echo "=== Cleaning up old releases (keeping last 2) ==="
"$SCRIPT_DIR/cleanup-firebase-releases.sh" 2

echo ""
echo "=== Deployment complete ==="
