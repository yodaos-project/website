FROM node:latest
WORKDIR /opt/app

RUN   mkdir -p /opt/app
COPY  dist /opt/app/

EXPOSE 8080
CMD [ "npm", "start" ]
