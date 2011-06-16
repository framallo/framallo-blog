echo "starting mongodb"
sudo mongod -f /opt/local/etc/mongodb/mongod.conf 

echo "generate site"
./node_modules/.bin/docpad generate
find out -type d -exec chmod 775 {} \;
find out -type f -exec chmod 774 {} \;

echo "publishing!"
rsync -aP out/ framallo@framallo.com:public_html

open http://framallo.com
