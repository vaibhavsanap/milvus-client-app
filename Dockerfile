# syntax=docker/dockerfile:1

# Build stage
FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Important: Cross-compile for Linux!
RUN GOOS=linux GOARCH=amd64 go build -o milvus-test-app main.go

# Run stage
FROM ubuntu:22.04

WORKDIR /

COPY --from=builder /app/milvus-test-app .

ENTRYPOINT ["/milvus-test-app"]