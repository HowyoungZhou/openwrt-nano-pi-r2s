# Custom OpenWRT firmware for NanoPi R2S

## Packages Summary

### LuCI
- luci-theme-material
- luci-app-frpc
- luci-app-frps
- luci-app-vlmcsd (KMS)

### IPv6
- odhcp6c
- odhcpd
- ip6tables
- luci-proto-ipv6

### WireGuard
-  luci-proto-wireguard
-  luci-app-wireguard

### Utils
- curl
- git
- tcpdump
- ping
- ping6
- traceroute6
- netcat
- nano


## Compiling OpenWRT

### Installing Dependencies

```bash
sudo apt update -y
sudo apt full-upgrade -y
sudo apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev \
libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz \
mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pip qemu-utils \
rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev
```

### Configuring OpenWRT

```bash
git clone https://github.com/coolsnowwolf/lede
cd lede
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
```

### Compiling OpenWRT

```bash
make download -j8
make V=s -j1
```

### Second-time Compiling

```bash
cd lede
git pull
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make download -j8
make V=s -j$(nproc)
```

### Reconfiguring

```bash
rm -rf ./tmp && rm -rf .config
make menuconfig
make V=s -j$(nproc)
```

The output path is `bin/targets`.
