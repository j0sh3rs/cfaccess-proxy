FROM alpine:20220328
COPY cfaccess-proxy /cfaccess-proxy
ENTRYPOINT ["/bin/sh", "-c", "./cfaccess-proxy"]
