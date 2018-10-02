

# Export commit history

Exports all your commits (by email configured in git) from given projects into `output` directory

## Install

```
yarn
```

## Configure

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

## Development

Dont use single `rm` in file called publishing - it may result in whole smb server destruction :)