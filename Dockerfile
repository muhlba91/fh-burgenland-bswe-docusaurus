# builder image
FROM node:24@sha256:4e87fa2c1aa4a31edfa4092cc50428e86bf129e5bb528e2b3bbc8661e2038339 as builder

WORKDIR /app
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build

# final image
FROM nginx:1.29-alpine@sha256:42a516af16b852e33b7682d5ef8acbd5d13fe08fecadc7ed98605ba5e3b26ab8

COPY --from=builder /app/build/ /usr/share/nginx/html/
