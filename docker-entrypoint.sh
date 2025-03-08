#!/usr/bin/env bash
#
# Main entrypoint script for Claude Code container
# Executes all initialization scripts and launches the specified command
#

# Exit immediately if a command exits with a non-zero status
set -e
# Exit if any command in a pipeline fails
set -o pipefail

# Log function for better visibility
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

log "Starting container initialization"

# Execute all initialization scripts in order
for script in /docker-entrypoint.d/*.sh; do
  if [ -f "$script" ] && [ -x "$script" ]; then
    log "Running initialization script: $script"
    "$script" || {
      log "ERROR: Initialization script $script failed with status $?"
      exit 1
    }
  fi
done

log "Initialization complete, launching command: $@"
exec "$@"