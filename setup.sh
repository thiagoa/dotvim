#!/bin/bash
#
# Thiago's Vim dotfiles
#
# Non-destructive-do-everything install tool

echo -e "setting up vim...\n"

# Get current script dir more or less reliably...
pushd . > /dev/null
DIR="${BASH_SOURCE[0]}";
while([ -h "${DIR}" ]) do 
    cd "`dirname "${DIR}"`"
    DIR="$(readlink "`basename "${DIR}"`")"; 
done
cd "`dirname "${DIR}"`" > /dev/null
DIR="`pwd`";
popd  > /dev/null

die() { echo "$@" 1>&2 ; exit 1; }

# Check if git repo is in ~/.vim
if [ $DIR/.git != ~/.vim/.git ]; then
    die "error: repo dir must be ~/.vim, or not a git repo"
fi

for file in vimrc gvimrc
do
    ls ~/.$file > /dev/null 2> /dev/null

    if [ $? -eq 0 ]; then
        echo "** watch out, backing up current .$file to .$file.backup **";
        mv ~/.$file ~/.$file.backup
    fi

    ln -s "$DIR/$file" ~/.$file
done

cd $DIR
git submodule update --init --quiet

if [ $? -eq 1 ]; then
    die "!!! died with git error !!!"
fi

echo -e "\ndone"
