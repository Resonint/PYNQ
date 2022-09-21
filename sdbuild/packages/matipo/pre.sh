#!/bin/bash

set -x
set -e

target=$1
target_dir=root/.cache/pip
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# sudo cp -r $script_dir/system/ $target/home/xilinx/

sudo mkdir -p $target/etc/matipo/
sudo cp $script_dir/docker-compose.yml $target/etc/matipo/
sudo cp $script_dir/matipo.service $target/etc/systemd/system/

sudo mkdir -p $target/opt/bin/
sudo cp $script_dir/poweroff-server/poweroff-server.py $target/opt/bin/
sudo cp $script_dir/poweroff-server/poweroff-server.service $target/etc/systemd/system/

if [ -d "$script_dir/pre-built/$target_dir" ]
then
    sudo mkdir -p $target/$target_dir
    sudo cp -rf $script_dir/pre-built/$target_dir/* $target/$target_dir
fi
