FROM golang as builder

WORKDIR /go/src/app

ADD . .

RUN apt-get update -y
RUN apt-get install upx -y
RUN CGO_ENABLED=0 GOOS=linux 
RUN go build -ldflags "-s -w" hello.go
RUN upx --brute /go/src/app/hello

FROM busybox

COPY --from=builder /go/src/app/hello /

ENTRYPOINT /hello

