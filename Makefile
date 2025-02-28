.PHONY: all install_docker install_kind install_kubectl install_awscli create_cluster destroy_cluster

# Default target
all: help

# Help message
help:
	@echo "Makefile for installing Docker, Kind, Kubectl, and AWS CLI."
	@echo "Usage:"
	@echo "  make install_docker    # Install Docker"
	@echo "  make install_kind      # Install Kind"
	@echo "  make install_kubectl   # Install Kubectl"
	@echo "	make install_k9s       # Unstall k9s"
	@echo "  make install_awscli    # Install AWS CLI"
	@echo "  make create_cluster # Kind create a cluster CLUSTER_NAME"
	@echo "  make destroy_cluster # Kind destroy a cluster CLUSTER_NAME"

# Install Docker
install_docker:
	@echo "Installing Docker..."
	@sudo apt-get update
	@sudo apt-get install -y docker.io
	@sudo systemctl start docker
	@sudo systemctl enable docker
	@echo "Docker installed successfully!"

# Install Kind
install_kind:
	@echo "Installing Kind..."
	@curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
	@chmod +x ./kind
	@sudo mv ./kind /usr/local/bin/kind
	@echo "Kind installed successfully!"

# Install Kubectl
install_kubectl:
	@echo "Installing Kubectl..."
	@curl -LO "https://storage.googleapis.com/kubernetes-release/released/$(curl -s https://storage.googleapis.com/kubernetes-release/released/latest.txt)/bin/linux/amd64/kubectl"
	@chmod +x ./kubectl
	@sudo mv ./kubectl /usr/local/bin/kubectl
	@echo "Kubectl installed successfully!"


# Install K9s
install_k9s:
	@echo "Installing k9s"
	@wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb && rm k9s_linux_amd64.deb
	@echo "k9s installed successfully"


# Install AWS CLI
install_awscli:
	@echo "Installing AWS CLI..."
	@sudo apt-get update
	@sudo apt-get install -y awscli
	@echo "AWS CLI installed successfully!"

# Kind create a cluster
create_cluster:
	@kind create cluster -n ${CLUSTER_NAME}


# kind destroy cluster
destroy_cluster:
	@kind delete cluster -n ${CLUSTER_NAME}
