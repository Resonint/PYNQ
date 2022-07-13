SUMMARY = "Recipe for  build an external u-dma-buf Linux kernel module"
SECTION = "PETALINUX/modules"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=bebf0492502927bef0741aa04d1f35f5"

inherit module

SRC_URI = "file://Makefile \
           file://u-dma-buf.c \
           file://LICENSE \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.
