FROM node:latest

RUN mkdir -p /opt/app/

COPY *.json /opt/app/
COPY *.ejs /opt/app/
COPY jsdoc.config /opt/app/
COPY Makefile /opt/app/

COPY template /opt/app/template
COPY tutorials /opt/app/tutorials
COPY tools /opt/app/tools

WORKDIR /opt/app/
RUN  ls /opt/app/
RUN  npm install --registry=https://registry.npm.taobao.org
RUN  npm run build

EXPOSE 8080
CMD [ "npm", "start" ]
