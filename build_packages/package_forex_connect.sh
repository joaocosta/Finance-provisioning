#!/bin/sh

set -e


VERSION=1.2.2
ARCH=x86_64

INSTALLDIR=/tmp/build-ForexConnectAPI-$VERSION-$ARCH
SOURCE_DIR=ForexConnectAPI-$VERSION-Linux-$ARCH
SOURCE_FILE=$SOURCE_DIR.tar.gz
URL=https://files.fxcorporate.com/api/fxc-$VERSION/$SOURCE_FILE


rm -f libforexconnect*rpm
rm -fR $INSTALLDIR
mkdir -p $INSTALLDIR

wget -N $URL
tar zxf $SOURCE_FILE -C $INSTALLDIR
mv $INSTALLDIR/$SOURCE_DIR/lib $INSTALLDIR/$SOURCE_DIR/lib64
#mv $INSTALLDIR/$SOURCE_DIR/include/ $INSTALLDIR/$SOURCE_DIR/forexconnect
#mkdir -p $INSTALLDIR/$SOURCE_DIR/include/fxcm
#mv $INSTALLDIR/$SOURCE_DIR/forexconnect $INSTALLDIR/$SOURCE_DIR/include/fxcm

fpm -t rpm --provides="libfxmsg.so()(64bit)" --provides="libForexConnect.so()(64bit)" --description="FXCM ForexConnect API" -m "joaocosta@zonalivre.org" -s dir -n libforexconnect -v $VERSION -C $INSTALLDIR/$SOURCE_DIR --prefix /usr lib64
fpm -t rpm --description="FXCM ForexConnect API" -m "joaocosta@zonalivre.org" -s dir -d libforexconnect -n libforexconnect-devel -a all -v $VERSION -C $INSTALLDIR/$SOURCE_DIR --prefix /usr include
