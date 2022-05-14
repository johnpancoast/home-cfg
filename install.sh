#!/usr/bin/env bash
#
# Install git submodules, copy dot files, vim tools and colors, and other common *nix'y things I use to home dir.
#
# See README_NEW.md for new process that may be migrated to.
#
# Copyright (c) 2021 John Pancoast <johnpancoast.tech@gmail.com>

# TODO throw things into functions
# TODO Consider zsh

#
# Run
#

script_filepath=$(realpath $0);
project_dir=$(realpath $(dirname "${script_filepath}"));

declare -A project_paths;
project_paths[dotfiles]="${project_dir}";
project_paths[vim]="${project_dir}/.vim";
project_paths[vim-colorschemes]="${project_dir}/vim-colorschemes";

backup_dir="${HOME}/.home-cfg-backup_$(date -j '+%Y-%m-%d_%H%M%S')";

declare -A backup_paths;
backup_paths[dotfiles]="${backup_dir}/dotfiles";
backup_paths[vim]="${backup_dir}/vim";
backup_paths[vim-colorschemes]="${backup_dir}/vim/colors";

text_width="80";

bold_text=$(tput bold);
normal_text=$(tput sgr0);

#
# Init message
#

echo "${bold_text}";
echo -e "\
nix-common

Copyright (c) 2021 John Pancoast <johnpancoast.tech@gmail.com>
${normal_text}
This script will setup my common dotfiles, vim tools and colors, and \
other common *nix'y tools. Be cautious since certain file paths and \
directories copied from this script will replace those in your home directory. \
Files that would be overridden by this script will be backed up to the following \
directory:\n${backup_dir}\n" | fold -w ${text_width} -s;

read -p "${bold_text}Do you want to continue? [y/n]: ${normal_text}" input;

if [[ "${input}" != "y" ]]; then
    echo -e "\nNothing done. Exiting...\n";
    exit 0;
fi

echo -e "\nProceeding.";
echo "${normal_text}";

#
# Create backup dirs
#

# Account for backup_dir already existing. This should generally only happen if
# two calls to the script happened at the same second.
echo -e "-- Creating backup directories.\n";

if [[ -d "${backup_dir}" ]]; then
    echo "Attempted to use the following backup directory but it already exists:";
    echo -e "${backup_dir}\n";
    echo "You can generally just run the script again.";
    echo "Exiting...";
    exit 1;
fi

mkdir -p ${backup_paths[dotfiles]};
mkdir -p ${backup_paths[vim]};

#
# Backup dotfiles
#

echo -e "-- Copying the following dotfiles to your home directory after backing up the originals:\n";

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
);

# Link common dotfiles
for dotfile in ${dotfiles[@]}; do
    echo "    - ${dotfile}";

    # throw file paths into an array for easier access and sanitization
    declare -A dotfile_paths;
    dotfile_paths[home]="${HOME}/${dotfile}";
    dotfile_paths[backup]="${backup_paths[dotfiles]}/${dotfile}";
    dotfile_paths[project]="${project_paths[dotfiles]}/${dotfile}";

    # since above paths are made entirely of variables do some sanity checks
    for filepath_key in "${!dotfile_paths[@]}"; do
        filepath_value="${dotfile_paths[filepath_key]}";

        if [[ "${filepath_value}" == "/" ]]; then
            echo "${bold_text}MAJOR FAILURE! A filepath_key is defined as '/'. Exiting now...${normal_text}";
            exit 99;
        fi
    done

    if [[ -e "${dotfile_paths[home]}" ]]; then
        mv ${dotfile_paths[home]} ${dotfile_paths[backup]};
    fi

    cp -n ${dotfile_paths[project]} ${dotfile_paths[home]};
done;

# TODO Determine if jetbrains still uses .ideavimrc
echo -e "-- Symlinking Jetbrain's .ideavimrc dotfile to standard .vimrc after backing up original.\n" | fold -w ${text_width} -s;
if [[ -e "${HOME}/.ideavimrc" ]]; then
    mv ${HOME}/.ideavimrc ${backup_paths[dotfiles]}/.ideavimrc;
fi

cp -n ${project_paths[dotfiles]}/.ideavimrc ${HOME}/.ideavimrc;

#
# Include php syntax highlighting
#

# XXX - Skip PHP syntax highlighting step for now. Co-worker was using this but I want to review it.
# Update PHP Syntax for this machine
#php vim-php-syntax/update_syntax.php
#echo "PHP Syntax updated based on installed packages..."

#
# Handle vim and other cases
#

echo -e "-- Copying VIM content after backing up original content.\n";

# vim extras
declare -A vim_paths;
vim_paths[home]="${HOME}/.vim";
vim_paths[project]="${project_dir}/.vim";
vim_paths[backup]="${backup_paths[vim]}";

mkdir -p ${vim_paths[home]};
cp -R ${vim_paths[home]}/* ${vim_paths[backup]}/;
cp -R ${vim_paths[project]}/* ${vim_paths[home]}/;

#
# Get submodules and copy vim colors among other things that may be added (back) later.
#

echo -e "-- Getting git submodules including a repo for vim color schemes.\n";

(cd ${project_dir} && git submodule init && git submodule update);

echo -e "-- Copying vim color schemes. These were already backed up from the previous vim step.\n" | fold -w ${text_width} -s;

mkdir -p ${HOME}/.vim/colors
cp -R ${project_paths[vim-colorschemes]}/colors/* ${HOME}/.vim/colors/

echo -e "-- ${bold_text}Finished!\n${normal_text}";

echo -e "\
Now sourcing the ~/.bashrc file since you're already in a shell. If you'd like \
to source ~/.bash_profile, you can either open a new terminal or source the file \
manually yourself (generally, ~/.bash_profile is sourced once at the beginning of \
a terminal session). \
\n
Look into VIM's documentation for how to change color schemes. You should see \
several colors available in: ${HOME}/.vim/colors\n" | fold -w ${text_width} -s;

# Although you can, you generally don't source ~/.bash_profile more than once in
# a terminal session so we just source ~/.bashrc here.
source ~/.bashrc

