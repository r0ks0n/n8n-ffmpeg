FROM mwader/static-ffmpeg:latest AS ffmpeg_stage
FROM docker.io/n8nio/n8n:latest

USER root

# Kopiraj FFmpeg in FFprobe
COPY --from=ffmpeg_stage /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg_stage /ffprobe /usr/local/bin/ffprobe

# Instaliraj GraphicsMagick, ImageMagick in fonte (Debian/Ubuntu)
RUN apt-get update && apt-get install -y \
    graphicsmagick \
    imagemagick \
    fonts-dejavu-core \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

USER node
