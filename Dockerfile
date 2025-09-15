FROM n8nio/n8n:latest

# 1) Sistemski paketi (Alpine)
USER root
RUN apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    bash \
    ttf-dejavu \
    ttf-freefont

# 2) Pripravi /data in lastništvo
RUN mkdir -p /data && chown -R node:node /data

# 3) Namesti NPM module v /data kot 'node'
USER node
# (po želji dodaš registry pin, ni nujno)
# RUN npm config set registry https://registry.npmjs.org/
RUN npm install --prefix /data --omit=dev pdf-lib @pdfme/generator

# 4) Naj Node najde module + dovoli external modules v n8n
ENV NODE_PATH=/data/node_modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,@pdfme/generator \
    NODE_FUNCTION_EXTERNAL_MODULES=pdf-lib,@pdfme/generator
