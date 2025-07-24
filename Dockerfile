FROM nginx:alpine

# Copiar o arquivo index.html para o diretório padrão do Nginx
COPY index.html /usr/share/nginx/html/

# Configuração para o EasyPanel - Variável de ambiente para a porta
ENV PORT=80

# Expor a porta que será usada pelo EasyPanel
EXPOSE ${PORT}

# Criar um arquivo de configuração do Nginx que usa a variável PORT
RUN echo 'server { \
    listen ${PORT}; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html index.htm; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Comando para iniciar o Nginx em primeiro plano
CMD sed -i -e 's/${PORT}/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
