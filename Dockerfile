# Start with an official image
FROM docker.io/library/golang:1.18

# Bundle the project source in the container
RUN mkdir -p /app
ADD . /app
WORKDIR /app

# Build a binary
RUN go build .

# Expose a port and set the default run command for the container
EXPOSE 8443
#CMD ["./fips-echo-server", "-address", "0.0.0.0:8443", "-fipsMode", "true"]
CMD ["./fips-echo-server", "-address", "0.0.0.0:8443"]