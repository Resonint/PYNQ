#!/bin/bash
# This script is used to resize the ubuntu image to fill up the entire
# space available in the SDCard. Run as root if running manually.
# The sed script strips off all the comments so that we can 
# document what we're doing in-line with the actual commands
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.
exec >> /var/log/syslog
exec 2>&1

TGTDEV=/dev/mmcblk0
TGTPART_ROOTFS=/dev/mmcblk0p2
TGTPART_USERFS=/dev/mmcblk0p3
TGTDIR_USERFS=/home/xilinx/user
source /etc/environment

if [[ ${RESIZED} -eq "1" ]]; then
	echo "filesystem already resized!"
	exit 0
fi

# resize rootfs
echo ",14G" | sfdisk -N 2 ${TGTDEV} --force
partx -u ${TGTPART_ROOTFS}
resize2fs ${TGTPART_ROOTFS}

# create userfs
echo "," | sfdisk --append ${TGTDEV} --force
partx -u ${TGTDEV}
partx -u ${TGTPART_USERFS}
mkfs.ext4 ${TGTPART_USERFS}
mkdir -p ${TGTDIR_USERFS}
echo "${TGTPART_USERFS} ${TGTDIR_USERFS} ext4 defaults 0 0" >> /etc/fstab

echo "RESIZED=1" | tee -a /etc/environment

echo "Adding Swap"
fallocate -l 2G /var/swap
chmod 0600 /var/swap
mkswap /var/swap
echo "/var/swap none swap sw 0 0" >> /etc/fstab
swapon /var/swap

mount -a

chown xilinx:xilinx ${TGTDIR_USERFS}
chmod +rw ${TGTDIR_USERFS}

echo "Done!"
