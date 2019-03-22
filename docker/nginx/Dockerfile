FROM nginx:1.14

ARG DIR_PREFIX=docker/nginx
COPY ${DIR_PREFIX}/conf/project.conf /etc/nginx/conf.d/default.conf
COPY ./ /project
