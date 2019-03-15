#!/bin/bash

bold=`tput bold`
normal=`tput sgr0`

echo -e "${bold}Setting up Dot Files for this machine!${normal}\n"
echo -e "${bold}** This will overwrite files in ~/ **${normal}\n"

echo "Getting submodules... "
git submodule init
git submodule update

# Update PHP Syntax for this machine
php vim-php-syntax/update_syntax.php
echo "PHP Syntax updated based on installed packages..."

# Copy the required files to the home directory
echo -n "Copying dotfiles into home directory... "
cp .bash_git .bash_profile .bashrc .gitconfig .gitignore_global .vimrc .ideavimrc .vim .git-completion.bash .symfony-completion.bash ~/
cp -R vim-colorschemes/colors ~/.vim/

#echo "[user]"$'\n\t'"email = $email"$'\n\t'"name = $name"$'\n' >> ~/.gitconfig
source ~/.bashrc

echo "Finished!"

