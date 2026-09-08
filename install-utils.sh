#!/usr/bin/env bash
INSTALL_PKGS="fish btop htop iotop jdupes jnettop ncdu nvtop"
# A tldr program
INSTALL_PKGS="${INSTALL_PKGS} tealdeer"
# a cat clone with syntax highlighting and Git integration
INSTALL_PKGS="${INSTALL_PKGS} bat"
# Better ls replacement
INSTALL_PKGS="${INSTALL_PKGS} eza"
# Better cd replacement
INSTALL_PKGS="${INSTALL_PKGS} zoxide fzf"
# Needed for rust and cargo-update
INSTALL_PKGS="${INSTALL_PKGS} gcc pkg-config"

APT_INSTALL_PKGS="${INSTALL_PKGS} micro nala libssl-dev"
ZYPPER_INSTALL_PKGS="${INSTALL_PKGS} micro-editor libopenssl-devel"

echo "Install base utils"
if [[ -f $(which apt) ]]; then
	echo $APT_INSTALL_PKGS
	sudo apt-get update
	sudo apt-get install ${APT_INSTALL_PKGS}
	BASE_PKGS_INSTALL_RESULT=$?
elif [[ -f $(which zypper) ]]; then
	echo $ZYPPER_INSTALL_PKGS
	sudo zypper install ${ZYPPER_INSTALL_PKGS}
	BASE_PKGS_INSTALL_RESULT=$?
fi

if [[ ! $BASE_PKGS_INSTALL_RESULT ]]; then
	echo "ERROR: Error installing base packages, aborting. Fix this first."
	exit 1
fi

if [[ -f $(which fastfetch) ]]; then
	echo "fastfetch already installed"
else
	echo "Installing fastfetch"
	echo "TODO: zypper install for fastfetch"
	echo "Note: fastfetch should be in default ubuntu repo from 25.04 onwards"
	sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
	sudo apt-get update
	sudo apt-get install -y fastfetch
fi

echo "Install fish plugins"
if [[ $(grep jorgebucaran/fisher ~/.config/fish/fish_plugins) ]]; then
	echo "fisher already installed"
else
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi
if [[ $(grep icezyclon/zoxide.fish ~/.config/fish/fish_plugins) ]]; then
	echo "zoxide.fish already installed"
else
	# Better tab autocomplete for zoxide
	fish -c "fisher install icezyclon/zoxide.fish"
fi

# Rust + cargo
if [[ -f $(which rustc) ]] && [[ -f $(which cargo) ]]; then
	echo "Rust + cargo already installed"
else
	echo "Install rust + cargo"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
if [[ $(cargo install --list | grep cargo-update) ]]; then
  echo "cargo-update already installed"
else
	echo "Install cargo-update"
	cargo install cargo-update
fi

if [[ -f $(which dysk) ]]; then
	echo "dysk already installed"
else
	echo "Install dysk"
	source "$HOME/.cargo/env"
	cargo install --locked dysk
fi

if [[ -f $(which gh) ]]; then
  echo "Github cli already installed"
else
  echo "Install github cli"
  if [[ -f $(which apt) ]]; then
	  (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
		  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  		&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	  	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  		&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  		&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
  		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  		&& sudo apt update \
  		&& sudo apt install gh -y
  elif [[ -f $(which zypper) ]]; then
	  sudo zypper addrepo https://cli.github.com/packages/rpm/gh-cli.repo
  	sudo zypper ref
	  sudo zypper install gh
  fi
fi
