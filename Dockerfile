FROM node:latest

RUN   mkdir -p /opt/app/
COPY  *        /opt/app/

WORKDIR /opt/app/
RUN  ls /opt/app/
RUN  npm install --registry=https://registry.npm.taobao.org
RUN  npm run build

EXPOSE 8080
CMD [ "npm", "start" ]
