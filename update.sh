#!/bin/sh

if [ $# != 1 ]; then
        echo "Usage: $0 VERSIOIN"
        echo " e.g.: $0 1.1.0"
        exit 1
fi

cd $(dirname $0)

version=$1
tar_gz=groonga-$version.tar.gz
portfile=databases/groonga/Portfile

sed -E -i'' -e "s/^(version +)[a-z0-9.\-]+/\1$version/" $portfile

curl -o $tar_gz -L http://packages.groonga.org/source/groonga/$tar_gz

for type in md5 sha1 rmd160; do
        hash=$(openssl dgst -$type $tar_gz | cut -f 2 -d ' ')
        sed -E -i'' -e "s/($type +)[a-z0-9]+/\1$hash/" $portfile
done

portindex

rm $tar_gz
