#!/bin/bash

if [ "$1" == "" ]; then
    echo "$0 [ffeil xml]"
    exit
fi

start=`date +%s`

python creurhestr.py $1 > qids.csv

end=`date +%s`

runtime=$((end-start))
echo -n "amser:"
echo $runtime
