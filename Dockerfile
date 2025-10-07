# Use official Node.js image as the base image
FROM node:18-alpine AS builder

# Set working directory inside the container
WORKDIR /app

# Copy only package files first for caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all remaining source code
COPY . .

# Build the Next.js app
RUN npm run build

# -------------------------------
# Production stage
# -------------------------------
FROM node:18-alpine

WORKDIR /app

# Copy only built assets from builder
COPY --from=builder /app ./

# Expose the app port
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]
