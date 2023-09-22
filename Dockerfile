# FROM debian:latest

# RUN apt update && apt install -y unzip xvfb libxi6 libgconf-2-4 wget curl wget && apt-get -y autoclean
# RUN apt install -y libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libasound2

# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
# RUN apt update && apt install -y google-chrome-stable

FROM allanmleite/puppeter-base:latest

RUN apt update && apt install -y unzip xvfb libxi6 libgconf-2-4 wget curl wget && apt-get -y autoclean
RUN apt install -y libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libasound2

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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
    
COPY . /app

WORKDIR /app

RUN npm install

RUN npm run build

EXPOSE 3050

CMD ["node", "index.js"]
