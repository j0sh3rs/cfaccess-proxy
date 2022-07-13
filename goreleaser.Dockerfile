FROM scratch
COPY cfaccess-proxy /cfaccess-proxy
ENTRYPOINT ["/bin/sh", "-c", "./cfaccess-proxy"]
