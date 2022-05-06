# home-cfg
Configuration for my unix and linux home directories; dot files, bin files, etc. 

Allows for both checking out these files into home dir and managing them in repo
from the same place and time without unnecessary linking or copying. Also allows
for using different repo branches for different system's files to be checked
out.

> _**NOTE:** The repo's name changed so clones of this repo must change their
remotes to this repo's URL at
[git@github.com:johnpancoast/home-cfg](git@github.com:johnpancoast/home-cfg.git)._

## Install / Management
This repo mostly follows an [Atlassian dotfiles
tutorial](https://www.atlassian.com/git/tutorials/dotfiles) with the addition of
using git's sparse checkout to exclude checking out certain files.

* Clone the repo into bare repo.

    ```shell
    git clone --bare <git-repo-url> $HOME/.cfg
    ```

* Create a permanent alias to work with clone. This allows one command to have
  different path for clone dir and working tree dir (which will be home dir).

    ```shell
    alias home-cfg=/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME
    ```

* Checkout repo / copy repo files to home dir.

    ```shell
    home-cfg checkout
    ```

    > _**NOTE:** The above may error if the files already exist in your home dir.
    You must first move the files out. Run the following if necessary to move the
    files first._
  
    ```shell
    backup_dir="~/.cfg-backup";
    home-cfg checkout 2>&1 | egrep "\s+" | awk {'print $1'} | xargs -I {}  sh -c '[ -f ${HOME}/${1} ] && backup_dir='$backup_dir' && dir=$(dirname $HOME/$1) && d=${dir/$HOME/"."} && mkdir -p ${backup_dir}/${d} && mv $HOME/$1 ${backup_dir}/$1' -- {};
    ```

# TODO
* I think the git submodules are mis-configured. Look into that.

* Some of the files in this repo should be moved to their own repo and brought
  in via git submodules.
