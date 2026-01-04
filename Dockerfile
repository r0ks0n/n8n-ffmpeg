# Stage 1: FFmpeg iz zadnjega static builda
FROM jrottenberg/ffmpeg:latest AS ffmpeg_stage

# Stage 2: n8n distroless image
FROM docker.io/n8nio/n8n:latest

USER root

COPY --from=ffmpeg_stage /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg_stage /usr/local/bin/ffprobe /usr/local/bin/ffprobe

USER node
