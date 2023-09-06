#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

run_and_print() {
	eval $1

	if [ $? -eq 0 ]; then
		printf "OK!\n"
	else
		printf "Error\n"
	fi
}

sudo apt update
sudo apt install -y git wget jq xclip

### NEOVIM
printf "\n\nSETTING UP NEOVIM\n"
wget -O $HOME/nvim.deb \
    $(curl -s 'https://api.github.com/repos/neovim/neovim/releases/latest' \
    | jq -r '.assets|.[]|select(.content_type == "application/x-debian-package")|.browser_download_url')
sudo dpkg -i $HOME/nvim.deb
rm -f $HOME/nvim.deb
echo "Installing plug.vim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p $HOME/.config/nvim
printf "Linking vim config... "
run_and_print "ln -s $SCRIPT_DIR/.vimrc $HOME/.vimrc"
printf "Linking nvim config... "
run_and_print "ln -s $SCRIPT_DIR/init.vim $HOME/.config/nvim/init.vim"

### ZSHELL
printf "\n\nINSTALLING zsh AND CONFIGS\n"
sudo apt install -y zsh
printf "Setting ZSH as default shell... "
run_and_print "sudo chsh -s $(which zsh) $USER"
echo "Installing OhMyZsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "Installing p10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
printf "Linking zsh profile... "
mv $HOME/.zshrc $HOME/.zshrc.bkp
run_and_print "ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc"
printf "Linking p10k config... "
run_and_print "ln -s $SCRIPT_DIR/.p10k.zsh $HOME/.p10k.zsh"

### Terminal and misc.
sudo apt install -y fonts-firacode tmux plank
sudo echo FONT=FiraCode NF Retina12 >> /etc/vconsole.conf

if [ x$DISPLAY != x ] ; then
    echo "Installing Alacritty"
    sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
    sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
    cargo install alacritty
    run_and_print "ln -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf"
    mkdir -p $HOME/alacritty
    run_and_print "ln -s $SCRIPT_DIR/alacritty.yml $HOME/alacritty/alacritty.yml"
else
    echo "No display found, skipping Alacritty"
fi

if [ x$DISPLAY != x ] ; then
    echo "Installing Firefox Dev"
    sudo apt install -y tar
    mkdir -p $HOME/Downloads
    cd $HOME/Downloads
    curl -L --output firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"
    mkdir $HOME/.mozilla
    sudo tar -xjf firefox.tar.bz2 -C $HOME/.mozilla
else
    echo "No display found, skipping Firefox Dev"
fi

### Clojure
echo "Installing Clojure"
sudo apt install -y rlwrap openjdk-17-jdk
curl -O https://download.clojure.org/install/linux-install-1.11.1.1113.sh
chmod +x linux-install-1.11.1.1113.sh
sudo ./linux-install-1.11.1.1113.sh
