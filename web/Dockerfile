FROM node:latest
WORKDIR /usr/src/frontend
COPY . .
EXPOSE 3000
RUN npm install
CMD ["npm","run","build","&&","npm","run","start"]