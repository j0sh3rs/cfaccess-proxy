FROM alpine:20220328
WORKDIR /app
COPY app /app
ENTRYPOINT ["/bin/sh", "-c", "./main"]
