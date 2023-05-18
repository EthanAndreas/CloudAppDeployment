FROM node:latest
WORKDIR /frontend
COPY ~/CloudAppDeployment/api/web .
EXPOSE 3000
CMD ["npm","install"]
CMD ["npm","run","build"]
CMD ["npm","run","start"]