# Haproxy

These are docker images for Haproxy running on an
[Alpine Linux container](https://registry.hub.docker.com/u/webhippie/alpine/)


## Usage

```
docker run -p 80:80 -p 443:443 -p 9000:9000 -d --name haproxy webhippie/haproxy:latest start

# Execute this for further available commands
docker exec -ti haproxy manage help
```


## Versions

* [latest](https://github.com/dockhippie/haproxy/tree/master)
  available as ```webhippie/haproxy:latest``` at
  [Docker Hub](https://registry.hub.docker.com/u/webhippie/haproxy/)


## Available management commands

```bash
Usage: manage <command> [<args>]

Some useful manage commands are:
   bash      Start a shell on container
   check     Check config file
   commands  List all available sub commands
   pid       Return the process id
   prepare   Prepare environment
   reload    Reload the main process
   running   Check if main process is running
   start     Start the main process
   stop      Stop the main process
```


## Available environment variables

```bash
ENV DISCOVERY_TYPE etcd
ENV DISCOVERY_HOST 127.0.0.1
ENV DISCOVERY_PORT 4001
ENV DISCOVERY_INTERVAL 30
ENV DISCOVERY_PREFIX /
ENV DISCOVERY_OPTS

ENV HAPROXY_USERNAME webhippie
ENV HAPROXY_PASSWORD webhippie
ENV HAPROXY_CERT ssl_key_and_cert_string
```


### Configure with etcd

If you export ```DISCOVERY_TYPE``` with the value ```etcd``` you can use etcd
for configuration:

```
etcdctl set /app/exampleapp 'example.com'
etcdctl set /upstream/exampleapp/server1 '127.0.0.1:3000'
etcdctl set /upstream/exampleapp/server2 '127.0.0.1:4000'
```


### Configure with consul

If you export ```DISCOVERY_TYPE``` with the value ```consul``` you can use
consul for configuration:

```
curl -X PUT -d 'example.com' http://localhost:8500/v1/kv/app/exampleapp
curl -X PUT -d '127.0.0.1:3000' http://localhost:8500/v1/kv/upstream/exampleapp/server1
curl -X PUT -d '127.0.0.1:4000' http://localhost:8500/v1/kv/upstream/exampleapp/server2
```


### Configure with environment

If you export ```DISCOVERY_TYPE``` with the value ```env``` you can use
environment for configuration:

```
export APP_EXAMPLEAPP=example.com
export UPSTREAM_EXAMPLEAPP_SERVER1=127.0.0.1:3000
export UPSTREAM_EXAMPLEAPP_SERVER2=127.0.0.1:4000
```


## Contributing

Fork -> Patch -> Push -> Pull Request


## Authors

* [Thomas Boerger](https://github.com/tboerger)


## License

MIT


## Copyright

Copyright (c) 2015 Thomas Boerger <http://www.webhippie.de>
