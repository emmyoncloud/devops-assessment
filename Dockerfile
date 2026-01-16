# Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install --production

# Copy app source code
COPY . .

# Remove dev dependencies if any (optional here, since we used --production)
RUN npm prune --production

# Runtime stage
FROM node:20-alpine
WORKDIR /app

# Create a user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy built app from the builder stage
COPY --from=builder /app /app
USER appuser

EXPOSE 3000
CMD ["node", "app/src/app.js"]
