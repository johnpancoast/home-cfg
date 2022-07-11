# home-cfg
Configuration for my unix and linux home directories; dot files, bin files, etc. 

> _I am in the process of managing dotfiles similarly to [Atlassian
dotfiles tutorial](https://www.atlassian.com/git/tutorials/dotfiles), however,
this repo is still dependent on git submodules which bare repos cannot work
with. For now, the install process copies files instead of using a bare repo._

> _Much of this still has configs and scripts for bash since I have some old
> machines. Migrating to zsh will eventually happen._

> _The repo's name changed so clones of this repo must change their
remotes to this repo's URL at
[git@github.com:johnpancoast/home-cfg](git@github.com:johnpancoast/home-cfg.git)._

## Install
> _This will only work for bash. For zsh you must manually copy files and some
> script syntax may need to be modified._

* Clone the repo.
* Run `install.sh` to copy files to home dir. Files and directories to be copied
  will be backed up first.

# TODO
* Add zsh aliternatives.

* I think the git submodules are mis-configured. Look into that.

* Some of the files in this repo should be moved to their own repo and brought
  in via git submodules.
