#!/bin/sh

[[ -z $1 ]] && echo "give a file name" && exit 1
filename=$(basename "$1")
extension="${filename##*.}"
DIR="${filename%.*}"
SPEC_FILE="${DIR%.*}"

echo $DIR
echo $SPEC_FILE


mkdir $DIR
cd $DIR

rpm2cpio ../$filename | cpio -ivd


rpmrebuild -venp ../$filename

mv usr/lib usr/lib64


rpmbuild -bb $SPEC_FILE.src.spec --buildroot=`pwd` --define '_build_id_links none'
