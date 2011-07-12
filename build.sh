#!/bin/bash

echo "generate site"
ejekyll --server --auto &

if [ -f _site/videos ]; then
  cd _site
  ln -s ../videos 
  cd ..
fi
