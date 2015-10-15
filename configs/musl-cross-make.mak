OUTPUT = $(PWD)/../crosstools
TARGET = x86_64-linux-musl

# Recommended options for faster/simpler build
COMMON_CONFIG += --disable-nls
COMMON_CONFIG += MAKEINFO=/bin/false
GCC_CONFIG += --enable-languages=c,c++,lto
GCC_CONFIG += --disable-multilib
