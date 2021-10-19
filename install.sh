#!/bin/bash
#
# Install dotfiles safely by moving all originals out of the way then symlinking to those in this repo.
#
# Copyright (c) 2021 John Pancoast <johnpancoast.tech@gmail.com>

# TODO throw things into functions
# TODO Consider zsh

script_filepath=$(realpath $0);
project_dir=$(realpath $(dirname "${script_filepath}"));

bold_text=$(tput bold);
normal_text=$(tput sgr0);

backup_dir=$(realpath "${HOME}/.dotfiles_$(date -j '+%Y-%m-%d_%H%M%S')");

#
# Link dotfiles
#

if [[ -d "${backup_dir}" ]]; then
    echo -e "Dotfile backup directory '${backup_dir}' already exists.";
    echo "Exiting...";
    exit 1;
fi

echo -e "${bold_text}";
echo -e "Setting up dot files.";
echo -e "${normal_text}";
echo -e "Any dotfiles that would be overridden by this script will be saved in '${backup_dir}'";

# Hardlink dotfiles in homedir to those found in this repo but we move/backup files out of the way first.
echo -e "Linking dotfiles in home directory.\n"

mkdir -p ${backup_dir};

# BE CAREFUL! Not all dot files are the same. For example, .gitmodules is not a file we link the same as others.
# TODO Move dotfiles into a devoted directory so they're not in main directory.
dotfiles=(
    .bash_aliases
    .bash_profile
    .bashrc
    .git-completion.bash
    .git-prompt.bash
    .gitconfig
    .gitignore_global
    .screenrc
    .symfony-completion.bash
    .vimrc
    .vimrc-go
    .vimrc-jetbrains
)

# Link common dotfiles
for file in ${dotfiles[@]}; do
    if [[ -e "${HOME}/${file}" ]]; then
        cmd="mv ${HOME}/${file} ${backup_dir}/${file}";
        echo "${cmd}";
        ${cmd};
    fi

    cmd="ln ${project_dir}/${file} ${HOME}/${file}";
    echo "$cmd";
    ${cmd};
done;

#
# Handle special cases
#

# vim extras
echo -e "\nCopying .vim extras\n";
mkdir -p ${HOME}/.vim
cp -R ${project_dir}/.vim/* ${HOME}/.vim/

echo -e "Symlink Jetbrain's .ideavimrc file to standard .vimrc";
ln -s ${HOME}/.vimrc ${HOME}/.ideavimrc

#
# Include php syntax highlighting
#

# XXX - Skip PHP syntax highlighting step for now. Co-worker was using this but I want to review this.
# Update PHP Syntax for this machine
#php vim-php-syntax/update_syntax.php
#echo "PHP Syntax updated based on installed packages..."

#
# Get submodules and copy vim colors
#

echo "${bold_text}";
echo "Getting git submodules.";
(cd ${project_dir} && git submodule init && git submodule update);

echo "Copying vim color schemes.";
mkdir -p ${HOME}/.vim/
cp -R ${project_dir}/vim-colorschemes/colors ${HOME}/.vim/

echo "Sourcing bash profile and finishing.";
. ~/.bash_profile
