#!/usr/bin/env bash
set -xe

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"


while :; do
    APIURL=${APIURL:-http://nginx/api}
    USERNAME=${USERNAME:-u`date +%s`}
    EMAIL=${EMAIL:-$USERNAME@mail.com}
    PASSWORD=${PASSWORD:-password}

    newman run $SCRIPTDIR/conduit.postman_collection.json \
        --delay-request 1 \
        --iteration-count 2 \
        --verbose \
        --suppress-exit-code \
        --reporters cli,json --reporter-json-export /tmp/outputfile.json \
        --global-var "APIURL=$APIURL" \
        --global-var "USERNAME=$USERNAME" \
        --global-var "EMAIL=$EMAIL" \
        --global-var "PASSWORD=$PASSWORD"
done
