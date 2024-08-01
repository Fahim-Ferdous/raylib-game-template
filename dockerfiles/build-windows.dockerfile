FROM dockcross/windows-static-x64:latest

RUN ln -s /bin/make /bin/mingw32-make

RUN useradd builder -d /game
USER builder

COPY --chown=builder . /game
WORKDIR /game

RUN git submodule update --recursive --init

RUN cd raylib/src && make clean && \
    make OS=Windows_NT CC=x86_64-w64-mingw32.static-gcc BUILD_MODE=RELEASE PLATFORM_SHELL=sh
RUN cd src && make clean && \
    make OS=Windows_NT CC=x86_64-w64-mingw32.static-gcc BUILD_MODE=RELEASE PLATFORM_SHELL=sh && \
    make OS=Windows_NT PLATFORM_SHELL=sh install

