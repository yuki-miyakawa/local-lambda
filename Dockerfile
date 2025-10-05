# Build the Go bootstrap binary
ARG TARGETOS=linux
ARG TARGETARCH=arm64

FROM public.ecr.aws/docker/library/golang:tip-trixie AS builder
WORKDIR /src

COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o bootstrap ./cmd/handler

# Package the bootstrap into the provided.al2 base image
FROM public.ecr.aws/lambda/provided:al2.2025.10.04.11
COPY --from=builder /src/bootstrap /var/runtime/bootstrap

CMD ["bootstrap"]
