# flutter-android

Lightweight ubuntu docker image with all the dependencies to run flutter and android tests,
tagging stable versions.

## Docker Hub

### `docker pull`

You can pull the image from Docker Hub using the `docker pull minddocdev/flutter-android` command.
We use [automated build set up](https://docs.docker.com/docker-hub/builds/#create-an-automated-build).

```sh
docker pull minddocdev/flutter-android
```

### `docker run`

To jump into the container's `bash` shell

```sh
docker run -it minddocdev/flutter-android /bin/sh
```

### `docker build`

You can also build the image yourself. Checkout the repository

```sh
git clone https://github.com/minddocdev/flutter-android
cd flutter-android
docker build -t minddocdev/flutter-android .
docker images minddocdev/flutter-android
```

# Links

- [Docker Hub `minddocdev/flutter-android`](https://hub.docker.com/r/minddocdev/flutter-android)
- [GitHub `minddocdev/flutter-android`](https://github.com/minddocdev/flutter-android)
- [brianegan/flutter](https://hub.docker.com/r/brianegan/flutter/dockerfile)
- [jangrewe/gitlab-ci-android](https://hub.docker.com/r/jangrewe/gitlab-ci-android/dockerfile)
