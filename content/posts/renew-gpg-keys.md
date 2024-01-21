---
title: "Renew GPG keys"
date: 2024-01-20T15:14:00+11:00
tags: ["wfh", "security", "compliance", "gpg", "ssh", "yubikey", "renew"]
---

It's been a year since [I setup my GPG + Yubikey](/posts/my-workstation-setup/). It has now been expired and we need to renew the keys.
 
## Step 1: Import the master key

First step is to unplug the Yubikey, grab the master key USB and import it

```bash
$ mv .gnupg .gnupg_backup
$ gpg --import /Volumes/Superkey/gpg-keys.txt
```
We should see the **C**erify key has now been imported

```bash
$ gpg --list-keys
[keyboxd]
---------
pub   ed25519 2023-01-17 [C] [expired: 2024-01-17]
      E078ECC765D900C33AEDD9F7A85791287A30BB7D
uid           [ expired] Nam Nguyen <nam.nguyen@indebted.co>
uid           [ expired] Nam Nguyen <me@namnd.com>
```

## Step 2: Renew the master key and subkeys

```bash
$ gpg --edit-key E078ECC765D900C33AEDD9F7A85791287A30BB7D
...
sec  ed25519/A85791287A30BB7D
     created: 2023-01-17  expired: 2024-01-17  usage: C   
     trust: unknown       validity: expired
ssb  ed25519/54D86DA33E656F30
     created: 2023-01-17  expired: 2024-01-17  usage: S   
ssb  ed25519/658ACB5E9B68F187
     created: 2023-01-17  expired: 2024-01-17  usage: A   
ssb  cv25519/EFE51D7E3622FA6A
     created: 2023-01-21  expired: 2024-01-17  usage: E   
[ expired] (1). Nam Nguyen <nam.nguyen@indebted.co>
[ expired] (2)  Nam Nguyen <me@namnd.com>

gpg> expire
Key is valid for? (0) 1y

# We also want to renew the subkeys
gpg> key 1
gpg> expire
Key is valid for? (0) 1y
gpg> key 2
gpg> expire
Key is valid for? (0) 1y
...
# and so on

# Finally, make sure to trust the changed keys
gpg> trust
```

## Step 3: Export all secret keys back to the USB stick(s)

```bash
# Export all secret keys to Superkey USB
$ gpg --armor --output /Volumes/Superkey/gpg-keys-2024.txt --export-secret-key me@namnd.com
# Export subkeys to a Subkeys USB
$ gpg --armor --output /Volumes/namnd/gpg-subkeys-2024.txt --export-secret-subkeys me@namnd.com
```

## Step 4: Delete the master key from the machine

```bash
$ gpg --delete-secret-key me@namnd.com
```

## Step 5: Finally, re-import the subkey secrets

```bash
$ gpg --import /Volumes/namnd/gpg-subkeys-2024.txt
$ gpg --list-secret-keys
[keyboxd]
---------
sec#  ed25519 2023-01-17 [C] [expires: 2025-01-20]
      E078ECC765D900C33AEDD9F7A85791287A30BB7D
uid           [ultimate] Nam Nguyen <me@namnd.com>
uid           [ultimate] Nam Nguyen <nam.nguyen@indebted.co>
ssb   ed25519 2023-01-17 [S] [expires: 2025-01-20]
ssb   ed25519 2023-01-17 [A] [expires: 2025-01-20]
ssb   cv25519 2023-01-21 [E] [expires: 2025-01-20]
```

Plug in the Yubikey, and everything is ready to go

```bash
$ gpg --card-status
...
sec#  ed25519/A85791287A30BB7D  created: 2023-01-17  expires: 2025-01-20
ssb   ed25519/54D86DA33E656F30  created: 2023-01-17  expires: 2025-01-20
ssb   ed25519/658ACB5E9B68F187  created: 2023-01-17  expires: 2025-01-20
ssb   cv25519/EFE51D7E3622FA6A  created: 2023-01-21  expires: 2025-01-20
```
