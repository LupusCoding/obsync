# Obsync - iOS / ipadOS

**CAUTION:** These features are not fully tested on iOS / ipadOS

## Setup

1. Open the [iSH](https://apps.apple.com/de/app/ish-shell/id1436902243) app.
2. Install git, if you don't already have it. (apk add git)
3. Create an mount directory for your Obsidian app file system: `mkdir -p /mnt/lc/Obsidian`
4. Download the obsync.sh from this repository.
5. In your favorite terminal, navigate to your download folder and use `cp obsync.sh /usr/bin/obsync`
6. Make the script executable by `sudo chmod +x /usr/bin/obsync`
7. [Create a Git public access token](./git_access_token.md)

## Usage
**IMPORTANT NOTICE:** On iOS and ipadOS, the system cuts the connection between apps, as soon as they are closed. Also, sometimes app connections get killed, if the app is in background for more then 2 minutes. Because of this, you will have to do an additional step, every time you open the iSH app: Mount the Obsidian file system

*At my current state of research, there is no way to automize the mount process. But I'm actively searching for a workaround to prevent the system from killing the app connections - which unmount the Obsidian file system from the iSH shell. All workarounds I could find so far, drain the battery drastically (about 2-5% per hour). So, I decided to not include any automation process in this version.*

### Mount the Obsidian file system
Use the following command, to start the mount process:
```bash
mount -t ios null /mnt/lc/Obsidian
```
As soon, as the apps established the connection, a "finder window" will show up. Navigate to your Obsidian app folder and click **open**.

**Caution:** This is the only case when you want to select the app folder instead of your vault folders.

**HINT:** Before closing the **iSH** app, you should use `umount /mnt/lc/Obsidian` to unmount the Obsidian app file system. Usually, it should not have any negative impact if your don't do it. But technically, files could get corrupted, if the iSH app accesses a file, while you close the app.

### Initialize a new obsidian repository
This section is used, if you want to sync a vault from your main device to an empty git repository. 

For initialization, you need to tell the script if it is a new repository or if you want to connect to an existing one.
Luckily, this requires only one optional command option.

```shell
obsync init --new --path PATH_TO_OBSIDIAN_VAULT --repo GIT_HTTPS_CLONE_URL --token GIT_PUBLIC_ACCESS_TOKEN
```

PATH_TO_OBSIDIAN_VAULT = The local path to your Obsidian vault folder. The directory with the `.obsidian` folder in it.
GIT_HTTPS_CLONE_URL      = The HTTPS url which git offers you for cloning the repository.
GIT_PUBLIC_ACCESS_TOKEN  = The token you created [here](./git_access_token.md)

**Example**
```shell
obsync init --new --path /mnt/lc/Obsidian/Aarun --repo https://github.com/lupuscoding/obsidian-aarun --token ghp_zOOpGFKHCACqXyZ9nRPvOsY3mVmOb30XwgkY
```

### Initialize an existing obsidian repository
This section is used, if you already synced the vault from your main device to git and now, you want to sync it to this device.

```shell
obsync init --path PATH_TO_OBSIDIAN_VAULT --repo GIT_HTTPS_CLONE_URL --token GIT_PUBLIC_ACCESS_TOKEN
```

PATH_TO_OBSIDIAN_VAULT = The local path to your Obsidian vault folder. The directory with the `.obsidian` folder in it.
GIT_HTTPS_CLONE_URL      = The HTTPS url which git offers you for cloning the repository.
GIT_PUBLIC_ACCESS_TOKEN  = The token you created [here](./git_access_token.md)

**Example**
```shell
obsync init --path /mnt/lc/Obsidian/Nearon --repo https://github.com/lupuscoding/obsidian-nearon --token ghp_zOOpGFKHCACqXyZ9nRPvOsY3mVmOb30XwgkY
```

### Synchronize an obsidian repository
This section is used, for every synchronization, after you initialized the obsidian repository.

```shell
obsync sync --path PATH_TO_OBSIDIAN_VAULT
```

PATH_TO_OBSIDIAN_VAULT = The local path to your Obsidian vault folder. The directory with the `.obsidian` folder in it.

**Example**
```shell
obsync sync --path /mnt/lc/Obsidian/Nearon
```

### Setup an automatic synchronization

*Currently, this is not possible on iOS and ipadOS. I'm searching for a workaround.*

## Troubleshooting
