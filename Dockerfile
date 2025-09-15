# Uporabi Alpine varianto n8n :latest
FROM n8nio/n8n:latest

# Preklopi na root, da lahko dodaš pakete
USER root

# Namesti ffmpeg + dodatna orodja
RUN apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    bash \
    ttf-dejavu \
    ttf-freefont

# Varnost: nazaj na default n8n user
USER node

# Namesti pdf-lib in pdfme v /data (persistent modul folder)
RUN npm install --prefix /data --omit=dev pdf-lib pdfme

# Naj Node najde te module
ENV NODE_PATH=/data/node_modules

# Omogoči module v n8n Code/Function node
ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-lib,pdfme \
    NODE_FUNCTION_EXTERNAL_MODULES=pdf-lib,pdfme
