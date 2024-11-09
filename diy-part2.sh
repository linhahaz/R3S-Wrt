#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-atmaterial_new/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 最大连接数修改为1048576
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=1048576' package/base-files/files/etc/sysctl.conf

# 移除 openwrt feeds 自带的核心包
rm -rf feeds/packages/net/{alist,adguardhome,xray*,v2ray*,v2ray*,sing*,smartdns}

# golang 1.22
rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# 取消默认密码
sed -i '/\/etc\/shadow/{/root/d;}' package/lean/default-settings/files/zzz-default-settings
