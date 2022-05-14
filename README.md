# home-cfg
Configuration for my unix and linux home directories; dot files, bin files, etc. 

> _**NOTE:** I am in the process of managing dotfiles similarly to [Atlassian
dotfiles tutorial](https://www.atlassian.com/git/tutorials/dotfiles), however,
this repo is still dependent on git submodules which bare repos cannot work
with. For now, the install process copies files instead of using a bare repo.

> _**NOTE:** The repo's name changed so clones of this repo must change their
remotes to this repo's URL at
[git@github.com:johnpancoast/home-cfg](git@github.com:johnpancoast/home-cfg.git)._

## Install
* Clone the repo.
* Run `install.sh` to copy files to home dir. Files and directories to be copied
  will be backed up first.

# TODO
* I think the git submodules are mis-configured. Look into that.

* Some of the files in this repo should be moved to their own repo and brought
  in via git submodules.
