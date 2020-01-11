FROM ubuntu:18.04

RUN dpkg --add-architecture i386
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates curl xz-utils \
    libudev-dev libusb-1.0-0-dev \
    python3 python3-pip python3-dev \
    make gcc libncurses5:i386 libc6-dev-i386 \
    && rm -rf /var/lib/apt/lists/*


# Setting up the Toolchain
ENV BOLOS_ENV /opt/bolos

RUN mkdir -p $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1 \
    && curl -L https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 \
    | tar -xjC $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1 --strip 1

RUN mkdir -p $BOLOS_ENV/clang-arm-fropi \
    && curl -L https://releases.llvm.org/7.0.0/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz \
    | tar -xJC $BOLOS_ENV/clang-arm-fropi --strip 1

# Python Loader
RUN pip3 install --no-cache-dir setuptools wheel
RUN pip3 install --no-cache-dir ledgerblue