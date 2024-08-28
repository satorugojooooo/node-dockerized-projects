# Use the latest Node.js image from Docker Hub
FROM node:latest

# Set the working directory in the container
WORKDIR /apps

# Copy the package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port your app runs on
EXPOSE 8080

# Command to run your application
CMD ["node", "index.js"]
