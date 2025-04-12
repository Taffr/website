# --- Build Stage ---
FROM node:18-alpine AS builder

# Install elm (and other tools)
RUN apk add --no-cache bash curl git && \
    curl -fsSL https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz \
    | gunzip > /usr/local/bin/elm && chmod +x /usr/local/bin/elm

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Build the app
RUN npm run build

# --- Serve Stage ---
FROM nginx:stable-alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built files from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx config (optional, see below)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port and run nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

