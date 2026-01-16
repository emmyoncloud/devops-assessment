# Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package.json and package-lock.json from app/
COPY app/package*.json ./

# Install dependencies
RUN npm ci

# Copy rest of the app
COPY app/ .

# Remove dev dependencies for production
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
CMD ["node", "src/app.js"]
