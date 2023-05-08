FROM node:16-alpine
LABEL maintainer="Bouali Yohan <yohan.bouali@etu.u-pec.fr>"

# use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /user/src/app && cp -a /tmp/node_modules /user/src/app/

# From here we load our application's code in, therefore the previous docker
# "layer" thats been cached will be used if possible
WORKDIR /user/src/app
ADD . /user/src/app

EXPOSE 8080

CMD ["node", "server.js"]