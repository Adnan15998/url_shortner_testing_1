# Set the base image
FROM node:latest

# Set the working directory
WORKDIR /app

# Copy the package.json file
COPY package.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the application port
EXPOSE 8000

# Add the MongoDB repository to the system
RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/debian bullseye/mongodb-org/6.0 main" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Install MongoDB
RUN apt-get update && apt-get install -y mongodb-org

# Start MongoDB in the background
CMD mongod & node app.js
