#!/bin/sh

# Download and extract file
curl -L -o data-raw.json.gz https://opendata.rapid7.com/sonar.fdns_v2/2020-11-27-1606519629-fdns_cname.json.gz
gzip -d data-raw.json.gz

# Cut out timestamps
cut -c 15-24 data-raw.json > data-raw.txt
rm data-raw.json

# Count number of occurences
/opt/matlab/latest/bin/matlab -singleCompThread -nodisplay -batch rapid_write
rm data-raw.txt