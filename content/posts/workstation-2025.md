---
title: "Workstation 2025"
date: 2025-01-01T10:07:54+10:00
draft: true
---

It's been almost 2 years since my last workstation [setup post](https://namnd.com/posts/nixos-and-virtual-machine/). At a high level, it hasn't changed much, but it's been a while, so I figured it's a good time to share some updates.

## Host - Mac OS

Not much has changed on my Macbook setup.

  * [pass](https://www.passwordstore.org/) - password management tool. I also use a private git repo to sync with my iPhone. One of the best tool I've used and would highly recommend over any password manager SaaS.
  * [Maccy](https://maccy.app/) - open source clipboard manager that supports fuzzy search. I also have a [wrapper](https://github.com/namnd/home/blob/main/home-manager/zshrc#L99-L104) to ignore any password being copied. To be honest, I don't know if I can ever live without it.
  * [lemonade](https://github.com/lemonade-command/lemonade) - to sync system clipboards between the host and the virtual machine. 
  * [Hammerspoon](https://www.hammerspoon.org) - for keyboard shortcuts & window tiling
  * ~qutebrowser~ [Zen](https://zen-browser.app/) - a lightweight Firefox based browser, something I tried recently and quite like it. However, I will use Chrome for work because of the Google Meets experience.
  * ~kitty~ [Ghostty](https://ghostty.org/) - a new terminal emulator written in Zig
  * and last but not least [UTM](https://mac.getutm.app/). It's super easy and effortless to create a new NixOS VM

> Before jumping in to the NixOS VM, I want to point out a very important thing, that is I use **Nix** (with [*Home manager*](https://github.com/nix-community/home-manager) on top) as the package manager for both Mac OS and NixOS. This allows me to have a consistent user environment across both systems. Tools like `git`, `zsh`, `gpg`, and many other cli tools I can set up once and use everywhere.

## Virtual machine - NixOS

I have tried a few different setups, like using VirtualBox or VMware Fusion with NixOS + i3. Maybe I did something wrong, or didn't spend enough time to work out the `spice-vdagent` issue, or the HiDPI config on NixOS, so I always end up going back to UTM + NixOS (via SSH) setup. This setup has worked really well for me last 2 years, so maybe there is less motivation for me to try something new.

Clone this [repo](https://github.com/namnd/home) if you want to try it yourselve.

Step 1-3 is simply install a minimal NixOS (no desktop environment) in which `root` user has password as `root`. The result of these steps is this [NixOS UTM template](https://archive.org/download/nixos-24.11-arm64.utm/nixos-24.11-arm64.utm.zip) that I've created and used myself. You can download and use it directly, or follow the steps below to create your own.

1. Use UTM to create a new VM with the following settings:

    * Custom: Virtualize
    * Preconfigured: Linux
    * Boot ISO Image: download minimal ISO image from [NixOS](https://channels.nixos.org/nixos-24.11/latest-nixos-minimal-aarch64-linux.iso)
    * Memory: `10240` (on 16GB host)
    * CPU: `8` (on 10-core host)
    * Disk: `100GB`
    * Name: `NixOS`
    * Network: `Emulated VLAN` with Port Forwarding on port 22

2. Start the VM and set root password as `root`

```bash
$ sudo -i
$ passwd
```

3. From this repo root directory, run command to install NixOS

```bash
$ make install
```

Once finish installing, shutdown the VM, remove bootable ISO, then start the VM again.

> Before continuing step 4, check out the `Makefile` and `./vm/bootstrap.nix` and make necessary changes to your custom details.

4. Run command to bootstrap the VM (create user, copy secrets, config tailscale, install home-manager, neovim, etc.)

```bash
$ make bootstrap
```

That's it. It's all good to go. You can now SSH into the VM and start using it.

