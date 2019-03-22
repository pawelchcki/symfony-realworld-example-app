#!/bin/bash
set -xe
if [[ -n "$DDTRACE_DEB_URL" ]]; then
    (
        cd /tmp
        curl -L -o ddtrace.deb $DDTRACE_DEB_URL
        sudo dpkg -i ddtrace.deb
        rm ddtrace.deb
    )
fi

make db EXEC_PHP= || true

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
