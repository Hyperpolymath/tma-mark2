# SPDX-FileCopyrightText: 2024 eTMA Handler Contributors
# SPDX-License-Identifier: MIT

# eTMA Handler Container Image
# Using Chainguard Wolfi for minimal attack surface

# =============================================================================
# Stage 1: Build
# =============================================================================
FROM cgr.dev/chainguard/wolfi-base:latest AS builder

# Install build dependencies
RUN apk add --no-cache \
    erlang-26 \
    elixir \
    nodejs-20 \
    npm \
    git \
    build-base

# Set build environment
ENV MIX_ENV=prod \
    MIX_HOME=/opt/mix \
    HEX_HOME=/opt/hex \
    LANG=C.UTF-8

WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy dependency files first (for better caching)
COPY mix.exs mix.lock ./
COPY config config

# Fetch dependencies
RUN mix deps.get --only prod && \
    mix deps.compile

# Copy assets and compile them
COPY assets assets
COPY priv priv
RUN mix assets.deploy

# Copy application source
COPY lib lib

# Compile application
RUN mix compile

# Build release
RUN mix release

# =============================================================================
# Stage 2: Runtime
# =============================================================================
FROM cgr.dev/chainguard/wolfi-base:latest AS runtime

# Install runtime dependencies only
RUN apk add --no-cache \
    ncurses-libs \
    libstdc++ \
    openssl

# Create non-root user
RUN addgroup -g 1000 etma && \
    adduser -u 1000 -G etma -h /app -D etma

WORKDIR /app

# Copy release from builder
COPY --from=builder --chown=etma:etma /app/_build/prod/rel/etma_handler ./

# Create data directory
RUN mkdir -p /data && chown etma:etma /data

# Switch to non-root user
USER etma

# Environment configuration
ENV PHX_HOST=0.0.0.0 \
    PHX_PORT=4000 \
    ETMA_DATA_DIR=/data \
    LANG=C.UTF-8 \
    RELEASE_TMP=/tmp

# Expose port
EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:4000/health || exit 1

# Volume for persistent data
VOLUME ["/data"]

# Labels for OCI compliance
LABEL org.opencontainers.image.title="eTMA Handler" \
      org.opencontainers.image.description="Open University Marking Tool (BEAM Edition)" \
      org.opencontainers.image.version="2.0.0" \
      org.opencontainers.image.vendor="eTMA Handler Contributors" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/Hyperpolymath/tma-mark2"

# Start the application
CMD ["bin/etma_handler", "start"]
