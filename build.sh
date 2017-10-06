#!/bin/sh
# Build and install mecab and unidic.
set -e
set -u
set -o pipefail

# When setup.py calls this script it will pass the script install directory.
# Mecab needs that when building since it requires an absolute path for the
# global config file.
mecab_root="$1/../" 

# Unpack the source and build Mecab.
tar xvzf sources/mecab.tar.gz
cd mecab-0.996
./configure --enable-utf8-only --with-charset=utf8 --prefix="$mecab_root"
make
make install
cd ..

# Unpack the prebuilt unidic and put it in the fake root.
tar xvzf sources/unidic.tar.gz 
mv unidic-mecab-2.1.2_bin "$mecab_root/lib/mecab/dic/unidic"

# Update the mecabrc to use unidic.
sed -i "s|.*dicdir.*|dicdir = $mecab_root/lib/mecab/dic/unidic|" "$mecab_root/etc/mecabrc"

# All done.
