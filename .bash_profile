########################################
# Things that should only run once
# in an interactive login shell
#
# PATH, etc
########################################

[[ -e ~/.bashrc ]] && source ~/.bashrc;

# Add non-generic files to this array in the included file if you wish. This
# allows this .bash_profile file to stay consistent when using it via repo.
priv_paths=();
[[ -e ~/.bash_profile_priv ]] && source ~/.bash_profile_priv;

# Generic paths that can apply to all machines.
paths=(
    # user's bin. Keep as first.
    ~/bin

    # homebrew
    /usr/local/sbin

    # Do NOT commit non-generic paths here. You can instead create a
    # ~/.bash_profile_priv file and add to the paths_priv() array in that file.
    ${priv_paths[@]}
);

for path in ${paths[@]}; do
    [[ -e "${path}" ]] && PATH="${PATH}:${path}";
done

export PATH;
