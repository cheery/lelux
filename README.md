# Lelux-0.1

Note: Project undergoing a small upgrade. Author has not gotten to update the documentation.

A toy Linux distribution which initializes networking and boots up into a single-user terminal from the initramfs. Works in qemu. Lelux-0.0 has 16? interesting files, excluding the kernel and contents of the virtual filesystems.

Thank [rickfelker](https://github.com/richfelker/) for his work on `musl-cross-make`. Thank you for everyone of you who have worked on projects related to musl, because musl made Lelux a feasible project. Thank [landley](http://landley.net/) for the breadcrumbs.

This is not production-ready version. Missing: multiple users, iptables, supervisor for services, package manager.

## Why do we need an unusable Linux distribution?

For education. And because modern Linux distributions are worse than unusable. They are unmaintainable. It's easier to study and understand a system that consists of few pieces than it'd be to study large production system, which is possibly in use. Playing around with such system also makes it easier to study larger systems.

Detailed understanding about Linux systems is useful for anyone who needs to maintain or install computers. Good understanding about Linux allows you to maintain thousands of Linux-computers all by yourself.

## How to...
### How to try out Lelux?

Execute `make enter` in a linux terminal. The command builds everything for you. It takes little bit of time but not too much, because there's no compiling of c++ -files in the toolchain.

### How to build Lelux?

Execute `make` in a linux terminal.

### How to tinker around with Lelux?

Fork it. Read the documentation, modify the files everywhere. For every file you add, remember to describe them and write down the reason why they are there.

## Motivation and history

I wanted to build a distribution from scratch, starting with a system that only holds a kernel and a shell. It came up rather easily and [was done already](http://busybox.net/~landley/ols2006/presentation.txt), it was also really too simple, so I brought networking along because the most common use for a computer these days is to access internet.

I tried out several methods to get myself a working cross-compiling toolchain. glibc+gcc, libcxx+clang both resulted in enormously lot of hacks due to cyclic dependencies. I'd feel bad for introducing them into Lelux. Finally through following the breadcrumbs I found the [musl](http://www.musl-libc.org) and the very active development community around this good project.

### Future Development

I'd like to put together a linux system, combining musl, linux and some simple programs written in a dynamic programming language. I'll perhaps continue this until I can run nvidia accelerated Wayland compositor/Mir/Xorg and steam on it.

Ultimately I'd perhaps want a modular linux distribution, that'd be installed with exactly the tools the user wants and needs, and nothing more. Maybe with some subsystem that makes it easier to program well-behaving Linux desktop software independent of the language used.

## Philosophy

Ability to build your own distribution is the one basic freedom that Linux brings into operating systems. This freedom is lost without vigilance, even if your software remains free.
