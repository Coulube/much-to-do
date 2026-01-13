# ---------- BUILDER STAGE ----------
FROM golang:1.25-alpine AS builder

WORKDIR /app

# Install git (needed for some Go modules)
RUN apk add --no-cache git

# Copy go mod files first (for caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app ./cmd/api


# ---------- RUNTIME STAGE ----------
FROM alpine:latest

WORKDIR /app

# Create non-root user
RUN adduser -D appuser

# Copy binary from builder
COPY --from=builder /app/app .

# Switch to non-root user
USER appuser

# Expose application port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Run the app
CMD ["./app"]

