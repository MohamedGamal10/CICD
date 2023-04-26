# base image
FROM node:14.15.1 as build

# set working directory
WORKDIR /app

EXPOSE 3000

# install and cache app dependencies
COPY package.json package-lock.json ./
#COPY package.json /app/package.json

RUN npm version major
RUN npm install

# add app
COPY . ./

# start and/or build app
RUN npm run build

FROM nginx:1.20.1
#copies React to the container directory
# Set working directory to nginx resources directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static resources
RUN rm /etc/nginx/conf.d/default.conf
# Copies static resources from builder stage
COPY --from=build /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx-selfsigned.crt /etc/nginx/certs/nginx-selfsigned.crt
COPY ./nginx-selfsigned.key /etc/nginx/certs/nginx-selfsigned.key

EXPOSE 80
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
