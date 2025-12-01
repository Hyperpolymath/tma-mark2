# SPDX-FileCopyrightText: 2024 eTMA Handler Contributors
# SPDX-License-Identifier: MIT
#
# eTMA Handler - Justfile
# ========================
#
# The only command you need: just do-it
#

set shell := ["bash", "-uc"]
set positional-arguments := true

# ============================================================================
# CONFIGURATION
# ============================================================================

container_name := "etma-handler"
container_registry := "ghcr.io/hyperpolymath"
container_tag := "latest"
container_image := container_registry + "/" + container_name + ":" + container_tag
local_image := container_name + ":" + container_tag

# Data directory (override with ETMA_DATA_DIR env var)
data_dir := env_var_or_default("ETMA_DATA_DIR", if os() == "windows" { "%APPDATA%\\etma_handler" } else { "$HOME/.local/share/etma_handler" })

# Port (override with ETMA_PORT env var)
port := env_var_or_default("ETMA_PORT", "4000")

# ============================================================================
# MAIN COMMANDS
# ============================================================================

# Show available commands
default:
    @echo ""
    @echo "  eTMA Handler"
    @echo "  ============"
    @echo ""
    @echo "  just do-it   - Set up everything and run"
    @echo ""
    @just --list --unsorted 2>/dev/null | grep -v "^Available" | grep -v "^$" || true

# Set up everything and run
do-it: _check-podman _ensure-dirs
    @echo ""
    @echo "  eTMA Handler - Let's do this!"
    @echo ""
    @just _pull-or-build
    @echo ""
    @echo "  Ready! Starting eTMA Handler..."
    @echo ""
    @echo "  Open your browser to: http://localhost:{{ port }}"
    @echo "  Press Ctrl+C to stop"
    @echo "  Your data is saved in: {{ data_dir }}"
    @echo ""
    @just run

# ============================================================================
# CONTAINER OPERATIONS
# ============================================================================

# Pull the latest container image
pull:
    @echo "  Pulling container image..."
    -podman pull {{ container_image }}

# Build the container locally
build:
    @echo "  Building container locally..."
    podman build -t {{ local_image }} -t {{ container_image }} -f Containerfile .
    @echo "  Build complete!"

# Run the container (foreground)
run:
    podman run --rm -it \
        -p {{ port }}:4000 \
        -v {{ data_dir }}:/data:Z \
        --name {{ container_name }} \
        {{ container_image }}

# Run in background
start: _check-podman _ensure-dirs
    @echo "  Starting eTMA Handler in background..."
    -@podman stop {{ container_name }} 2>/dev/null || true
    -@podman rm {{ container_name }} 2>/dev/null || true
    podman run -d \
        -p {{ port }}:4000 \
        -v {{ data_dir }}:/data:Z \
        --name {{ container_name }} \
        --restart unless-stopped \
        {{ container_image }}
    @echo ""
    @echo "  Running at http://localhost:{{ port }}"
    @echo "  Stop with: just stop"
    @echo "  Logs with: just logs"

# Stop the container
stop:
    @echo "  Stopping eTMA Handler..."
    -podman stop {{ container_name }} 2>/dev/null || true
    -podman rm {{ container_name }} 2>/dev/null || true
    @echo "  Stopped"

# Restart the container
restart: stop start

# View logs
logs:
    podman logs -f {{ container_name }}

# Container status
status:
    @podman ps -a --filter name={{ container_name }} 2>/dev/null || echo "  Not running"

# Shell into running container
shell:
    podman exec -it {{ container_name }} /bin/sh

# ============================================================================
# DATA MANAGEMENT
# ============================================================================

# Backup your data
backup dest="./backup":
    @echo "  Backing up data..."
    @mkdir -p {{ dest }}
    cp -r {{ data_dir }}/* {{ dest }}/ 2>/dev/null || echo "  No data to backup yet"
    @echo "  Backed up to {{ dest }}"

# Restore from backup
restore src:
    @echo "  Restoring from {{ src }}..."
    @mkdir -p {{ data_dir }}
    cp -r {{ src }}/* {{ data_dir }}/
    @echo "  Restored"

# Where is my data?
where:
    @echo "  Your data is stored at:"
    @echo "  {{ data_dir }}"

# ============================================================================
# UPDATES
# ============================================================================

# Update to latest version
update: stop
    @echo "  Updating eTMA Handler..."
    podman pull {{ container_image }}
    @echo "  Updated! Run 'just start' to use new version"

# ============================================================================
# DEVELOPMENT
# ============================================================================

# Enter Nix development shell
dev:
    @echo "  Entering development environment..."
    nix develop

# Run tests
test:
    mix test

# Format code
format:
    mix format

# Lint code
lint:
    mix credo --strict

# All checks
check: format lint test
    @echo "  All checks passed!"

# Build and push release
release version: build
    @echo "  Releasing version {{ version }}..."
    podman tag {{ local_image }} {{ container_registry }}/{{ container_name }}:{{ version }}
    podman push {{ container_registry }}/{{ container_name }}:{{ version }}
    podman push {{ container_image }}
    @echo "  Released {{ version }}"

# ============================================================================
# CLEANUP
# ============================================================================

# Clean up containers
clean:
    @echo "  Cleaning up..."
    -podman stop {{ container_name }} 2>/dev/null || true
    -podman rm {{ container_name }} 2>/dev/null || true
    @echo "  Cleaned"

# Deep clean (removes images too)
clean-all: clean
    -podman rmi {{ container_image }} 2>/dev/null || true
    -podman rmi {{ local_image }} 2>/dev/null || true
    @echo "  Deep cleaned"

# ============================================================================
# INTERNAL HELPERS
# ============================================================================

# Check podman is installed
_check-podman:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v podman &> /dev/null; then
        echo ""
        echo "  Podman is not installed!"
        echo ""
        echo "  Install it:"
        echo "    Linux (Fedora):  sudo dnf install podman"
        echo "    Linux (Ubuntu):  sudo apt install podman"
        echo "    Linux (Arch):    sudo pacman -S podman"
        echo "    macOS:           brew install podman"
        echo "    Windows:         winget install RedHat.Podman"
        echo ""
        exit 1
    fi
    echo "  Podman $(podman --version | cut -d' ' -f3) OK"

# Ensure data directory exists
_ensure-dirs:
    @mkdir -p {{ data_dir }} 2>/dev/null || true

# Try to pull, fall back to build
_pull-or-build:
    @just pull 2>/dev/null || just build
