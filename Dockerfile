FROM debian:stretch

LABEL maintainer="e2thenegpii@gmail.com"

# Update the package repo
RUN apt update 2>/dev/null && apt -y upgrade 2>/dev/null

# Install required packages for buildroot
RUN apt -y install sudo build-essential libncurses5-dev gawk git libssl1.0-dev gettext zlib1g-dev swig unzip time wget file python2.7 2>/dev/null

# Add the builder user
RUN adduser --disabled-password --uid 1000 --gecos "Docker Builder,,," builder
RUN echo 'builder ALL=NOPASSWD: ALL' >> /etc/sudoers

RUN mkdir -p /src/openwrt && chown builder:builder /src/openwrt
WORKDIR /src/openwrt
USER builder

# Allow the user to specify the branch to build with
# "docker build --build-arg branch=openwrt-18.06"
ARG branch=master

# Allow the user to specify the repository to build with 
# "docker build --build-arg repo=https://github.com/e2thenegpii/openwrt.git"
ARG repo=https://git.openwrt.org/openwrt/openwrt.git
RUN git clone --single-branch -b $branch  $repo .

RUN ./scripts/feeds update -a
RUN ./scripts/feeds install -a

# Allow the user to specify the custom files that will be built into the image
# "docker build --build-arg overlay=<path_to_root_of_of_overlay_files>"
ARG overlay=./files
ADD --chown=builder:builder $overlay files/

# Allow the user to specify the config settings for the build
ARG configfile=config
ADD --chown=builder:builder $configfile .config

RUN make defconfig
RUN make download
RUN make prereq
RUN make tools/install
RUN make toolchain/install
ENTRYPOINT ["make"] 

