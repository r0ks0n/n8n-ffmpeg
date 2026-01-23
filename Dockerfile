FROM mwader/static-ffmpeg:latest AS ffmpeg_stage
FROM docker.io/n8nio/n8n:latest

USER root

# Kopiraj FFmpeg in FFprobe
COPY --from=ffmpeg_stage /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg_stage /ffprobe /usr/local/bin/ffprobe

# Instaliraj GraphicsMagick, ImageMagick in fonte
RUN apk add --no-cache \
    graphicsmagick \
    imagemagick \
    imagemagick-dev \
    ttf-dejavu \
    fontconfig

USER node
