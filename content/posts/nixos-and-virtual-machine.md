---
title: "Nix OS and Virtual machine"
date: 2023-01-21T10:22:45+11:00
draft: true
tags: ["nix", "nixos", "vm", "utm", "wfh", "security", "kitty", "lemonade", "gpg"]
---

This is **Part 2** of the series about my remote workstation setup.
In the [first part](/posts/my-workstation-setup/), I talked about GnuPG and Yubikey. In this post, I will share my OS (Operating System) level setup.

My laptop is a Macbook M1 Pro. However, I mainly use MacOS for productivity apps, such as web browser, slack, zoom, etc. that (IMHO) work best on Mac. For the development environment, I always prefer Linux.
Mac OS is pretty good for dev, I just think, Linux is still better overall. So why not combine the best of both, right?

## Mac OS - the host

Although I don't use MacOS for development, there is still a bit of setup required.
First thing is getting Nix and Home Manager, which is pretty much just a drop-in replacement for the infamouse Homebrew, but better in many ways.

Tools & libraries that I have on my Mac:
  1. GnuPG
  2. [pass](https://www.passwordstore.org/) - password management tool
  3. [lemonade](https://github.com/lemonade-command/lemonade) - to sync system clipboards between the host & vm(s)
  4. [Hammerspoon](https://www.hammerspoon.org) - mostly for keyboard shortcut, and a litte bit of window tiling manager
  5. [qutebrowser](https://qutebrowser.com/) - a keyboard-driven browser, is my primary web browser of choice. Secondary is Firefox, and Chrome/Safari as backup.
  6. Last but not least [kitty](https://sw.kovidgoyal.net/kitty/). I don't do any dev work in Mac, but I also don't use any GUI apps in the VM. All I do is SSH to the VM, and work inside VM's terminal.

That's it. Any other apps (slack, zoom, etc), I just download the *.dmg/.pkg* and click the buttons.

## NixOS - virtual machines

There are a few reasons why I use VM, belows are the main ones

### Isolation

As a software engineer, I spend time out side of work on the laptop quite often, things like personal projects, learn new techs, and random experiments, etc.
One thing I definitely don't want is messing up work with others.
Simple things like pushing a git commit at work using my personal email, provisioning personal resources to the company's cloud provider account, or more serious like accidently exposing company codebase to my public github repos, etc.

### Efficiency

Arguably, you can buy more devices, and use them for different purposes. In fact, that's what I did in the past for a couple of years.
After a while, I realise it's really waste of money, space, and time to manage.

### Security

Even though, to access the VM, one will need the Yubikey, I'd rather not to have any of the company's IP (Intellectual Property) or PII (Personal Identitfiable Information)
sitting on my computer.
Unless I know I will have to work tomorrow, I might end up destroying the VM once I finish work that day. It's a little extreme, I know.
But when working with sensitive information, and you have some what decent access to valuable information, it's always a risk, and that's just a risk I don't want
to take.

### Consistency

Linux is already dominant in the server world. It's getting more and more popular in the desktop / laptop market, and I think its popularity will keep growing.
In another words, I can see myself keep using Linux for the foreseeable future.
It doesn't matter what device I get from my next jobs, I can have a piece of mind that what I have today will continue working tomorrow.

## How

Obviously, this is my workflow, my setup. It works for me for 


Also, it takes literally less than 10 minutes for me to provisioning fully working development environment at work, I think it's totally worthy to eliminate that risk.
* For personal VM, I don't care that much. My personal stuff is not that sensitive. The laptop is actually my company's asset, so having personal documents/projects in the VM and isolated to the host is more than enough.



I have one VM for my personal usage, and another one for work.
It's super [simple and easy](https://github.com/namnd/nixos/tree/main/vm) to create a new one, so it's not unusual for me to destroy the VM and re-create another one every now and then.

A couple of notes

* I use 

For virtual machine software, I use [UTM](https://mac.getutm.app/) since it's free and support ARM64 architecture pretty well.

For Linux distribution, I use [Nix OS](https://nixos.org/).
In the past, I have used Ubuntu (2+ years), CentOS (<1 year), and Arch (1+ year).
I stared using NixOS about 9 months ago. I have to say I like NixOS the most.
