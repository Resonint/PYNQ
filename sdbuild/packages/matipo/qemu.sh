# Set up some environment variables as /etc/environment
# isn't sourced in chroot

export HOME=/root

set -e
set -x

pynq_hostname.sh ilumr

# TODO: enable service to run docker container(s)
systemctl enable matipo

echo "xilinx ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# fix, for some reason /etc/sudoers.d/README get wrong owner
chown root:root /etc/sudoers.d/README
