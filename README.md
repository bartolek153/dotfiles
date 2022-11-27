# Shell
```bash
cd dotfiles
cp ./shell/* $HOME 

 # set ZSH as default shell (log out needed)
chsh -s $(which zsh)

# Oh-My-Zsh installation
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
# git clone https://github.com/oldratlee/hacker-quotes.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/hacker-quotes

# PowerLevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

# Neovim Configuration
```bash
cd dotfiles
cp -r ./nvim/ $HOME/.config

# Check, before downloading plugins, if: 
# - Plugins call is enabled and 
# - Colorscheme call is disabled
nano $HOME/.config/nvim/init.lua

# Enter nvim
nvim # :checkhealth
```