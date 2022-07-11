SRC_URI += "file://0001-i2c-xilinx.cfg \
            file://0002-power-reset-gpio.cfg \
            file://0003-rtc-drv-ds1307.cfg \
            "

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
