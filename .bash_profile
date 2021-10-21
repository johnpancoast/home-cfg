########################################
# Things that should only run once
# in an interactive login shell
#
# PATH, etc
########################################

[[ -s ~/.bashrc ]] && source ~/.bashrc

# PATH - array of paths to be added to PATH env variable
#
# Much of PATH has already been set by certain systems (like with
# /etc/environment, for example).
paths=(
    # personal bin. place before others so personal commands can override
    # others similarly to /usr/local/bin commands overriding /usr/bin commands.
    "~/bin"

    # for homebrew
    "/usr/local/sbin"

    # android dev
    #"~/Library/Android/sdk/platform-tools"
    #"~/Library/Android/sdk/tools"

    # symfony's bin
    #"~/.symfony/bin"

    # TODO still needed?
    #"/usr/local/opt/coreutils/libexec/gnubin"

    # composer global vendor bin
    "~/.composer/vendor/bin"

    # php bin
    # TODO still needed?
    #"$(brew --prefix php@7.1)/bin"

    # go
    "~/go/bin"

    # .net
    "/usr/local/share/dotnet"

    # flutter
    "~/Computing/software/flutter/bin"
);

for i in ${paths[@]}; do
    PATH="$PATH:$i";
done

export PATH;
