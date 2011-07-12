#!/bin/bash

echo "generate site"
ejekyll --no-server 

echo "publishing!"
rsync -aP --compress-level=9 --delete  -e "ssh -c arcfour" _site/ framallo@framallo.com:public --exclude videos
rsync -aP --compress-level=9 --delete  -e "ssh -c arcfour" videos framallo@framallo.com:public

open http://framallo.com
