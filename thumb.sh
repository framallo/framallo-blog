#!/bin/bash

# Example
# ./thumb.sh videos/2011-06-25.m4v

V=$1

# filename without extension
B=${V##*/}
F=${B%.*}

vlc -I dummy  --video-filter scene -V dummy --no-audio \
              --scene-format=jpg --scene-replace \
              --start-time=6 --stop-time=7 \
              --scene-prefix=$F \
              --scene-path='videos' $V vlc://quit

