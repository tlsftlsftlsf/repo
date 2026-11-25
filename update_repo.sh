#!/bin/bash
set -e
cd "$(dirname "$0")"

REPO_NAME="tlsf's Repo"
REPO_DESC="tlsf 个人专属 iOS 越狱插件源"
REPO_CODENAME="ios"

echo "==> 1. 扫描 debs 目录生成 Packages..."
dpkg-scanpackages -m ./debs > Packages

echo "==> 2. 生成 Packages.bz2 与 Packages.xz..."
bzip2 -k -f -9 Packages
xz -k -f -9 Packages

echo "==> 3. 生成 Release 文件与哈希校验..."
PKG_SIZE=$(wc -c < Packages | tr -d ' ')
PKG_MD5=$(md5 -q Packages)
PKG_SHA1=$(shasum -a 1 Packages | awk '{print $1}')
PKG_SHA256=$(shasum -a 256 Packages | awk '{print $1}')

BZ2_SIZE=$(wc -c < Packages.bz2 | tr -d ' ')
BZ2_MD5=$(md5 -q Packages.bz2)
BZ2_SHA1=$(shasum -a 1 Packages.bz2 | awk '{print $1}')
BZ2_SHA256=$(shasum -a 256 Packages.bz2 | awk '{print $1}')

XZ_SIZE=$(wc -c < Packages.xz | tr -d ' ')
XZ_MD5=$(md5 -q Packages.xz)
XZ_SHA1=$(shasum -a 1 Packages.xz | awk '{print $1}')
XZ_SHA256=$(shasum -a 256 Packages.xz | awk '{print $1}')

cat << R_EOF > Release
Origin: ${REPO_NAME}
Label: ${REPO_NAME}
Suite: stable
Version: 1.0
Codename: ${REPO_CODENAME}
Architectures: iphoneos-arm iphoneos-arm64 iphoneos-arm64e
Components: main
Description: ${REPO_DESC}
MD5Sum:
 ${PKG_MD5} ${PKG_SIZE} Packages
 ${BZ2_MD5} ${BZ2_SIZE} Packages.bz2
 ${XZ_MD5} ${XZ_SIZE} Packages.xz
SHA1:
 ${PKG_SHA1} ${PKG_SIZE} Packages
 ${BZ2_SHA1} ${BZ2_SIZE} Packages.bz2
 ${XZ_SHA1} ${XZ_SIZE} Packages.xz
SHA256:
 ${PKG_SHA256} ${PKG_SIZE} Packages
 ${BZ2_SHA256} ${BZ2_SIZE} Packages.bz2
 ${XZ_SHA256} ${XZ_SIZE} Packages.xz
R_EOF

echo "==> 索引更新完成！"
