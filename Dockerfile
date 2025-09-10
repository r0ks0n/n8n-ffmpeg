FROM n8nio/n8n:latest

# Install ffmpeg (in optional: curl, wget) on Debian-slim base
USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# (Optional) quick sanity check; harmless if fails
RUN which ffmpeg && ffmpeg -version || true

# Back to non-root for security (same as official image)
USER node