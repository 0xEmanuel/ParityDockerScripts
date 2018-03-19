#!/bin/bash


echo "deleting all old docker container ..."
docker rm $(docker ps -a -q)

echo "running parity in a new docker container ..."

#dont run this script or docker as root!

#this folder is inside the docker container
DOCKER_BASE_PATH=/root/.local/share/io.parity.ethereum

SSD_BASE_PATH=/media/user/shared_chaindata/ethereum_chaindata/io.parity.ethereum/docker

#local base path should not contain $SSD_BASE_PATH/cache/ and $SSD_BASE_PATH/chains/ethereum/db/ . They should be only stored in $SSD_BASE_PATH
LOCAL_BASE_PATH=/home/user/.local/share/io.parity.ethereum/docker

#you can access container via the name speciefied in --name
docker run -ti \
	--name parity_d \
	-v /home/user/.ethereum/:/root/.ethereum/ \
	-v $LOCAL_BASE_PATH/:$DOCKER_BASE_PATH/ \
	-v $SSD_BASE_PATH/cache/:$DOCKER_BASE_PATH/cache/ \
	-v $SSD_BASE_PATH/chains/ethereum/db/:$DOCKER_BASE_PATH/chains/ethereum/db/ \
	-p 8180:8180 \
	-p 8080:8080 \
	-p 8545:8545 \
	-p 8546:8546 \
	-p 30303:30303 \
	-p 30303:30303/udp \
	parity/parity:stable-release \
		--base-path /root/.local/share/io.parity.ethereum/ \
		--jsonrpc-apis all \
		--jsonrpc-hosts all \
		--ui-hosts=all \
		--jsonrpc-interface all \
		--ui-interface all \
		--ws-interface all \
		--ui-no-validation \
		--mode active \
		--tracing off \
		--pruning fast \
		--db-compaction ssd \
		--cache-size 1024 \
		--geth
