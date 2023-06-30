FROM node:alpine as package_installer
WORKDIR /packaging
COPY package.json /packaging/package.json
COPY package-lock.json /packaging/package-lock.json
COPY yarn.lock /packaging/yarn.lock
RUN npm ci

FROM node:alpine as generator
WORKDIR /generator
COPY --from=package_installer /packaging/node_modules /generator/node_modules
COPY . /generator/
RUN apk add git && \
  git clone https://github.com/probberechts/hexo-theme-cactus.git \
  themes/cactus && \
  npm i -g hexo-cli && \
  npm run build

FROM nginx:alpine as runner
COPY --from=generator /generator/public /usr/share/nginx/html
EXPOSE 80
