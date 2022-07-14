# Set up some environment variables as /etc/environment
# isn't sourced in chroot
set -x
set -e

export HOME=/root

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -yq ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Have to manually install to avoid dependency issue
wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/armhf/containerd.io_1.5.11-1_armhf.deb
dpkg -i *.deb
rm -rf *.deb
rm -rf *.deb

DEBIAN_FRONTEND=noninteractive apt-get install -yq docker-ce docker-ce-cli docker-compose-plugin
