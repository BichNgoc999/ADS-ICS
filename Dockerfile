# FROM node:14.16.0-alpine3.1
# RUN addgroup app && adduser -S -G app app
# RUN mkdir /app && chown app:app /app
# USER app

# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .

# EXPOSE 4200

# CMD ["npm", "start"]
# Stage 1
 
FROM node:10-alpine as build-step
 
RUN mkdir -p /app
 
WORKDIR /app
 
COPY package.json /app
 
RUN npm install
 
COPY . /app
 
RUN npm run build --prod
 
 
# Stage 2
 
FROM nginx:1.17.1-alpine
 
COPY --from=build-step /app/dist /usr/share/nginx/html