
openwrt-builder is a Docker container to help building openwrt-images.

Example build command
```sh
mkdir files
docker build --build-arg "branch=openwrt-18.06" --build-arg "overlay=./overlay" --build-arg "configfile=./config" --tag openwrt-builder .
docker run -it --rm -v ./output:/src/openwrt/bin openwrt-builder -j10
```
