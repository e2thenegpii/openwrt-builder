
openwrt-builder is a Docker container to help building openwrt-images.

Example build command
```sh
mkdir files
docker build --build-arg "branch=openwrt-18.06" --build-arg "overlay=./overlay" --build-arg "configfile=./config" --tag openwrt-builder .
# Dont use --rm because we need to copy out the artifacts
docker run -it --name builder openwrt-builder -j10
docker cp /src/openwrt/bin /output
# Now clean up the container
docker container rm builder
```
