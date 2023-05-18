FROM node:latest
WORKDIR /usr/src/frontend
COPY . .
EXPOSE 3000
RUN npm install
RUN npm run build .
CMD ["npm","run","start"]