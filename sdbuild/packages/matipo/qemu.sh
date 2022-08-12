# Set up some environment variables as /etc/environment
# isn't sourced in chroot

export HOME=/root

set -e
set -x

. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

# required for building jupyterlab with limited RAM
export NODE_OPTIONS=--max-old-space-size=2048

# TODO: replace with running an install.sh file
cd /home/xilinx/system/
python3 -m pip install ./matipo-python

cd /home/xilinx/system/
python3 -m pip install ./jupyterlab-panel-server

cd /home/xilinx/system/
python3 -m pip install ./jupyterlab-time-sync

cp /home/xilinx/system/services/*.service /etc/systemd/system/
sudo systemctl enable matipo-daemon
sudo systemctl enable matipo-jupyter

echo "xilinx ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# fix, for some reason /etc/sudoers.d/README get wrong owner
chown root:root /etc/sudoers.d/README
