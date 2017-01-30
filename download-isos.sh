#!/bin/sh -xeu
DOWNLOAD_DIR=./isos
mkdir -p "${DOWNLOAD_DIR}"

centos_isos=(
  http://centos.serverspace.co.uk/centos/7.2.1511/isos/x86_64/CentOS-7-x86_64-DVD-1511.iso
  http://centos.serverspace.co.uk/centos/7.3.1611/isos/x86_64/CentOS-7-x86_64-DVD-1611.iso
)
# http://centos.serverspace.co.uk/centos/7.2.1511/isos/x86_64/sha256sum.txt
# http://centos.serverspace.co.uk/centos/7.3.1611/isos/x86_64/sha256sum.txt
centos_isos_checksums=(
  907e5755f824c5848b9c8efbb484f3cd945e93faa024bad6ba875226f9683b16
  c455ee948e872ad2194bdddd39045b83634e8613249182b88f549bb2319d97eb
)

fedora_isos=(
  https://dl.fedoraproject.org/pub/fedora/linux/releases/25/Server/x86_64/iso/Fedora-Server-dvd-x86_64-25-1.3.iso
)
# https://dl.fedoraproject.org/pub/fedora/linux/releases/25/Server/x86_64/iso/Fedora-Server-25-1.3-x86_64-CHECKSUM
fedora_isos_checksum=(
  524bd959dae09ad6fc8e0476ea478700d89f82ec5795d0b1a7b873613f3f26ac
)

ubuntu_isos=(
  http://de.releases.ubuntu.com/trusty/ubuntu-14.04.5-server-amd64.iso
  http://de.releases.ubuntu.com/xenial/ubuntu-16.04.1-server-amd64.iso
)
# http://de.releases.ubuntu.com/trusty/SHA256SUMS
# http://de.releases.ubuntu.com/xenial/SHA256SUMS
ubuntu_isos_checksum=(
  dde07d37647a1d2d9247e33f14e91acb10445a97578384896b4e1d985f754cc1
  29a8b9009509b39d542ecb229787cdf48f05e739a932289de9e9858d7c487c80
)

function download {
  declare -a isos=("${!1}")
  declare -a checksums=("${!2}")

  echo ${isos[@]}
  echo ${checksums[@]}

  for i in "${!isos[@]}"; do
    wget --directory-prefix="${DOWNLOAD_DIR}" -x -nH ${isos[$i]}
    if [ command -v sha256sum >/dev/null 2>&1 ]; then
      sha256sum ${checksums[$i]} ${isos[$i]}
    fi
  done
}

download centos_isos[@] centos_isos_checksums[@]
#download fedora_isos[@] fedora_isos_checksum[@]
#download ubuntu_isos[@] ubuntu_isos_checksum[@]
