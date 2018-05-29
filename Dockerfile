# build
FROM node:alpine as builder

RUN mkdir /sources

WORKDIR /sources

COPY . /sources 

RUN npm i -g yarn \
      && chmod 744 /usr/local/bin/yarn \
      && yarn install

RUN yarn run generate      

# run 
FROM nginx:alpine

LABEL maintainer="Julien Glotain <jglotain@gmail.com>"

COPY --from=builder /sources/dist /usr/share/nginx/html

