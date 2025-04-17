# Usa una imagen base con Git
FROM alpine:latest as downloader

# Instala git y curl
RUN apk add --no-cache git

# Clona el repositorio público
RUN git clone https://github.com/silencfox/webcrm.git /site
              
# Etapa final: usar nginx para servir el sitio
FROM nginx:alpine

# Limpia contenido por defecto
RUN rm -rf /usr/share/nginx/html/*

# Copia el contenido clonado desde la etapa anterior
COPY --from=downloader /site /usr/share/nginx/html

# Expone el puerto del servidor
EXPOSE 80

# Comando para iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
