# recommended directory structure #
Like with my other containers I encourage you to follow a unified directory structure approach to keep things simple & maintainable, e.g.:

```
project root
  - docker_compose.yaml
  - config
    - php56
      - initialize.sh (if needed)
      - fpm
        - php.ini (if needed)
        - conf.d
          - ...
  - htdocs
  - sessions
  - logs
```

# Example docker-compose.yaml #
```
php:
  image: qoopido/php56:latest
  ports:
   - "9000:9000"
  volumes:
   - ./config:/app/config
   - ./htdocs:/app/htdocs
   - ./sessions:/app/sessions
   - ./logs:/app/logs
```

# Or start container manually #
```
docker run -d -P -t -i -p 9000:9000 \
	-v [local path to config]:/app/config \
	-v [local path to htdocs]:/app/htdocs \
	-v [local path to sessions]:/app/sessions \
	-v [local path to logs]:/app/logs \
	--name php qoopido/php56:latest
```

# Included modules #
```
php5-common
php5-json
php5-gd
php5-curl
php5-mcrypt
php5-mysqlnd
php5-sqlite
php5-apcu
php5-memcached
php5-suhosin-extension
php5-xdebug
```

# Configuration #
Any files under ```/app/config/php56``` will be symlinked into the container's filesystem beginning at ```/etc/php5```. This can be used to overwrite the container's default php fpm configuration with a custom, project specific configuration.

If you need a custom shell script to be run on start (e.g. to set symlinks) you can do so by creating the file ```/app/config/php56/initialize.sh```.

# XDebug #
This container comes with XDebug pre-installed but disabled. To enable it just port ```9001:9001``` to your ```docker_compose.yaml``` or your shell command and create a file named ```/app/config/php56/fpm/conf.d/20-xdebug.ini``` with the following content:

```
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_port="9001"
xdebug.remote_connect_back=1
```