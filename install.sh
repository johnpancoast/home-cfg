#!/usr/bin/env bash
#
# Install dotfiles, vim colors, and other common *nix'y things I use.
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
# Init message
#

if [[ -d "${backup_dir}" ]]; then
    echo -e "Dotfile backup directory '${backup_dir}' already exists.";
    echo "Exiting...";
    exit 1;
fi

echo "${bold_text}";
echo -e "This script will setup my common dotfiles, vim colors, and other useful terminal tools.";
echo -e "Be cautious since these files and directories WILL be placed in your home directory!";
echo -e "Dotfiles that would be overridden by this script will be saved to '${backup_dir}'.";
read -p "If you want to continue, hit [Enter]. ";
echo "${normal_text}";

#
# Backup and hardlink dotfiles
#

mkdir -p ${backup_dir};

# BE CAREFUL! We do not want to link all dotfiles that exist in this repo, only those that make sense.
# TODO Move dotfiles into a devoted `dotfiles` directory in this repo so they're not in main repo directory.
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

echo -e "Hard linking the following dotfiles in home directory.\n"

# Link common dotfiles
for file in ${dotfiles[@]}; do
    echo "  ${file}";

    if [[ -e "${HOME}/${file}" ]]; then
        mv ${HOME}/${file} ${backup_dir}/${file};
    fi

    ln ${project_dir}/${file} ${HOME}/${file};
done;

#
# Handle special cases
#

# vim extras
echo "${bold_text}";
echo -e "Copying .vim extras";
echo "${normal_text}";
mkdir -p ${HOME}/.vim
cp -R ${project_dir}/.vim/* ${HOME}/.vim/

# TODO Determine if jetbrains still uses .ideavimrc
echo "Symlinking Jetbrain's .ideavimrc file to standard .vimrc";
if [[ -e "${HOME}/.ideavimrc" ]]; then
    mv ${HOME}/.ideavimrc ${backup_dir}/.ideavimrc;
fi

ln -s ${HOME}/.vimrc ${HOME}/.ideavimrc

#
# Include php syntax highlighting
#

# XXX - Skip PHP syntax highlighting step for now. Co-worker was using this but I want to review it.
# Update PHP Syntax for this machine
#php vim-php-syntax/update_syntax.php
#echo "PHP Syntax updated based on installed packages..."

#
# Get submodules and copy vim colors among other things that may be added (back) later.
#

echo "${bold_text}";
echo "Getting git submodules including a repo for vim color schemes.";
echo "${normal_text}";

(cd ${project_dir} && git submodule init && git submodule update);

echo "${bold_text}";
echo "Copying vim color schemes.";
echo "${normal_text}";

mkdir -p ${HOME}/.vim/
cp -R ${project_dir}/vim-colorschemes/colors ${HOME}/.vim/

echo -e "Will now source ~/.bashrc since you're already in a shell. Open a new shell or source ~/.bash_profile if you'd like.\n";
echo "Look into VIM's documentation for how to change color schemes. You should see several colors available in:";
echo -e "${HOME}/.vim/colors\n";
echo "${bold_text}Finished!${normal_text}";

# We don't source ~/.bash_profile since that is intended to be sourced upon terminal initialization.
# We instead source ~/.bashrc then let the user decide.
. ~/.bashrc
