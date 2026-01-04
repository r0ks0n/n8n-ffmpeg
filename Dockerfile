FROM mwader/static-ffmpeg:latest AS ffmpeg_stage

FROM docker.io/n8nio/n8n:latest

USER root

COPY --from=ffmpeg_stage /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg_stage /ffprobe /usr/local/bin/ffprobe

USER node
