export PATH := $(PWD)/crosstools/bin:$(PATH)

LINUX_VER = 4.2.3
BUSYBOX_VER = 1.24.0

TARGET = x86_64-linux-musl
ARCH = x86_64 # handle out right later

#COMMON_CONFIG = --host=$(TARGET) --prefix=/usr

-include config.mak

all: sysroot.cpio.gz steps/compile_kernel 

enter: all
	qemu-system-x86_64 -netdev user,id=nat -device virtio-net-pci,netdev=nat \
		-initrd sysroot.cpio.gz \
		-kernel kernel/arch/x86_64/boot/bzImage -m 1024M

sysroot.cpio.gz: sysroot
	./tools/mkinitramfs $< $@

sysroot: sysroot/lib/libc.so sysroot/bin/busybox sources/init
	cp sources/init sysroot/init

sysroot/lib/libc.so: steps/install_cross_compiler
	mkdir -p sysroot/lib
	cp $(PWD)/crosstools/$(TARGET)/lib/libc.so sysroot/lib
	cp -rf $(PWD)/crosstools/$(TARGET)/lib/ld-* sysroot/lib

steps/install_cross_compiler: configs/musl-cross-make.mak
	git clone https://github.com/richfelker/musl-cross-make || \
		cd musl-cross-make && git pull origin master
	cp configs/musl-cross-make.mak musl-cross-make/config.mak
	cd musl-cross-make && $(MAKE)
	touch $@

steps/install_linux_headers: steps/install_cross_compiler steps/extract-linux-$(LINUX_VER)
	cd linux-$(LINUX_VER) && $(MAKE) INSTALL_HDR_PATH=$(PWD)/sysroot/usr headers_install
	touch $@

sysroot/bin/busybox: busybox-$(BUSYBOX_VER) steps/install_linux_headers configs/busybox.config
	cp configs/busybox.config busybox-$(BUSYBOX_VER)/.config
	echo CONFIG_CROSS_COMPILER_PREFIX="$(TARGET)-" >> busybox-$(BUSYBOX_VER)/.config
	echo CONFIG_SYSROOT=$(PWD)/sysroot >> busybox-$(BUSYBOX_VER)/.config
	cd busybox-$(BUSYBOX_VER) && $(MAKE)
	mkdir -p sysroot/bin
	cp busybox-$(BUSYBOX_VER)/busybox $@
	ln -s busybox $(SYSROOT)/bin/ash || true

steps/compile_kernel: configs/linux.config steps/extract-linux-$(LINUX_VER) steps/install_linux_headers
	mkdir -p kernel
	cp configs/linux.config kernel/.config
	cd linux-$(LINUX_VER) && $(MAKE) mrproper && $(MAKE) O=$(PWD)/kernel ARCH=$(ARCH)
	touch $@

busybox-%: sources/busybox-%.tar.bz2
	tar --bzip2 -xvf $<

steps/extract-linux-%: sources/linux-%.tar.xz
	tar --xz -xvf $<
	touch $@

sources/busybox-%:
	wget -O $@ http://www.busybox.net/downloads/$(notdir $@)

sources/linux-%:
	wget -O $@ https://cdn.kernel.org/pub/linux/kernel/v4.x/$(notdir $@)

clean:
	rm -rf busybox-$(BUSYBOX_VER) linux-$(LINUX_VER)

nuke: clean
	rm -rf kernel crosstools
