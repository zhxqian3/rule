#!/bin/bash

set -e

mkdir source
cd source

# 定义下载链接
declare -A files=(
  ["dlc.dat"]="https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat"
  ["dlc.dat.sha256sum"]="https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat.sha256sum"
  ["geoip.dat"]="https://github.com/v2fly/geoip/releases/latest/download/geoip.dat"
  ["geoip.dat.sha256sum"]="https://github.com/v2fly/geoip/releases/latest/download/geoip.dat.sha256sum"
  ["filter.txt"]="https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt"
)

echo "📥 正在下载文件..."
for filename in "${!files[@]}"; do
  url="${files[$filename]}"
  echo "➡️ $filename"
  curl -sL -o "$filename" "$url"
done

# 验证
sha256sum -c dlc.dat.sha256sum
sha256sum -c geoip.dat.sha256sum
echo -e "\n✅ 所有文件已验证成功"
