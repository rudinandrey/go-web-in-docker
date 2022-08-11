FROM golang:1.16-alpine as build
WORKDIR /build
COPY go.mod .
RUN go mod download
COPY *.go ./
RUN go build -o /main main.go
ENTRYPOINT [ "/main" ]

FROM alpine:3
COPY --from=build main /bin/main
ENTRYPOINT [ "/bin/main" ]