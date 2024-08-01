FROM emscripten/emsdk:latest

WORKDIR /emsdk

RUN useradd builder -d /game
USER builder

COPY --chown=builder . /game
WORKDIR /game

RUN git submodule update --recursive --init

RUN cd raylib/src && make clean && make PLATFORM=PLATFORM_WEB -B
RUN cd src && make clean && make PLATFORM=PLATFORM_WEB BUILD_MODE=RELEASE \
    && make PLATFORM=PLATFORM_WEB install
