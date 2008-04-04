#!/bin/bash
FROM_DIR="/opt/local/lib/"
TO_DIR="/usr/local/git/lib/"

mkdir -p $TO_DIR
pushd $FROM_DIR
cp -R libcrypto.0.9.8.dylib libexpat.dylib \
			libz.1.2.3.dylib libcrypto.dylib \
			libssl.0.9.8.dylib libz.1.dylib \
			libexpat.1.5.2.dylib libssl.dylib $TO_DIR

cd $TO_DIR
strip *.dylib
popd
