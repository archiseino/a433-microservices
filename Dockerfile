# Use the official Node.js 14 base image as the runtime environment.
FROM node:14

# Set the working directory inside the container to /app.
# All following commands (COPY, RUN, etc.) are relative to this path.
WORKDIR /app

# Copy all files from the project root on the host into the container's
# working directory so the application source and package files are available.
COPY . .

# Set environment variables inside the container:
# - NODE_ENV=production tells Node/npm to run in production mode.
# - DB_HOST=item-db points the app to the database service hostname used by compose.
ENV NODE_ENV=production DB_HOST=item-db

# Install only production dependencies and then build the application.
# Using --unsafe-perm avoids permission issues when running as root in some images.
RUN npm install --production --unsafe-perm && npm run build

# Expose port 8080 so it can be published by Docker (mapped by docker-compose or docker run).
EXPOSE 8080

# When the container starts, run the application using the project's start script.
# This runs the same command as `npm start` from package.json.
CMD ["npm", "start"]
