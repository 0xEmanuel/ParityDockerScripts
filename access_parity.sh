#!/bin/bash

echo "get access token from docker container ..."

#	|containername| /dir/binary

docker exec -ti parity_d /parity/parity signer new-token
