FROM alpine:3.19.1
COPY cfaccess-proxy /cfaccess-proxy
ENTRYPOINT ["/cfaccess-proxy"]
