FROM node:12.2.0-alpine AS builder
WORKDIR /web
COPY package.json package.json
RUN npm install
RUN npm install -g @angular/cli
COPY . /web
EXPOSE 8081
CMD ng serve --host 0.0.0.0 --port 8081