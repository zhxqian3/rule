#!/bin/bash

set -e

mkdir outputs
cd outputs
cp ../source/dlc.dat ./
cp ../source/geoip.dat ./
cp ../source/filter.txt ./

# Convert geosite and geoip to sing-box format
geo convert site -i v2ray -o sing -f geosite.db dlc.dat
geo convert ip -i v2ray -o sing -f geoip.db geoip.dat

# Make sing-rule-set
sing-box geoip export cn
sing-box geoip export private
sing-box geosite export geolocation-cn
sing-box geosite export geolocation-!cn
sing-box rule-set compile geoip-cn.json
sing-box rule-set compile geoip-private.json
sing-box rule-set compile geosite-geolocation-cn.json
sing-box rule-set compile geosite-geolocation-!cn.json
sing-box rule-set convert filter.txt --type adguard
mv geosite-geolocation-!cn.json geosite-geolocation-no-cn.json
mv geosite-geolocation-!cn.srs geosite-geolocation-no-cn.srs

rm dlc.dat
rm geoip.dat
rm filter.txt
