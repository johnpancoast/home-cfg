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

# TODO Consider using hardlinks instead.
# TODO DEFINITELY use hardlinkes instead for dotfiles. Dotfiles are edited
#      frequently and then committed to this repo so it just makes sense to
#      hard link them for ease. I cannot think of any negative effects. If
#      anything, we get a backup of exact dotfiles since their inode and
#      content are the same IF I wasn't so tired I'd just write the simple for
#      loop right now, but then testing, etc. It can wait with a todo for now.
#
# Copy the required files to the home directory
echo -n "Copying dotfiles into home directory... "
cp .bash_profile .bashrc .bash_aliases .gitconfig .gitignore_global .vimrc .ideavimrc .vim .git-prompt.bash .git-completion.bash .symfony-completion.bash .screenrc ~/

cp -R vim-colorschemes/colors ~/.vim/

#echo "[user]"$'\n\t'"email = $email"$'\n\t'"name = $name"$'\n' >> ~/.gitconfig
source ~/.bash_profile

echo "Finished!"

