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
sudo apt install -y curl git

### NEOVIM
printf "\n\nsETTING UP NEOVIM\n"
sudo apt install -y neovim
echo "Installing plug.vim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p $HOME/.config/nvim
printf "Linking vim config... "
run_and_print "ln -s $SCRIPT_DIR/.vimrc $HOME/.vimrc"
printf "Linking nvim config... "
run_and_print "ln -s $SCRIPT_DIR/init.vim $HOME/.config/nvim/init.vim"

### ZSHELL
printf "\n\niNSTALLING zsh AND CONFIGS\n"
sudo apt install -y zsh
printf "Setting ZSH as default shell... "
run_and_print "sudo chsh -s $(which zsh) $USER"
printf "Linking zsh profile... "
run_and_print "ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc"
echo "Installing OhMyZsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Installing p10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
printf "Linking p10k config... "
run_and_print "ln -s $SCRIPT_DIR/.p10k.zsh $HOME/.p10k.zsh"
