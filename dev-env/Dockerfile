# Dockerfile for nginx in dev-env
FROM nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# needed if conf is copied to image 
ENTRYPOINT ["nginx", "-g", "daemon off;"]
