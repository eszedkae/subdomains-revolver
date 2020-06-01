#!/bin/sh

if [ -z "$1" ]; then
        echo "No Domain provided"
        exit 1
else
        amass_linux_amd64/amass enum --active -d $1 -o amass.txt
        Sublist3r/sublist3r -d $1 -o sublister.txt
        sort -u *.txt | uniq > final1.txt
        massdns/bin/massdns -s 15000 -r massdns/lists/resolvers.txt -t A -o S final1.txt -w final2.txt
        sed 's/A.*//' final2.txt | sed 's/CN.*//' | sed 's/\..$//' | uniq > live.txt
        rm final*
fi