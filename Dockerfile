FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libudev-dev libusb-1.0-0-dev \
    python3 python3-venv python3-pip python3-dev \
    make gcc clang-7 libc6-dev-i386 \
    gcc-arm-none-eabi libnewlib-arm-none-eabi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Make Python 3 the default
RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH

# Install the Python loader
RUN pip install --no-cache-dir setuptools wheel
RUN pip install --no-cache-dir ledgerblue

# Setting up the BOLOS toolchain
ENV BOLOS_ENV /opt/bolos

# Use system clang-7
RUN mkdir -p $BOLOS_ENV/clang-arm-fropi/bin \
    && ln -s /usr/bin/clang-7 $BOLOS_ENV/clang-arm-fropi/bin/clang

# Use system gcc-arm-none-eabi
RUN mkdir -p $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1/bin \
    && ln -s /usr/bin/arm-none-eabi-gcc $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1/bin/arm-none-eabi-gcc \
    && ln -s /usr/bin/arm-none-eabi-objcopy $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1/bin/arm-none-eabi-objcopy \
    && ln -s /usr/bin/arm-none-eabi-objdump $BOLOS_ENV/gcc-arm-none-eabi-5_3-2016q1/bin/arm-none-eabi-objdump
