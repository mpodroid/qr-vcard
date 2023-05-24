#!/bin/bash

if [ ! $# -eq 2 ]
then
	echo "$0 <vcard-file> <jpeg-image>"
	exit 0
fi

VCARD=$1
IMAGE=$2

IDIR=`dirname ${IMAGE}`
INAME=`basename ${IMAGE}`

VDIR=`dirname ${VCARD}`
VNAME=`basename ${VCARD}`

FULLNAME=`grep FN: ${VCARD} | cut -d':' -f2-`

convert $IMAGE -quality 25% -resize 96x96 qr-codes/lowres-${INAME}


sed -e "s@^END:VCARD.*@PHOTO;ENCODING=b;TYPE=JPEG:$(cat qr-codes/lowres-${INAME} | base64 )\n&@" ${VCARD}  > qr-codes/picture-${VNAME}


qr_encode() {
	qrencode -r ${VCARD} -l M -o qr-codes/nopicture-${VNAME}.png	
}

qrencode -r ${VCARD} -l M -o qr-codes/nopicture-${VNAME}.png
qrencode -r qr-codes/picture-${VNAME} -l M -o qr-codes/picture-${VNAME}.png

convert qr-codes/picture-${VNAME}.png -pointsize 50 label:"${FULLNAME}" +swap -gravity Center -append qr-codes/picture-label-${VNAME}.png
