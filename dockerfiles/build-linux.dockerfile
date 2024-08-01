FROM debian:stable-slim

RUN apt update -y && apt install -y \
    git \
    build-essential \
    libasound2-dev \
    libx11-dev \
    libxrandr-dev \
    libxi-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libxcursor-dev \
    libxinerama-dev \
    libwayland-dev \
    libxkbcommon-dev

RUN useradd builder -d /game
USER builder

COPY --chown=builder . /game
WORKDIR /game

RUN git submodule update --recursive --init

RUN cd raylib/src && make clean && make
RUN cd src && make clean && make BUILD_MODE=RELEASE && make install
