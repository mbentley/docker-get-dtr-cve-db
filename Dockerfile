FROM golang:1.8-alpine
MAINTAINER Matt Bentley <mbentley@mbentley.net>
COPY gen_token.go /go/src/gen_token.go
RUN cd /go/src && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o gen_token

FROM alpine:latest
MAINTAINER Matt Bentley <mbentley@mbentley.net>

RUN apk --no-cache add bash coreutils curl jq

COPY --from=0 /go/src/gen_token /gen_token
COPY get-dtr-cve-db.sh /get-dtr-cve-db.sh

CMD ["/get-dtr-cve-db.sh"]
