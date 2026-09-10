FROM ghcr.io/cebolomito/ffplayout:latest
VOLUME [ "/tmp", "/run", "/run/lock"]
CMD ["/usr/sbin/init"]
