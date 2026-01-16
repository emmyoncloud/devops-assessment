# Build dependencies
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files 
COPY ./package.json ./package-lock.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy all source code
COPY . .

# Runtime image
FROM node:20-alpine AS runtime

WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy the built app and node_modules from the builder
COPY --from=builder /app /app

USER appuser

EXPOSE 3000

CMD ["node", "src/app.js"]
