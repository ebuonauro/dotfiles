#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function doIt () {
rsync --exclude ".DS_Store" -avh --no-perms ./resources/ ~;

source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
doIt;
else
read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
doIt;
fi;
fi;

unset doIt;

function commandExists () {
command -v "${1}" >/dev/null 2>&1
}

# Install Homebrew
if ! commandExists brew; then
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

unset commandExists;

# Install Homebrew formulas
brew bundle --file=./Brewfile

# Doctor
brew doctor

echo "Done!"

