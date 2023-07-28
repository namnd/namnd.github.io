---
title: "Build Zig From Source"
date: 2023-02-03T15:50:03+10:00
tags: ["note", "nixos", "zig", "direnv"]
---


## Setup

First, clone the ziglang repository

```bash
$ git clone https://github.com/ziglang/zig.git ~/zig
```

Also, clone the llvm-project as we will also build llvm package from source

```bash
$ git clone https://github.com/llvm/llvm-project ~/zig/llvm-project
```

Let's create a `shell.nix` in ~/zig

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    cmake

    # need this to build llvm
    ninja 
    python39
  ];
}
```

Next, either use [direnv](https://direnv.net/) or just type `nix-shell` to enter the nix shell which has above tools installed.
I'm using direnv
```bash
$ echo "use nix" > .envrc
$ direnv allow
```

## Build LLVM from source

```bash
$ cd ~/zig/llvm-project
$ git checkout release/15.x
$ mkdir build-release
$ cd build-release
$ cmake ../llvm \
  -DCMAKE_INSTALL_PREFIX=$HOME/local/llvm15-release \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS="lld;clang" \
  -DLLVM_ENABLE_LIBXML2=OFF \
  -DLLVM_ENABLE_TERMINFO=OFF \
  -DLLVM_ENABLE_LIBEDIT=OFF \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DLLVM_PARALLEL_LINK_JOBS=1 \
  -G Ninja
$ ninja install
```

This should take a while, could be between 30-45m, depends on your hardware specs.

Once installation completed, there should be a `~/local/llvm15-release` directory


## Build Zig from source

```bash
$ cd ~/zig
$ mkdir build
$ cd build
$ cmake .. -DCMAKE_PREFIX_PATH=$HOME/local/llvm15-release
$ make install
```

This should take between 5-10 minutes.

Verify you get the latest zig installed

```bash
$ cd ~/zig/build/stage3/bin
$ ./zig version
0.11.0-dev.1557+03cdb4fb5
```

Finally, you can just add `$HOME/zig/build/stage3/bin` to your shell config and reload.

## References

* https://github.com/ziglang/zig/wiki/Building-Zig-From-Source#option-a-use-your-system-installed-build-tools
* https://github.com/ziglang/zig/wiki/How-to-build-LLVM,-libclang,-and-liblld-from-source#posix
