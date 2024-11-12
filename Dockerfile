FROM golang:1.21-bookworm as build

WORKDIR /app

# Copy go.mod, go.sum, and the vendor directory
COPY go.* vendor/ ./

# Remove the go mod download step since we're using vendored dependencies
# RUN go mod download

# Copy the rest of the application code
COPY . ./

# Build the application using the vendored dependencies
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -mod=vendor \
    -ldflags='-w -s -extldflags "-static"' -a \
    -o /privacy-gateway-server

FROM gcr.io/distroless/static

ARG GIT_REVISION=unknown
LABEL revision ${GIT_REVISION}
COPY --from=build /privacy-gateway-server /privacy-gateway-server

EXPOSE 8082

CMD ["/privacy-gateway-server"]
