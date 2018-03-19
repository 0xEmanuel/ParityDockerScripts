
FROM parity/parity:stable-release

ARG username="user"
ARG password="${username}"

RUN \
	apt-get clean && \
	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y \
		wget \
		sudo \
		gnupg2 
RUN \
	useradd \
		--create-home \
		--groups \
			sudo \
		"${username}" && \
	echo "${username}:${password}" | chpasswd
RUN \
	cd ~ && \
	wget https://github.com/ethereum/mist/releases/download/v0.9.3/Ethereum-Wallet-linux64-0-9-3.deb && \
	dpkg -i Ethereum-Wallet-linux64-0-9-3.deb || echo ignore && \
	apt-get install -fy && \
	dpkg -i Ethereum-Wallet-linux64-0-9-3.deb && \
	chown user:user -R /parity


USER "${username}"

ENTRYPOINT ["bash"]
