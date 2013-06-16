# Lelux-0.0

A toy Linux distribution which initializes networking and boots up into a single-user terminal from the initramfs. Works in qemu. Lelux-0.0 has 16 interesting files, excluding the kernel and contents of the virtual filesystems.

This is not production-ready version. Missing: multiple users, iptables, toolchains for compiling programs, supervisor for services, package manager.

## Why do we need an unusable Linux distribution?

For education. It's easier to study and understand a system that consists of few pieces than it'd be to study large production system, which is possibly in use. Playing around with such system also makes it easier to study larger systems.

Detailed understanding about Linux systems is useful for anyone who needs to maintain or install computers. Good understanding about Linux allows you to maintain thousands of Linux-computers all by yourself.

## How to...
### How to try out Lelux?

Execute `tools/run-qemu` in a linux terminal. Requires x86_64 support.

### How to build Lelux?

Execute `tools/build` in a linux terminal. It uses parts of the operating system on my computer, so it might not build into usable distribution without some tuning.

### How to tinker around with Lelux?

Fork it. Modify the files in `etc`, `lib`, `sources`, remember to describe files you introduce into `meta` and `reason` why they are there.

## Motivation

I wanted to build a distribution from scratch, starting with a system that only holds a kernel and a shell. It came up rather easily and [was done already](http://busybox.net/~landley/ols2006/presentation.txt), it was also really too simple, so I brought networking along because the most common use for a computer these days is to access internet.

### Future Development

I'd like to put together a linux system, combining musl, clang, linux and some simple programs written in a dynamic programming language. I'll perhaps continue this until I can run nvidia accelerated Wayland compositor/Mir/Xorg and steam on it.

Ultimately I'd perhaps want a modular linux distribution, that'd be installed with exactly the tools the user wants and needs, and nothing more. Maybe with some subsystem that makes it easier to program well-behaving Linux desktop software independent of the language used.

## Philosophy

Ability to build your own distribution is the one basic freedom that Linux brings into operating systems.
