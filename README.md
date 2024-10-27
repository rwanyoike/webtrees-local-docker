# webtrees Local (Online genealogy)

[![GitHub License](https://img.shields.io/github/license/rwanyoike/webtrees-local-docker)
](LICENSE.txt)

> **This container is meant for local use only. It is not intended for production environments.**

<p align="center">
  <img src="assets/screenshot.png" alt="webtrees">
</p>

Containerized version of [webtrees](https://github.com/fisharebest/webtrees), an online collaborative genealogy application.

## Usage

To start the webtrees application on port `8080/tcp`:

```shell
docker run --name webtrees-local -p 127.0.0.1:8080:80/tcp webtrees-local:latest
```

The container environment [supports a SQLite](https://webtrees.net/install/requirements/) database.

### Data Directory

The webtrees application lives in `/var/www/html`. You can mount a directory on your host (to expose configuration files, etc.) to the `/var/www/html/data` directory in the container.

## Build

The build will download a [release](./Dockerfile#L4) from the webtrees repository and configure the container:

```shell
# Clone the repository
git clone https://github.com/rwanyoike/webtrees-local-docker
# Navigate to the project directory
cd webtrees-local
# Build the container image
docker build -t webtrees-local:latest .
```
