# Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Copy app source code
COPY . .
RUN npm prune --production

# Runtime stage
FROM node:20-alpine
WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy built app
COPY --from=builder /app /app
USER appuser

EXPOSE 3000
CMD ["node", "app/src/app.js"]
