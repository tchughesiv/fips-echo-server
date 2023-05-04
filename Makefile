label = quay.io/tchughesiv/fips-echo-server:go
addr = 127.0.0.1:8443

help:
	@ echo "Goals:"
	@ echo "  build - build the echo server podman container and tag it as $(label)"
	@ echo "  test  - run the tests in the container"
	@ echo "  run   - run the server in the container and expose it to $(addr)"

build:
	@ podman build --platform=linux/amd64 -t $(label) .

build-ubi:
	@ podman build --platform=linux/amd64 -t $(label)-ubi -f Dockerfile.go-toolset .

test:
	@ podman run --rm --platform=linux/amd64 $(label) go test -v ./...

test-ubi:
	@ podman run --rm --platform=linux/amd64 $(label)-ubi go test -v ./...

check:
	@ podman run --rm --platform=linux/amd64 $(label) go tool nm ./fips-echo-server | grep -i dlopen_openssl

check-ubi:
	@ podman run --rm --platform=linux/amd64 $(label)-ubi go tool nm ./fips-echo-server | grep -i dlopen_openssl

run:
	@ podman run --rm -ti --platform=linux/amd64 -p $(addr):8443 $(label)

run-ubi:
	@ podman run --rm -ti --platform=linux/amd64 -p $(addr):8443 $(label)-ubi

push:
	@ podman push $(label)

push-ubi:
	@ podman push $(label)-ubi