# syntax=docker/dockerfile:1

############################
# 1. Build React app
############################
FROM node:20-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

############################
# 2. Serve with Nginx
############################
FROM nginx:stable-alpine
# Remove default site
RUN rm -rf /usr/share/nginx/html/*
# Copy build output
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# Copy custom nginx config if needed
#COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
