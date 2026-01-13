FROM golang:1.25-alpine AS builder
WORKDIR /src
COPY application-code/go.mod application-code/go.sum ./
RUN go mod download
COPY application-code/ .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/muchtodo ./cmd/api

FROM debian:bookworm-slim
RUN useradd -u 10001 -m appuser && apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /out/muchtodo /app/muchtodo
COPY application-code/.env /app/.env
ENV PORT=3000
EXPOSE 3000
USER appuser
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD curl -fsS http://127.0.0.1:/health || exit 1
CMD ["./muchtodo"]

