Docker Tinyproxy
================

[![Stars](https://img.shields.io/docker/stars/travix/tinyproxy.svg)](https://hub.docker.com/r/travix/tinyproxy/)
[![Pulls](https://img.shields.io/docker/pulls/travix/tinyproxy.svg)](https://hub.docker.com/r/travix/tinyproxy/)
[![License](https://img.shields.io/github/license/Travix-International/docker-tinyproxy.svg)](https://github.com/Travix-International/docker-tinyproxy/blob/master/LICENSE)

> Docker implementation of [TinyProxy](https://github.com/tinyproxy/tinyproxy)

## Getting started

For testing purpose, you may want to change the **tinyproxy.conf** and switch the **LogLevel** value to **Info** and comment the Allow line.

```
# build docker image
docker build -t tinyproxy .

# run container in background
docker run -d --name tinyproxy -p 8888:8888 tinyproxy

# proxy request via the running container
http_proxy=127.0.0.1:8888 https_proxy=127.0.0.1:8888 curl https://www.google.com --verbose

# or
curl -x 127.0.0.1:8888 curl https://www.google.com --verbose

# or proxy all requests from linux based containers
docker run -t -i \
  --link tinyproxy \
  redhat/ubi9-minimal \
  curl -x http://tinyproxy:8888 -L https://www.google.com --verbose
```

## Custom Tinyproxy configuration

```
docker run -t -i \
  -v $(pwd)/tinyxproxy.conf:/etc/tinyproxy.conf
  -p 8888:8888 \
  tinyproxy
```

## License

MIT © [Travix International](http://travix.com)
