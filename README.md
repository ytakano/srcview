# Source Code Viewer

## Edit Dockerfile 

Set HTML's title and Git's repository.
```
$ vim Dockerfile
ARG TITLE="Linux Kernel Source"
ARG GIT=https://github.com/torvalds/linux.git
```

## Build and run

```
$ docker compose build
$ docker compose up -d
```

## View Web 

Visit http://localhost:8080/HTML/

## Remove docker image

```
$ docker compose stop
$ docker compose rm
```
