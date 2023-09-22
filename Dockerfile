FROM debian:latest

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt update && apt install -y unzip xvfb libxi6 libgconf-2-4 wget curl && apt-get -y autoclean

RUN mkdir /usr/local/nvm

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16.17.1

RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN node -v
RUN npm -v
    
COPY . /app

WORKDIR /app

RUN npm install

RUN npm run build

EXPOSE 3050

CMD ["node", "index.js"]
