# Obsync - MacOS

## Setup

1. Open your favorite terminal.
2. Install git, if you don't already have it. (brew)
3. Download the obsync.sh from this repository.
4. In your favorite terminal, navigate to your download folder and use `cp obsync-unix.sh /usr/bin/obsync`
5. Make the script executable by `sudo chmod +x /usr/bin/obsync`
6. [Create a Git public access token](./git_access_token.md)

## Usage

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
obsync init --new --path /Users/lupuscoding/Documents/Obsidian/Aarun --repo https://github.com/lupuscoding/obsidian-aarun --token ghp_zOOpGFKHCACqXyZ9nRPvOsY3mVmOb30XwgkY
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
obsync init --path /Users/lupuscoding/Documents/Obsidian/Nearon --repo https://github.com/lupuscoding/obsidian-nearon --token ghp_zOOpGFKHCACqXyZ9nRPvOsY3mVmOb30XwgkY
```

### Synchronize an obsidian repository
This section is used, for every synchronization, after you initialized the obsidian repository.

```shell
obsync sync --path PATH_TO_OBSIDIAN_VAULT
```

PATH_TO_OBSIDIAN_VAULT = The local path to your Obsidian vault folder. The directory with the `.obsidian` folder in it.

**Example**
```shell
obsync sync --path /Users/lupuscoding/Documents/Obsidian/Nearon
```

### Setup an automatic synchronization
On Unix systems, like MacOS, the automation is pretty easy. You can just use your **obsync sync** command and add it to your crontab.

1. On your command line, use `crontab -e` to open the cron table.
2. Add a new line with the sync command like:
```bash
*/15 * * * *	obsync sync --path PATH_TO_OBSIDIAN_VAULT
```

**Example** Sync the "Nearon" vault, every 10 minutes
```bash
*/10 * * * *	obsync sync --path /Users/lupuscoding/Documents/Obsidian/Nearon
```

## Troubleshooting
