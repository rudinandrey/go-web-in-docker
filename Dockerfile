FROM golang:1.16-alpine as build
WORKDIR /build
COPY go.mod .
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /main main.go

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /main /bin/main
ENTRYPOINT [ "/bin/main" ]