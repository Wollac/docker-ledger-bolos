FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates curl \
    libudev-dev libusb-1.0-0-dev \
    python3 python3-pip python3-dev \
    make gcc clang-7 libc6-dev-i386 \
    && rm -rf /var/lib/apt/lists/*

# Make Python 3 the default
RUN ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip

# Setting up the BOLOS toolchain
ENV BOLOS_ENV /opt/bolos

# Download gcc-arm-none-eabi in the corresponding version
RUN mkdir -p $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1 \
    && curl -L https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 \
    | tar -xjC $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1 --strip-components=1 --exclude="share"
ENV PATH="$BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1/bin:$PATH"

# Use system clang-7
RUN mkdir -p $BOLOS_ENV/clang-arm-fropi/bin \
    && ln -s /usr/bin/clang-7 $BOLOS_ENV/clang-arm-fropi/bin/clang

# Install the Python loader
RUN pip install --no-cache-dir setuptools wheel
RUN pip install --no-cache-dir ledgerblue
