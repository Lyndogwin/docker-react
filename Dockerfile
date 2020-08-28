# Temperary container called builder
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# -----------------------------------

FROM nginx
# next line doesn't do anything in local env
# Elasticbeanstalk will map to this port in the container
EXPOSE 80 
# Copy only the static files that were built by npm run build
COPY --from=builder /app/build /usr/share/nginx/html 

# *** the nginx container's default run command starts nginx

