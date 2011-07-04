#!/bin/bash

echo "linking videos"
mkdir _site
cd _site
ln -s ../videos
cd ..

echo "generate site"
ejekyll --no-server 



echo "publishing!"
rsync -aP _site/ framallo@framallo.com:public

open http://framallo.com
