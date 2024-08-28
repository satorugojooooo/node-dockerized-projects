FROM node:latest
WORKDIR /apps/node-dockerized-projects
ADD . .
RUN npm install
CMD ["node", "index.js"]
