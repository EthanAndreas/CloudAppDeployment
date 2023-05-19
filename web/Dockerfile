# Use the official image of Node.js
FROM node:latest

# Set the working directory to /usr/src/frontend
WORKDIR /usr/src/frontend

# Copy the current directory contents into the container at /usr/src/frontend
COPY . .

# Expose port 3000 for the frontend
EXPOSE 3000

# Install any needed packages specified
RUN npm install
RUN npm run build .

# Run the frontend when the container launches
CMD ["npm","run","start"]