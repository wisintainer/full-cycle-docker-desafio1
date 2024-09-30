FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod .
COPY hello.go .

RUN go mod download
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o hello .

FROM scratch

COPY --from=builder /app/hello /hello

CMD ["./hello"]