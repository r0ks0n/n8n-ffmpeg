# Uporabi Alpine varianto n8n :latest
FROM n8nio/n8n:latest

# Preklopi na root, da lahko dodaš pakete
USER root

# Namesti ffmpeg + dodatna orodja
RUN apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    bash

# (opcijsko) preveri, da je ffmpeg na voljo
RUN ffmpeg -version || true

# Varnost: nazaj na default n8n user
USER node