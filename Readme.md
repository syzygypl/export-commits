

# Export commit history

General tool for exporting and publishing commits history for some period, (by email configured in git) from given 
projects.
Works in two modes:
1) Manual mode - you have manually execute command and publish results to your nelson server.
2) Automated mode - runs script repeatedly in background which exports and publishes your commits every month. 

## Manual mode

### Install
```
yarn
```

### Configure
```
mkdir projects
# create symlinks to your projects
# ln -s ~/Sites/example.com projects/ 
```

Alternatively, link all your projects at once and exclude some

```
ln -s ~/Sites projects
echo my-private-project >>excluded.txt
```

## Run

```
./export "2017-10"
```

## Automated mode

### Install
```
 bash -c "curl -s https://raw.githubusercontent.com/syzygypl/export-commits/master/install.sh > /tmp/export-commits && bash \"/tmp/export-commits\"" 
```
Installs script in `~/.export-commits` directory and creates `launchctl` service in `~/Library/LaunchAgents` with name 
`com.syzygy.export-commits`    

### Configure
```
mkdir ~/.export-commits/projects
# create symlinks to your projects
# ln -s ~/Sites/example.com ~/.export-commits/projects/ 
```
Excluded functionality works in same way 

### Logs
Logs are located in `~/.export-commits/log.log` and `~/.export-commits/error.log`

## Development
Dont use single `rm` in file called publishing - it may result in whole smb server destruction :)