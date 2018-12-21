FROM node:latest
WORKDIR /opt/app

RUN   mkdir -p /opt/app
COPY  *        /opt/app/

RUN  npm install --registry=https://registry.npm.taobao.org
RUN  npm run build

EXPOSE 8080
CMD [ "npm", "start" ]
