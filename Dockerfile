FROM node:alpine AS build
LABEL maintainer="BUILD-STAGE <NODE-BUILD>"
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run

FROM node:alpine AS production
LABEL maintainer="FINAL-STAGE <NODE-BUILD>"
WORKDIR /app
COPY --from=build /app/package*.json ./
RUN npm install --omit=dev
COPY --from=build /app/ .
CMD ["node" , "app.js"]
EXPOSE 3000
================================================================================================================================
FROM node:alpine AS build
LABEL maintainer="BUILD-STAGE <NODE-BUILD>"
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
RUN npm build

FROM node:alpine AS production
LABEL maintainer="FINAL-STAGE <NODE-BUILD>"
WORKDIR /app
COPY --from=build /app/package*.json ./
EXPOSE 3000
CMD ["node" , "app.js"]

