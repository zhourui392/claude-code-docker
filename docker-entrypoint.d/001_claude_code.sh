#!/usr/bin/env bash
#
# Claude Code CLI Installer
# Installs the Claude Code CLI globally using npm
#

# Exit on errors
set -e
set -o pipefail

# Log function for better visibility
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

log "Installing Claude Code CLI..."

# Install the Claude Code CLI globally
if npm install -g @anthropic-ai/claude-code; then
  log "Successfully installed @anthropic-ai/claude-code globally"
else
  log "ERROR: Failed to install @anthropic-ai/claude-code"
  exit 1
fi