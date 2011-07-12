---
layout: video_post
title: Publishing videos
categories: [en]
---

I was wondering about which video platform should I use to publish my videos.

My concerns are:
- I don't want to release ownership to other sites 
- I don't want to pay $10+ monthly payments to have everything 
- I hate weekly quotas.

So I considered several services:

# Vimeo

Cons:

- Doesn't support commercial videos
- Weekly limit of 500MB
- 1 HD video upload per week

Of course you can always update to **Vimeo plus+** and pay $9.95/month and increase your storage space to 5GB/week.


# Youtube

Is limited to 15m videos. 

What about that 20m you always wanted to share with the world??


# Solution

I decided to flight solo. Use my own tools. And server.
The main components are:
- [Handbrake](http://handbrake.fr/) to encode the videos
- [VLC](http://www.videolan.org/vlc/) to create thumbnails
- [Videojs](http://videojs.com/) as HTML5 video player that fallback to flash.

I want to script as much as possible. And so far I build a script to create the thumbs. Check it out

# thumb.sh
{% highlight bash %}

#!/bin/bash

V=$1

# filename without extension
B=${V##*/}
F=${B%.*}

vlc -I dummy  --video-filter scene -V dummy \
              --scene-format=jpg --scene-replace \
              --start-time=6 --stop-time=7 \
              --scene-prefix=$F \
              --scene-path='videos' $V vlc://quit


{% endhighlight %}



# encode.sh

{% highlight bash %}

#!/bin/bash

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

{% endhighlight %}

# What do you think?

{% assign video = '2011-06-25.m4v' %}
{% assign poster ='2011-06-25.jpg' %}
{% assign video_type = 'mp4' %}
{% include video-js.html %}

