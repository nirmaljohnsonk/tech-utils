#command line arguments for make file
TOKEN = $(ARG_TOKEN)
PROJECT_NAME = $(ARG_PROJECT_NAME)

#make file variables 
GIT_DOMAIN = https://$(TOKEN)@github.com/nirmaljohnsonk


update-debian:
	sudo apt-get update && sudo apt-get upgrade -y

install-net-tools:
	sudo apt-get install net-tools -y

install-docker:
	sudo apt-get update
	sudo apt-get install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	echo "deb [arch=$$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $$(. /etc/os-release && echo "$${UBUNTU_CODENAME:-$$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
	sudo usermod -aG docker $$USER
	echo "Docker installed successfully now exit and login again"

build: update-debian install-docker

deploy:
	git clone $(GIT_DOMAIN)/$(PROJECT_NAME).git
	cd $(PROJECT_NAME) && docker compose up -d


