---
title: "Nix OS and Virtual machine"
date: 2023-01-21T10:22:45+11:00
draft: true
tags: ["nix", "nixos", "vm", "utm", "wfh", "security"]
---

This is the **Part 2** of the series about my workstation setup.
In the [first part](/posts/my-workstation-setup/), I talked about GnuPG and Yubikey. In this post, I will share my kind of Operating system level setup.

My laptop is a Mac, however, I mostly use MacOS for productivity apps, such as web browser, slack, zoom, etc. where native apps on Mac is very nice. For the development environment, I always prefer Linux.
Don't get me wrong. I think Mac OS is pretty good for dev too, I just think, Linux is still better overall. So why not combine the best of both world, right?

## Virtual machine

For virtual machine, I am using [UTM](https://mac.getutm.app/) since it's free and support ARM64 architecture pretty well.

For Linux distribution, I am using [Nix OS](https://nixos.org/). I like to call is OiC (Operating system as Code). It fits perfectly to my setup. Although I am still slowly migrating a bunch of legacy bash scripts and configuration to Nix.

I have one VM for each environment, i.e. one VM for my company's dev environment, and one VM for my personal usage.
