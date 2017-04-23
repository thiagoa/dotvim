# Thiago's Vim Setup

Take a look at `init.vim`, `PlugFile.vim`, and files within the `config`
folder.  This configuration also works great with [neovim](https://neovim.io/).
Main features:

- Does not overwrite vim's default mappings. This is lame!
- Supports lots of languages, especially Ruby, Elixir, JavaScript and Python

## Installation:

Usable right off the bat, just clone the repo and fire setup.sh.

    $ git clone https://github.com/thiagoa/dotvim.git ~/.vim
    $ ~/.vim/setup.sh

## Create per machine configuration (optional):

    $ touch ~/.vimrc.local
    $ touch ~/.gvimrc.local
