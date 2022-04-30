# nix-home
Configuration for my unix and linux home directories; dot files, bin files, etc.

> _**NOTE:** This repo's name is changing to `nix-home`, and thus its URL will
change. Theoretically only I use this so..._

## Install
Docs to come. This repo will rely on the handy method seen at
[https://www.atlassian.com/git/tutorials/dotfiles](https://www.atlassian.com/git/tutorials/dotfiles).

# TODO
* I think the git submodules are mis-configured. Look into that.

* Some of the files in this repo should be moved to their own repo and brought
  in via git submodules.

* Create installation script for anything that needs to be downloaded.
  git-prompt.sh may be a candidate although for now it seems to be getting
  copied from here (not sure how well that'll work between version but works
  for now).

* Move standard dot files into a `dotfiles` directory to separate them from
  things like the `.gitmodules` file which should not be copied like the rest.

* Honestly, this whole repo could use some clean up. It was originally forked
  from a [co-worker](https://github.com/k-k/dotfiles) from *many* years ago, I
  have since made some major, some minor adjustments, and over time those
  adjustments have gotten uglier than intended.
