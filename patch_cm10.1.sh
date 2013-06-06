#!/bin/bash
cd `dirname $0`
DSTDIR=$1

if [ -z "$DSTDIR" ]
then
    echo "Usage: $0 <cm 10.1 dir>"
    exit 1
fi

# device
echo ""
echo "Copying device files"
mkdir -p $DSTDIR/device/huawei
cp -r android_device_huawei/front $DSTDIR/device/huawei/

# vendor
echo ""
echo "Copying vendor files"
mkdir -p $DSTDIR/vendor/huawei
cp -r android_vendor_huawei/front $DSTDIR/vendor/huawei/

# back port bluez
echo ""
echo "Back porting bluez"
bluez_port/cm101_bluez_patch.sh $DSTDIR

# AudioRecord patch
echo ""
echo "Applying AudioRecord patch"
cat patches/AudioRecord.patch | patch -d $DSTDIR/frameworks/av/ -p1 -N -r - -s

echo "Adding CallerGeoInfo data"
#cat patches/CallerGeoInfo.patch | patch -d $DSTDIR/frameworks/base/ -p1 -N -r - -s
#cat patches/CallerGeoInfo_Phone.patch | patch -d $DSTDIR/packages/apps/ -p1 -N -r - -s
cp patches/geoloc/86_zh $DSTDIR/external/libphonenumber/java/src/com/android/i18n/phonenumbers/geocoding/data/86_zh
cp patches/geoloc/PhoneNumberMetadataProto_CN $DSTDIR/external/libphonenumber/java/src/com/android/i18n/phonenumbers/data/PhoneNumberMetadataProto_CN

echo "Done"
