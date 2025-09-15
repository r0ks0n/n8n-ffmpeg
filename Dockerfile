# Alpine varianta n8n
FROM n8nio/n8n:latest

# 1) Sistemski paketi
USER root
RUN apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    bash \
    ttf-dejavu \
    ttf-freefont

# 2) Pripravi /data in lastništvo, da lahko node tja piše
RUN mkdir -p /data && chown -R node:node /data

# 3) Nazaj na 'node' in namesti npm module v /data
USER node
RUN npm install --prefix /data --omit=dev pdf-lib pdfme

# 4) Naj Node najde module iz /data
ENV NODE_PATH=/data/node_modules

# 5) Dovoli external modules v n8n Code/Function node
ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,pdfme \
    NODE_FUNCTION_EXTERNAL_MODULES=pdf-lib,pdfme
