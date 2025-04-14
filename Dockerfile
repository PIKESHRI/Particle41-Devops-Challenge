FROM node:18-slim

# Creating a non-root user
RUN useradd -m appuser

# Seting working directory
WORKDIR /home/appuser/app

# Copying files and change ownership
COPY --chown=appuser:appuser . .

# Installing dependencies
RUN npm install --production

# Switching to non-root user
USER appuser

# Exposing port
EXPOSE 3000

# Running the app
CMD ["node", "app.js"]
