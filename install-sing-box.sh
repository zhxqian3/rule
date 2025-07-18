#!/bin/bash

set -e

# 获取最新版本号
latest_release=$(curl -s https://api.github.com/repos/SagerNet/sing-box/releases/latest)
version=$(echo "$latest_release" | grep '"tag_name":' | head -n 1 | sed -E 's/.*"v?([^"]+)".*/\1/')
if [ -z "$version" ]; then
  echo "❌ 未能提取版本号"
  exit 1
fi

# 编译 sing-box
cd sing-box
git checkout v${version}
make install
