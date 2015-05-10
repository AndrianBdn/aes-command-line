#!/bin/sh

cd "$( dirname "$0" )"

[ -z "$DESTDIR" ] && DESTDIR="/usr/local"

echo "Installing to $DESTDIR..."

chmod 755 aes-encrypt.sh
cp -f aes-encrypt.sh $DESTDIR/bin/aes-encrypt
ln -sf $DESTDIR/bin/aes-encrypt $DESTDIR/bin/aes-decrypt
