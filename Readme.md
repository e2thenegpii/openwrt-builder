
openwrt-builder is a Docker container to help building openwrt-images.

Example build command
```sh
docker build --tag openwrt-builder .
docker run -it --rm --build-arg "branch=openwrt-18.06" --build-arg "overlay=./overlay" --build-arg "configfile=./config" -v ./output:/src/openwrt/bin openwrt-builder -j10
```
