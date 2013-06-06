#!/bin/bash
cd `dirname $0`
DSTDIR=$1

if [ -z "$DSTDIR" ]
then
    echo "Usage: $0 <cm 10.1 dir>"
    exit 1
fi

rm -rf $DSTDIR/device/huawei

rm -rf $DSTDIR/vendor/huawei

rm -rf $DSTDIR/build
rm -rf $DSTDIR/external/bluetooth/bluez
rm -rf $DSTDIR/external/bluetooth/glib
rm -rf $DSTDIR/external/bluetooth/hcidump
rm -rf $DSTDIR/frameworks/base
rm -rf $DSTDIR/packages/apps/Bluetooth
rm -rf $DSTDIR/packages/apps/Settings
rm -rf $DSTDIR/packages/apps/Phone

rm -rf $DSTDIR/frameworks/av

(cd $DSTDIR; repo sync -j16)

echo "***********"
echo "* Result: *"
echo "***********"

(cd $DSTDIR; repo status)

