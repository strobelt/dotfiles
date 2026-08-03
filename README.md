# dotfiles

Personal configuration for an Arch Linux setup with i3, zsh (powerlevel10k), tmux, and Alacritty.

## Contents

| File/Dir | Purpose |
| --- | --- |
| `.zshrc` | zsh config using oh-my-zsh + powerlevel10k |
| `.p10k.zsh` | powerlevel10k prompt config (`p10k configure` to regenerate) |
| `.alacritty.toml` | Alacritty terminal config |
| `.tmux.conf` | tmux config |
| `.gitconfig` | git config (GPG signing, default branch) |
| `.xsession` | X session startup: xmodmap, wallpaper, picom |
| `.i3/config` | i3 window manager config |
| `.scripts/` | helper scripts (e.g. `changeVolume`) |
| `etc/` | system configs (`mkinitcpio.conf`, `lightdm/slick-greeter.conf`) |
| `packages` | list of installed packages |

## Usage

Clone into `~/git/dotfiles` and symlink the configs you want into your home directory:

```bash
ln -s ~/git/dotfiles/.zshrc ~/.zshrc
ln -s ~/git/dotfiles/.tmux.conf ~/.tmux.conf
# ... etc
```

Reinstall packages with yay:

```bash
yay -S --needed - < packages
```
