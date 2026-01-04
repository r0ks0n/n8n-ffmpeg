FROM n8nio/n8n:latest

USER root

RUN set -eux; \
  if command -v apk >/dev/null 2>&1; then \
    apk add --no-cache ffmpeg curl wget bash; \
  elif command -v apt-get >/dev/null 2>&1; then \
    apt-get update && apt-get install -y --no-install-recommends ffmpeg curl wget bash \
    && rm -rf /var/lib/apt/lists/*; \
  else \
    echo "Unsupported base image (no apk or apt-get)"; exit 1; \
  fi

RUN ffmpeg -version || true

USER node
