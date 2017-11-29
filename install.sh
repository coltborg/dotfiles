#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
echo "Install homebrew"
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install oh-my-zsh
echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Move zsh theme into theme folder
echo "Copy zsh theme into theme folder"
cp $HOME/.dotfiles/cobalt2.zsh-theme ~/.oh-my-zsh/themes

# Create a symbolic link to dotfile .zshrc
rm ~/.zshrc
ln -s $HOME/.dotfiles/.zshrc ~/.zshrc

# Install global NPM packages
echo "Install global NPM packages"
npm install --global yarn

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Symlink the Mackup config file to the home directory
ln -s ./.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
