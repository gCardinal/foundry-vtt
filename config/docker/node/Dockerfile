FROM node:16.13.0

# gosu is used to match the container's user with the host's
COPY --from=gosu/alpine /usr/local/bin/gosu /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
