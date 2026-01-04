# 1) Stage: vzemi ffmpeg binarke iz Alpine (lahko tudi Debian)
FROM alpine:3.20 AS ffmpeg_stage
RUN apk add --no-cache ffmpeg

# 2) Stage: tvoj n8n (distroless / brez apk/apt)
FROM docker.io/n8nio/n8n:latest

USER root

# Skopiraj ffmpeg + ffprobe binarke
COPY --from=ffmpeg_stage /usr/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg_stage /usr/bin/ffprobe /usr/local/bin/ffprobe

# (opcijsko) če ima image shell, to preveri, ampak ne rabiš
# RUN /usr/local/bin/ffmpeg -version || true

USER node
