FROM node:latest
WORKDIR /opt/app

RUN   npm install --registry=https://registry.npm.taobao.org
RUN   npm run build
RUN   mkdir -p /opt/app
COPY  dist /opt/app/

EXPOSE 8080
CMD [ "npm", "start" ]
