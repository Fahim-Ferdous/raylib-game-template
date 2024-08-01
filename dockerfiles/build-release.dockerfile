FROM raybuild-linux as linux-builder
FROM raybuild-windows as windows-builder
FROM raybuild-web as web-builder

FROM scratch

COPY --from=web-builder     /game/dist ./
COPY --from=linux-builder   /game/dist ./
COPY --from=windows-builder /game/dist ./
