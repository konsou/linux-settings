#!/usr/bin/env bash
APT_INSTALL_PKGS="bat fish nala eza bashtop htop iotop jdupes jnettop ncdu nvtop tldr zoxide"
echo "Install base utils"
echo $APT_INSTALL_PKGS
sudo apt install ${APT_INSTALL_PKGS}

echo "Install rust + cargo"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Install dysk"
source "$HOME/.cargo/env"
cargo install --locked dysk

echo "Install github cli"
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
