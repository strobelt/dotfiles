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
sudo apt install -y git wget jq

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
sudo apt install -y fonts-firacode tilix plank tar python2
sudo echo FONT=FiraCode NF Retina12 >> /etc/vconsole.conf

### Firefox dev
mkdir -p $HOME/Downloads
cd $HOME/Downloads
curl -L --output firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"
mkdir $HOME/.mozilla
sudo tar -xjf firefox.tar.bz2 -C $HOME/.mozilla
