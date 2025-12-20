# My Dotfiles

Personal configuration files managed with GNU Stow.

## Installation

1. Install GNU Stow:
   ```bash
   # Ubuntu/Debian
   sudo apt install stow
   
   # macOS
   brew install stow
   ```

2. Clone and install:
   ```bash
   git clone <your-repo-url> ~/.dotfiles
   cd ~/.dotfiles
   ./install
   ```

## Structure

Each directory represents a "package" that gets stowed to your home directory:

- `vim/` → `~/.vim/` and `~/.vimrc`
- `tmux/` → `~/.tmux.conf`
- `zsh/` → `~/.zshrc`, `~/.zsh/`

## Usage

- Install all configs: `./install`
- Install specific config: `stow vim`
- Remove config: `stow -D vim`
- Reinstall config: `stow -R vim`

## Adding New Configs

1. Create a new directory (e.g., `git/`)
2. Add your config files in the expected structure
3. Add the directory name to `STOW_FOLDERS` in the install script
