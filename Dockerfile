FROM node:18 AS builder

WORKDIR /app

COPY package.json package-lock.json  ./

RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build

FROM nginx:1.25-alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]