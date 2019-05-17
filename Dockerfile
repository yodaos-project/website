FROM node:alpine

# Install and config Supervisor
RUN apk add python py2-pip make bash git
RUN pip install wheel
RUN pip install supervisor supervisor-stdout
ADD ./supervisord.conf /etc/supervisord.conf

# prepare nginx
RUN apk add nginx
RUN rm -rf /etc/nginx/conf.d/default.conf
ADD nginx/default.conf /etc/nginx/conf.d/default.conf

# prepare website resource
RUN mkdir -p /opt/app/

COPY *.json /opt/app/
COPY jsdoc.config /opt/app/
COPY Makefile /opt/app/

COPY template /opt/app/template
COPY tutorials /opt/app/tutorials
COPY pages /opt/app/pages
COPY tools /opt/app/tools
COPY assets /opt/app/assets

WORKDIR /opt/app/
RUN  cat /opt/app/package.json
RUN  npm install --registry=https://registry.npm.taobao.org
RUN  npm run build

# Add a startup script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 8080
CMD ["/start.sh"]
