<p align="center">
 <img height="400px" src="export-commits.gif?sanitize=true">
</p>

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
```bash
git config user.email "MY_NAME@example.com"
mkdir projects
# create symlinks to your projects (with UNIX shell)
ln -s ~/path-to-your-project/example projects/ 
# create symlinks to your projects (as administrator on WINDOWS - CMD)
mklink projects\PROJECT_NAME ~/path-to-your-project/example
```

Alternatively, link all your projects at once and exclude some

```
ln -s ~/Sites projects
echo my-private-project >>excluded.txt
```

### Run
First time you need to run:
```bash
npm start
```
After that, the library will be installed and you will be able to use it from now on through:
```bash
export-commits
```

## Automated mode

### Install
Requirements: node v8 or higher
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