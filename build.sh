#!/bin/bash

git clone https://git.openwrt.org/openwrt/openwrt.git -b "${OPENWRT_VERSION}" --depth 1
curl 'http://multipath-tcp.org/patches/mptcp-v5.4.170-6c1e3d3b8a6d.patch' -o openwrt/target/linux/generic/hack-5.4/999-mptcp_v0.96.patch
#curl 'https://raw.githubusercontent.com/arinc9/openwrt/mptcpv0/target/linux/generic/hack-5.4/999-mptcp_v0.96.patch' -o openwrt/target/linux/generic/hack-5.4/999-mptcp_v0.96.patch
curl 'https://downloads.openwrt.org/releases/21.02.1/targets/x86/64/config.buildinfo' -o openwrt/.confing
#cp mptcp-kernelconfig.diff openwrt/target/linux/generic/hack-5.4/999-mptcp_v0.96_config.patch
cp config-5.4 openwrt/target/linux/x86/64/config-5.4
cp .config openwrt/
cp feeds.conf openwrt/
cd openwrt
make target/linux/{clean,prepare} V=s
./scripts/feeds update -a
./scripts/feeds install -a
make oldconfig
make -j4
