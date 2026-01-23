FROM mwader/static-ffmpeg:latest AS ffmpeg_stage

# Alpine stage za fonte
FROM alpine:latest AS fonts_builder
RUN apk add --no-cache \
    fontconfig \
    ttf-dejavu \
    ttf-liberation \
    msttcorefonts-installer \
    fontconfig

# Main n8n image
FROM docker.io/n8nio/n8n:latest

USER root

# FFmpeg
COPY --from=ffmpeg_stage /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg_stage /ffprobe /usr/local/bin/ffprobe

# Kopiraj fonte in font config
COPY --from=fonts_builder /usr/share/fonts /usr/share/fonts
COPY --from=fonts_builder /etc/fonts /etc/fonts

# Ustvari font cache direktorij z permissions
RUN mkdir -p /var/cache/fontconfig && \
    chmod -R 777 /var/cache/fontconfig && \
    mkdir -p /home/node/.cache/fontconfig && \
    chown -R node:node /home/node/.cache

# Make binaries executable
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe

USER node
