# Debian dotfiles
Some dotfiles I use and a simple installation script to setup from a new environment


## Installation
To install everything the host machine needs to have `curl` and `sudo` available
```sh
$ apt install -y sudo curl
```

After that, download and execute the `download.sh` script to setup the environment
```sh
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/strobelt/dotfiles/debian/download.sh)"
```

## Post-install
#### NeoVim
Open it and run `:PlugInstall` to install the plugins inside `~/.vimrc`

## Environment
- zsh
    - oh-my-zsh
    - p10k
- git
- neovim
    - plug.vim

## Testing
The configuration can be tested using docker by running a debian container and execute the following commands
```sh
# Run a docker container with debian and logs into its bash
$ docker run -it --rm debian bash

# Add curl and sudo
$ apt update && apt install -y curl sudo

# Run download.sh from git
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/strobelt/dotfiles/debian/download.sh)"
```
