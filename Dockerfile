# Build Stage
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files from app/ folder
COPY app/package.json app/package-lock.json ./

# Install only production dependencies in the build stage
RUN npm install --omit=dev

# Copy the rest of the app source code
COPY app/ ./

# Runtime Stage
FROM node:20-alpine

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set working directory
WORKDIR /app

# Copy only the production files from the builder stage
COPY --from=builder /app /app

# Switch to non-root user
USER appuser

# Expose app port
EXPOSE 3000

# Command to run app
CMD ["node", "src/app.js"]
