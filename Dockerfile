# Temperary container called builder
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# -----------------------------------

FROM nginx
# Copy only the static files that were built by npm run build
COPY --from=builder /app/build /usr/share/nginx/html 

# *** the nginx container's default run command starts nginx

