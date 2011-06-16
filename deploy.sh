echo "starting mongodb"
sudo mongod -f /opt/local/etc/mongodb/mongod.conf 

echo "generate site"
./node_modules/.bin/docpad generate

echo "publishing!"
rsync -aP out framallo@framallo.com:public_html

open http://framallo.com
