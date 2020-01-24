############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder
# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git bash
WORKDIR $GOPATH/src/casenvi/webserver/
COPY ./src/ .
# Fetch dependencies.
# Using go get.
RUN go get -d -v
# Build the binary.
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/webserver
############################
# STEP 2 build a small image
############################
FROM alpine
# Copy our static executable.
COPY --from=builder /go/bin/webserver /go/bin/webserver
# Expose port
EXPOSE 8000
# Run the  binary.
ENTRYPOINT ["/go/bin/webserver"]