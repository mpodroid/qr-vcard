# qr-vcard

Simple command line script to add a profile picture to a vCard file.

There are many online services which do the very same, but if you are not comfortable in sharing contact details on line, this script does everything on you pc.

## Usage
QR Codes have a maximum size of 2953 bytes. There are only two options to add a profile picture:
* embed a small low-res picture encoded in Base64
* embded a link to the image hosted on the web. This option is not safe and generally vCard importer do not follow the link

The script qr-code.sh reduce size and quality of the original jpeg image and embeds it in the vCard file, transformed into a QR code that can be read and imported by aby smartphone
 
````
# Usage
./qr-code.sh <vcard-file> <jpeg-image>

# Example
./qr-code.sg sources/john-doe.vcf sources/john-doe.jpg
````

Generated vCard and QR codes files are stored under qr-codes directory

## Optimizations
The original image is rescaled to 96x96 pixels and the quality reduced. If not happy with the quality you play a little bit increasing size and/or quality. If the final size is too big, you will get an error message during QR encoding: go back to lower thresholds.


## SW Requirements
 * unix machine, eg: linux, macOS
 * convert: image magick tool to resize and reduce the jpeg image quality
 * qrencode: generates QR images

### macOS
````
brew update
brew install qrencode
brew install imagemagick
````

### Linux
````
apt-get install imagemagick qrencode
````



