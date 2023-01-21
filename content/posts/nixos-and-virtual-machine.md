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

## Mac OS

Although I don't use MacOS for development, there is still a bit of setup required.
First thing is getting Nix and Home Manager, which is pretty much just a drop-in replacement for the infamouse Homebrew.

Once that is done, I can just clone my nixos repo.
This repo has pretty much everything to setup NixOS virtual machines.


## Virtual machine

If you read the previous post, you probably know I use a single GPG key with multiple identities, for personal stuffs as well as for work.
I am fairly confident that I would never mess it up because I would have one VM for my personal usage, and another separated VM for work.
This is where I make sure to have the right identity configured.

For virtual machine software, I use [UTM](https://mac.getutm.app/) since it's free and support ARM64 architecture pretty well.

For Linux distribution, I use [Nix OS](https://nixos.org/).
In the past, I have used Ubuntu (2+ years), CentOS (<1 year), and Arch (1+ year).
I stared using NixOS about 9 months ago. I have to say I like NixOS the most.
I have one VM for each environment, i.e. one VM for my company's dev environment, and one VM for my personal usage.
