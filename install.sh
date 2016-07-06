#!/bin/sh

mkdir -p ${DESTDIR}${MESON_INSTALL_PREFIX}/share/vala/vapi

install -m 0644                                            \
    ${MESON_BUILD_ROOT}/src/libgamepad@sha/libgamepad.vapi \
    ${DESTDIR}${MESON_INSTALL_PREFIX}/share/vala/vapi
