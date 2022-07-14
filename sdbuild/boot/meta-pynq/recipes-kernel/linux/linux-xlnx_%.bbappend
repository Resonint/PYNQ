SRC_URI += " file://pynq.cfg"
SRC_URI += " file://greengrass.cfg"
SRC_URI += " file://wifi.cfg"
SRC_URI += " file://usb_serial.cfg"
SRC_URI += " file://0001-irps5401.patch"
SRC_URI += " file://docker.cfg"
SRC_URI += " file://0001-Change-bMaxBurst-and-qlen-to-the-highest-number.patch"

SRC_URI_append += " file://zynq_fpga_fix.patch"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
