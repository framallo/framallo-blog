#!/bin/bash

# Example
# ./encode.sh /Volume/big/001.MTS 2011-07-04
#
# This whill create two files:
# * videos/2011-07-04.m4v
# * videos/2011-07-04.jpg


IN=$1
OUT=$2

#smart default to current date
OUT=${OUT:=$(date +"%Y-%m-%d")}
VIDEO=videos/$OUT.m4v

if [ -f $VIDEO ]
then
  echo ""
  echo ERROR $VIDEO exists!
  echo ""
  exit
fi

echo "Encoding"
HandBrakeCLI --optimize -f mp4 --encoder x264 --quality 32 \
  --input "$IN" --output $VIDEO

echo "Building thumb"
./thumb.sh $VIDEO

echo "DONE!"
echo ""
echo "Add to your post:"
echo ""
echo "{% assign video = '$OUT.m4v' %}"
echo "{% assign poster ='$OUT.jpg' %}"
echo "{% assign video_type = 'mp4' %}"
echo "{% include video-js.html %}"
echo ""

