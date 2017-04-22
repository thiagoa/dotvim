#!/bin/bash
#
# Thiago's Vim setup
#
# Non-destructive-do-everything install tool

function install_plugins {
    local cmd

    if [[ -x $(which nvim 2> /dev/null) ]]; then
        cmd="nvim"
    elif [[ -x $(which vim 2> /dev/null) ]]; then
        cmd="vim"
    else
        die "ERROR: Vim not installed!"
    fi

    $cmd +PlugInstall +qall
}

function die {
    local message="$@"

    echo $message 1>&2 && exit 1
}

function ensure_directory_correct {
    if [[ ! -d $HOME/.vim ]]; then
        die "Please clone this in $HOME/.vim"
    fi
}

function symlink_config_files {
    local path

    for file in vimrc gvimrc; do
        dest_path="$HOME/.$file"

        if [[ -f $dest_path ]] || [[ -L $dest_path ]]; then
            echo "** Backing up current .$file to .${file}.backup **"

            mv $dest_path "${dest_path}.backup" 2> /dev/null
        fi

        ln -s "$HOME/.vim/$file" $dest_path 2> /dev/null
    done
}

function share_config_with_neovim {
    mkdir -p $HOME/.config 2> /dev/null
    ln -s $HOME/.vim $HOME/.config 2> /dev/null
}

function ask_install_dependencies {
    ask "Install UltiSnips deps (needs pip)" "sudo pip install neovim"
}

function ask {
    local question="${1}? (Y/n) "
    local cmd=$2

    while true; do
        read -p "${question}" answer

        case $answer in
            [Yy]*|"") eval $cmd; break;;
            [Nn]*) break;;
            *) echo "Please answer y or n.";;
        esac
    done
}

function ask_install_plugins {
    ask "Install plugins" "install_plugins"
}

echo "Setting up vim and neovim..."

ensure_directory_correct
symlink_config_files

echo ""

share_config_with_neovim
ask_install_dependencies
ask_install_plugins
