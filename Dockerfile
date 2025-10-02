# builder image
FROM node:24@sha256:4e87fa2c1aa4a31edfa4092cc50428e86bf129e5bb528e2b3bbc8661e2038339 as builder

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build

# final image
FROM nginx:24-alpine@sha256:77f3c4d1f33c17dfa4af4b0add57d86957187873e313c2c37f52831d117645c8

COPY --from=builder /app/build/ /usr/share/nginx/html/
