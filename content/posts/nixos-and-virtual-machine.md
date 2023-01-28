---
title: "Nix OS and Virtual machine"
date: 2023-01-26T10:22:45+11:00
tags: ["nix", "nixos", "vm", "utm", "wfh", "security", "kitty", "lemonade", "gpg"]
---

This is **Part 2** of the series about my remote workstation setup.
In the [first part](/posts/my-workstation-setup/), I talked about GnuPG and Yubikey. In this post, I will share my OS (Operating System) level setup.
This setup is heavily inspired by [Michell Hashimoto](https://github.com/mitchellh/nixos-config)

My laptop is a Macbook M1 Pro. However, I mainly use MacOS for productivity apps, such as web browser, slack, zoom, etc. that (IMHO) work best on Mac. For the development environment, I always prefer Linux.
Mac OS is pretty good for dev, I just think, Linux is still better overall. So why not combine the best of both, right?

## Mac OS - the host

Although I don't use MacOS for development, there is still a bit of setup required.
First thing is getting Nix and Home Manager, which is pretty much just a drop-in replacement for the infamous Homebrew, but better in many ways.

Tools & libraries that I have on my Mac:
  1. GnuPG
  2. [pass](https://www.passwordstore.org/) - password management tool
  3. [lemonade](https://github.com/lemonade-command/lemonade) - to sync system clipboards between the host & vm(s)
  4. [Hammerspoon](https://www.hammerspoon.org) - mostly for keyboard shortcut, and a little bit of window tiling manager
  5. [qutebrowser](https://qutebrowser.com/) - a keyboard-driven browser, is my primary web browser of choice. Secondary is Firefox, and Chrome/Safari as backup.
  6. Last but not least [kitty](https://sw.kovidgoyal.net/kitty/). I don't do any dev work in Mac, but I also don't use any GUI apps in the VM. All I need is a terminal emulator to SSH to the VM, and work inside VM's terminal.

That's it. Any other apps (slack, zoom, etc), I just download the *.dmg/.pkg* and click the buttons.

## NixOS - virtual machines

There are quite a few reasons why I use VM. Belows are the main ones

### Isolation

As a software engineer, I spend time out side of work on the laptop quite often, things like personal projects, learn new techs, and random experiments, etc.
One thing I definitely don't want is messing up work with the others.
Using one VM for work, one for personal projects, and sometime another one for random experiments, can prevent many mistakes, from simple ones such as pushing a git commit at work using my personal email, provisioning personal resources to the company's cloud provider account, to more serious like accidently exposing company codebase to my public github repos, etc. 

### Efficiency

Arguably, you can buy more devices, and use them for different purposes. In fact, that's what I did in the past for a couple of years.
After a while, I realise it's really waste of money, space, and time to manage. If I can achieve same result, using just one devices, why bother.

### Security

As you might already knew from the Part 1, I have Yubikey as a security layer, meaning for someone to access the VM, they will need to know my Yubikey PIN code.
Nevertheless, I am still not comfortable having the company's IP (Intellectual Property) or PII (Personal Identitfiable Information) sitting in my computer permanently.
Unless I know I will have to work tomorrow, I might end up destroying the VM once I finish work that day. It's a little extreme, I know.
But when working with sensitive information, and you have some what decent access to valuable information, it's always a risk, and that's just a risk I don't want to take.

### Consistency

Linux is already dominant in the server world. It's getting more and more popular in the desktop / laptop market, and I think its popularity will keep growing.
I can see myself keep using Linux for the foreseeable future.
It doesn't matter what device I might get from the next jobs, I still have a peace of mind that what I have today will continue working tomorrow.

## How

You might say, the reasons are valid, but using VM doesn't sound very practical. Does it compromise performance? Is the trade-off worth it? Personally, if using VM mean sacrifying performance and practical, I wouldn't want to use VM at all. So, how do I achieve both performance and practical?

### Performance
* My VM is super lightweight. As I mentioned earlier, I don't use any GUI applications in VM. I don't use any Desktop environment (such as Gnome, KDE), or Window titling manager (such as i3, dwm, etc). It's completely non GUI mode.
* My code editor of choice is [(neo)vim](http://neovim.io/), which is a terminal base editor. It's super fast, super lightweight, yet super powerful.

As a result, the performance of my day-to-day workflow is not affected whatsoever. It feels as smooth and responsive as I ever need.

### Practical

* For virtual machine software, I use [UTM](https://mac.getutm.app/). It's free and support ARM64 architecture pretty well.
* For Linux distribution, I use [Nix OS](https://nixos.org/).
In the past, I have used Ubuntu (2+ years), CentOS (~1 year), and Arch (1+ year). I stared using NixOS about 9 months ago. I have to say I like NixOS the most.
With NixOS, I can have my entire VM's system/user configuration as code. Hopefully I can share my thought about Nix/NixOS in depth in another post.

With this toolbox, it takes literally less than **10 minutes** for me to provisioning a fully working development environment.
I have to agree that it might not be as practical as working directly in MacOS.
However, it's still practical enough for me. All the above reasons can totally justify for 10 minutes once in a while.

That is it for **Part 2**. By no mean, this is the perfect setup. It might not work for you. Everyone is different.
One thing for sure, this setup works for me at this moment. I don't know if I would make any changes in the future, but for now I'm pretty happy with this.
