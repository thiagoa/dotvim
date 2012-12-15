#!/bin/bash
#
# General purpose vim config, mainly tuned for PHP and node.js
#
# Do everything install tool

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

echo "symlinking vim config files..."

for file in vimrc gvimrc
do
    ls ~/.$file > /dev/null 2> /dev/null

    if [ $? -eq 0 ]; then
        echo "** watch out, backing up current .$file to .$file.backup **";
        mv ~/.$file ~/.$file.backup
    fi

    ln -s "$DIR/$file" ~/.$file
done

echo "initializing git submodules, this can take some time..."

cd $DIR
git submodule update --init --quiet

if [ $? -eq 1 ]; then
    die "!!! died with git error !!!"
fi

echo "configuring command-t, wait..."

RUBY="`which ruby`" 2> /dev/null

# Confiure command-t if ruby is available
if [ ! $RUBY == '' ]; then
    COMMANDT="$DIR/bundle/command-t/ruby/command-t"

    # Try to compile command-t
    if [ -d $COMMANDT ]; then
        cd $COMMANDT
        $RUBY extconf.rb > /dev/null
        make clean
        make > /dev/null
    fi

    cd - > /dev/null
else
    echo "** ruby not available, could not install command-t **"
fi

echo ""
echo "done"
