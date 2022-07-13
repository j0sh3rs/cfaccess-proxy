FROM scratch
COPY cfaccess-proxy /cfaccess-proxy
ENTRYPOINT ["/cfaccess-proxy"]
