#!/bin/bash 
sudo apt-get update -y
echo "Installing basic tools"
sudo apt update && sudo apt install -y \
    software-properties-common \
    curl \
    zip \
    unzip \
    tar \
    ca-certificates \
    git \
    wget \
    build-essential \
    vim \
    jq \
    && sudo apt clean

# Install g++14
echo "Installing g++14"
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/ppa
sudo apt install -y gcc-14 g++-14 && sudo apt clean
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 100 && \
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-14 100 && \
update-alternatives --set gcc /usr/bin/gcc-14 && \
update-alternatives --set g++ /usr/bin/g++-14

# Install SDKMAN!
echo "Installing sdkman"
curl -s "https://get.sdkman.io" | bash && \
bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
            sdk install java 23.0.1-oracle --default && \
            sdk install sbt && \
            sdk install scala 2.13.15 --default"

# Install verilator
echo "Installing verilator"
sudo apt install -y verilator


# Download and install firtools
echo "Installing firtools"
FIRTOOL_URL=$(curl -s https://api.github.com/repos/llvm/circt/releases/latest | \
    jq -r '.assets[] | select(.name == "firrtl-bin-linux-x64.tar.gz") | .browser_download_url') && \
    wget --no-check-certificate $FIRTOOL_URL -O /tmp/firtool.tar.gz && \
    mkdir -p /tmp/firtool && \
    tar -xzf /tmp/firtool.tar.gz -C /tmp/firtool && \
    sudo find /tmp/firtool -type f -name firtool -exec mv {} /usr/local/bin/ \; && \
    sudo chmod +x /usr/local/bin/firtool && \
    rm -rf /tmp/firtool /tmp/firtool.tar.gz


# Download and install OSS-CAD Suite (contains yosys)
echo "Installing OSS-CAD (yosys)"
OSS_CAD_URL=$(curl -s https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | \
    jq -r '.assets[] | select(.name | contains("linux-x64")) | .browser_download_url') && \
    wget --no-check-certificate $OSS_CAD_URL -O /tmp/oss-cad-suite.tar.xz && \
    sudo mkdir -p /opt/oss-cad-suite && \
    sudo tar -xf /tmp/oss-cad-suite.tar.xz -C /opt/oss-cad-suite --strip-components=1 && \
    rm /tmp/oss-cad-suite.tar.xz

# Add OSS-CAD Suite to PATH
PATH="/opt/oss-cad-suite/bin:${PATH}"
yosys --version
    

# Install netlistsvg (requires nodejs)
echo "Installing node.js"
curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    sudo apt install -y nodejs && \
    sudo npm install -g npm@latest

sudo npm install -g netlistsvg


# Download and install sv2v binary
echo "Installing sv2v"
SV2V_URL=$(curl -s https://api.github.com/repos/zachjs/sv2v/releases/latest | \
    jq -r '.assets[] | select(.name == "sv2v-Linux.zip") | .browser_download_url') && \
    wget $SV2V_URL -O /tmp/sv2v.zip && \
    mkdir -p /tmp/sv2v && \
    unzip /tmp/sv2v.zip -d /tmp/sv2v && \
    sudo find /tmp/sv2v -type f -name sv2v -exec mv {} /usr/local/bin/ \; && \
    sudo chmod +x /usr/local/bin/sv2v && \
    rm -rf /tmp/sv2v /tmp/sv2v.zip

sv2v --version

# Install rsvg-convert, and Inkscape
echo "Installing rsvg-convert and Inkscape"
sudo apt install -y \
    librsvg2-bin \
    inkscape \
    && sudo apt clean

rsvg-convert --version
inkscape --version

# Download uv and install it
echo "Installing uv"
sudo curl -LsSf https://astral.sh/uv/install.sh | sh
uv venv --python 3.12
source .venv/bin/activate
uv pip install -r requirements.txt


echo "Setup completed successfully!"