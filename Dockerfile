FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates curl xz-utils \
    libudev-dev libusb-1.0-0-dev \
    python3 python3-pip python3-dev \
    make gcc libc6-dev-i386 \
    && rm -rf /var/lib/apt/lists/*

# Make Python 3 the default
RUN ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip

# Setting up the Toolchain
ENV BOLOS_ENV /opt/bolos

RUN mkdir -p $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1 \
    && curl -L https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 \
    | tar -xjC $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1 --strip-components=1 --exclude="share"

RUN mkdir -p $BOLOS_ENV/clang-arm-fropi \
    && curl -L https://releases.llvm.org/7.0.0/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz \
    | tar -xJC $BOLOS_ENV/clang-arm-fropi --strip-components=1 --exclude="share"

# Install the Python loader    
RUN pip install --no-cache-dir setuptools wheel
RUN pip install --no-cache-dir ledgerblue
