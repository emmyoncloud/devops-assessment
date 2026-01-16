Build dependencies
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy only package files first to leverage Docker layer caching
COPY app/package.json app/package-lock.json ./

# Install dependencies (only production for final image)
RUN npm ci --omit=dev

# Copy the rest of the source code
COPY app/ .

# Runtime image
FROM node:20-alpine AS runtime

# Set working directory
WORKDIR /app

# Create a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy built app and production dependencies from the builder stage
COPY --from=builder /app /app

# Switch to non-root user
USER appuser

# Expose app port
EXPOSE 3000

# Start the application
CMD ["node", "src/app.js"]
