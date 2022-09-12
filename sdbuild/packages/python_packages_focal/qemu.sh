export HOME=/root

set -x
set -e

cd /root

#
# used first time to install latest versions
#

# cat > requirements.txt <<EOT
# pynq
# jupyterlab
# notebook
# numpy
# pandas
# scipy
# matplotlib
# pyzmq
# pyyaml==5.4.1
# pyelftools
# msgpack
# msgpack-numpy
# bokeh
# panel
# voila
# voila-gridstack
# EOT


# minimal python packages
cat > requirements.txt <<EOT
numpy==1.23.1
pandas==1.4.3
pyzmq==23.2.0
pyyaml==5.4.1
pyelftools==0.28
cffi==1.15.1
EOT

#
# used for consistent build
#

# cat > requirements.txt <<EOT
# aiohttp==3.8.1
# aiosignal==1.2.0
# anyio==3.6.1
# argon2-cffi==21.3.0
# argon2-cffi-bindings==21.2.0
# asttokens==2.0.5
# async-timeout==4.0.2
# attrs==22.1.0
# Babel==2.10.3
# backcall==0.2.0
# beautifulsoup4==4.11.1
# bleach==5.0.1
# bokeh==2.4.3
# certifi==2022.6.15
# cffi==1.15.1
# charset-normalizer==2.1.0
# cycler==0.11.0
# debugpy==1.6.2
# decorator==5.1.1
# defusedxml==0.7.1
# entrypoints==0.4
# executing==0.9.1
# fastjsonschema==2.16.1
# fonttools==4.34.4
# frozenlist==1.3.1
# future==0.18.2
# gevent==21.12.0
# greenlet==1.1.2
# idna==3.3
# importlib-metadata==4.12.0
# importlib-resources==5.9.0
# ipykernel==6.15.1
# ipython==8.4.0
# ipython-genutils==0.2.0
# jedi==0.18.1
# Jinja2==3.1.2
# json5==0.9.9
# jsonschema==4.9.1
# jupyter-client==7.3.4
# jupyter-core==4.11.1
# jupyter-server==1.18.1
# jupyter-server-proxy==3.2.1
# jupyterlab==3.4.4
# jupyterlab-pygments==0.2.2
# jupyterlab-server==2.15.0
# jupyterlab-widgets==1.1.1
# kiwisolver==1.4.4
# Markdown==3.4.1
# MarkupSafe==2.1.1
# matplotlib==3.5.2
# matplotlib-inline==0.1.3
# mistune==0.8.4
# msgpack==1.0.4
# msgpack-numpy==0.4.8
# multidict==6.0.2
# nbclassic==0.4.3
# nbclient==0.5.13
# nbconvert==6.5.0
# nbformat==5.4.0
# nest-asyncio==1.5.5
# notebook==6.4.12
# notebook-shim==0.1.0
# numpy==1.23.1
# packaging==21.3
# pandas==1.4.3
# pandocfilters==1.5.0
# panel==0.13.1
# param==1.12.2
# parso==0.8.3
# pexpect==4.8.0
# pickleshare==0.7.5
# Pillow==9.2.0
# pkg_resources==0.0.0
# pkgutil_resolve_name==1.3.10
# prometheus-client==0.14.1
# prompt-toolkit==3.0.30
# psutil==5.9.1
# ptyprocess==0.7.0
# pure-eval==0.2.2
# pycparser==2.21
# pyct==0.4.8
# pyelftools==0.28
# Pygments==2.12.0
# pynq==2.7.0
# pyparsing==3.0.9
# pyrsistent==0.18.1
# pyserial==3.5
# python-dateutil==2.8.2
# pytz==2022.1
# pyviz-comms==2.2.0
# PyYAML==5.4.1
# pyzmq==23.2.0
# requests==2.28.1
# scipy==1.9.0
# Send2Trash==1.8.0
# simpervisor==0.4
# six==1.16.0
# sniffio==1.2.0
# soupsieve==2.3.2.post1
# stack-data==0.3.0
# terminado==0.15.0
# tinycss2==1.1.1
# tornado==6.2
# tqdm==4.64.0
# traitlets==5.3.0
# typing_extensions==4.3.0
# urllib3==1.26.11
# voila==0.3.6
# voila-gridstack==0.3.0
# wcwidth==0.2.5
# webencodings==0.5.1
# websocket-client==1.3.3
# websockets==10.3
# yarl==1.8.1
# zerorpc==0.6.3
# zipp==3.8.1
# zope.event==4.5.0
# zope.interface==5.4.0
# EOT


# node is required for jupyter
# if [ ${ARCH} == 'arm' ]; then
# 	export NODE_OPTIONS=--max-old-space-size=2048
# else
# 	export NODE_OPTIONS=--max-old-space-size=4096
# fi

# install nodejs 12
# curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
# echo deb https://deb.nodesource.com/node_12.x focal main > /etc/apt/sources.list.d/nodesource.list

# TODO fix hang on the apt-get install...
# apt-get update && apt-get install -y nodejs
# if [ ${ARCH} == 'arm' ]; then
#     wget https://deb.nodesource.com/node_12.x/pool/main/n/nodejs/nodejs_12.22.6-deb-1nodesource1_armhf.deb
#     dpkg -i *.deb
#     rm -rf *.deb
# else
#     wget https://deb.nodesource.com/node_12.x/pool/main/n/nodejs/nodejs_12.22.6-deb-1nodesource1_arm64.deb
#     dpkg -i *.deb
#     rm -rf *.deb
# fi

# blas is required for numpy
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -yq libopenblas-dev

export PYNQ_VENV=/usr/local/share/pynq-venv

python3 -m venv $PYNQ_VENV
echo "source $PYNQ_VENV/bin/activate" > /etc/profile.d/pynq_venv.sh
source /etc/profile.d/pynq_venv.sh

python3 -m pip install pip==22.2.2
python3 -m pip install -r requirements.txt
rm requirements.txt
