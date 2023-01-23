#!/bin/bash

set -e
set -x

echo "cam 1"
/home/priffapiwr/qids/qidcreu.sh /home/priffapiwr/qids/popeth-cymru-gyda-qid.xml

echo "cam 2"
touch /home/priffapiwr/qids/enwauQID.lua && cp /home/priffapiwr/qids/enwauQID.lua /home/priffapiwr/qids/enwauQID-bak.lua
php /home/priffapiwr/qids/sparqlhorse2.php /home/priffapiwr/qids/qids.csv > /home/priffapiwr/qids/enwauQID.lua
cp /home/priffapiwr/qids/enwauQID.lua /home/priffapiwr/lua/

