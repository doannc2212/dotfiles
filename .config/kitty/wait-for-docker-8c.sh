#!/usr/bin/env bash

set -euo pipefail

container_id="8c"
timeout_seconds="${KITTY_DOCKER_START_TIMEOUT:-60}"
start_time="$(date +%s)"

echo "Waiting for Docker container ${container_id} to be running..."

while true; do
  if docker inspect -f '{{.State.Running}}' "$container_id" 2>/dev/null | grep -qx 'true'; then
    echo "Docker container ${container_id} is running."
    break
  fi
  if (( "$(date +%s)" - start_time >= timeout_seconds )); then
    echo "Timed out waiting for Docker container ${container_id}. Check /tmp/kitty-docker-8c.log." >&2
    exit 1
  fi
  sleep 1
done
