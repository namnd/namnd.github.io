---
title: "My workstation setup"
date: 2023-01-17T10:02:33+11:00
tags: ["wfh", "security", "compliance", "gpg", "ssh", "yubikey"]
---

I believe WFH is going to be (if not already) a new normal for the tech industry.
The benefits of it undeniably outweigh some of its disadvantages.
However, in my opinion, there is one major problem with WFH is security compliance.
There are enough stories, or articles about this, so I am not going to explain why that is the case.
Instead, I want to share my own setup, as an effort to have a reasonably secure and compliance workstation at home.

The amount of information for this setup is quite a lot.
Compress them all in one long post could make it unpleasant to follow, so I will split into multiple posts. This is **Part 1** of the series.

## Hardwares

- Macbook M1 Pro (16-inch, 2021)
- YubiKey 5C Nano

## Softwares

- [GnuPG](https://gnupg.org/)

The first and foremost thing I do whenever setting up a new workstation is to get the GPG key setup properly.
Hence in the first part of the series, I will talk about GPG and Yubikey.

*Disclaimer:* There are a few different ways to do this. This is just my personal preference.
 
## Step 1: Generate a GPG

```bash
$ gpg --full-generate-key --expert
```
A few notes
* I prefer ECC over RSA.
* I also prefer to have a single master key just for **C**ertify, one **A**uthentication only subkey for SSH authentication, and another **S**igning only subkey for signing git commits.
* I do use passphrases for the master key but not for subkeys.
* I do use multiple identities for a single primary key, i.e. one for my personal usage (me@namnd.com), another one for my current workplace. Some people might say this is not good practice, but I feel like it's just personal preference. It might also depend on the company's policy. My company is pretty flexible about this. I'm also ok with being identified and associated with the company.
After all, there is `gpg> adduid` command for a reason, right? 
* Most importantly, I do not keep the master key in the Macbook. I backed it up in a USB stick and keep it in a safe place.
I only keep **A**uthentication and **S**igning subkeys in Yubikey

```bash
# Export all keys to USB stick(s)
$ gpg --armor --output /Volumes/Untitled/gpg-keys.txt --export-secret-key me@namnd.com 
# Export subkeys to a temporary file
$ gpg --armor --output ./secret-subkeys.txt --export-secret-subkeys me@namnd.com
# Delete the whole key
$ gpg --delete-secret-key me@namnd.com
# Re-import subkeys
$ gpg --import ./secret-subkeys.txt
```
### Step 2: Use GPG key for SSH authentication

First, get the keygrip of the **A**uthentication key with command

```bash
$ gpg -K --with-keygrip
```

Grab the Keygrip of **A**uthentication key and put it into `~/.gnupg/sshcontrol`

```
$ echo ECC7FCDCAB73B03C6DB54DDB04C88772536E20ED > ~/.gnupg/sshcontrol
```

Next, enable SSH support for **gpg-agent**

```
$ echo enable-ssh-support >> ~/.gnupg/gpg-agent.conf
```

Lastly, update shell (zsh) config by adding the below

```
$ cat ~/.zshrc
...
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
```

To get public SSH key, run command

```bash
$ ssh-add -L
```

### Step 3: Import subkeys to Yubikey

First, check card status with command
```bash
$ gpg --card-status
```

If you're on MacOS, it's very likely you will get this error
```
gpg: selecting card failed: Operation not supported by device
gpg: OpenPGP card not available: Operation not supported by device
```
To fix the issue, run following commands:
```
$ echo "disable-ccid" > ~/.gnupg/scdaemon.conf
$ gpgconf --reload scdaemon
```

Once it's working, check the card status, make sure **Key attributes** is *ed25519 cv25519 ed25519* since we use ECC for all GPG keys.

Run following commands to import subkeys to Yubikey
```bash
$ gpg --edit-key E078ECC765D900C33AEDD9F7A85791287A30BB7D
gpg> key 1
gpg> keytocard
Please select where to store the key:
   (1) Signature key
   (3) Authentication key
Your selection? 1 # make sure you select the right destination for each key
gpg> key 2
gpg> keytocard
Please select where to store the key:
   (3) Authentication key
# Export public key
$ gpg --armor --export me@namnd.com > public-key
# At this point, we should have master key secret in USB, subkeys in Yubikey, public key temp file
$ rm -rf ~/.gnupg
# Import public key
$ gpg --import ./public-key
```

Now we are ready to use Yubikey for SSH authentication and signing commits.


If for some reason, you want to delete GPG records in Yubikey, follow this [instruction](https://support.yubico.com/hc/en-us/articles/360013761339-Resetting-the-OpenPGP-Applet-on-the-YubiKey)

TL;DR

```bash
$ gpg --card-status
$ gpg-connect-agent --hex
> scd apdu 00 20 00 81 08 40 40 40 40 40 40 40 40 # Repeat until "D[0000]  69 83"
> scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40 # Repeat until "D[0000]  69 83"
> scd apdu 00 e6 00 00 # Should see "D[0000]  90 00"
> scd apdu 00 44 00 00 # Should see "D[0000]  90 00"
```

Now that should be enough for **Part 1**. In the next part, we will talk about Nix OS and Virtual machine.

### References & credits

* https://github.com/YubicoLabs/sign-git-commits-yubikey
* https://opensource.com/article/19/4/gpg-subkeys-ssh
* https://rzetterberg.github.io/yubikey-gpg-nixos.html
