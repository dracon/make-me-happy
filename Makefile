.PHONY: all 
		install_docker 
		install_kind 
		install_kubectl 
		install_k9s 
		install_awscli 
		install_helm
		install_kubectl_bash_completion
		load_bash_completion
		create_bash_completion_dir 
		create_cluster 
		destroy_cluster

# Default target
all: help

# Help message
help:
	@echo "*******************************************************************"
	@echo "Makefile for installing Docker, Kind, Kubectl, k9s, and AWS CLI."
	@echo "Create kind cluster and destroy kind cluster."
	@echo "*******************************************************************"
	
	@echo "  make install_docker                   # Install Docker"
	@echo "  make install_kind                     # Install Kind"
	@echo "  make install_kubectl                  # Install Kubectl"
	@echo "  make install_k9s                      # Install k9s"
	@echo "  make install_awscli                   # Install AWS CLI"
	@echo "  make install_helm                     # Install Helm"
	@echo "  make install_kubectl_bash_completion  # Install kubectl bash completion"
	@echo "  make load_bash_completion             # Load bash completion to .bashrc"
	@echo "  make create_bash_completion_dir       # Create bash completion directory"
	@echo "  make create_cluster                   # Create a cluster CLUSTER_NAME"
	@echo "  make destroy_cluster                  # Destroy a cluster"

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
	@echo "Installing k9s..."
	@wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb \
	&& sudo apt install ./k9s_linux_amd64.deb \
	&& rm k9s_linux_amd64.deb
	@echo "k9s installed successfully!"

# Install AWS CLI
install_awscli:
	@echo "Installing AWS CLI..."
	@sudo apt-get update
	@sudo apt-get install -y awscli
	@echo "AWS CLI installed successfully!"

# Install Helm
install_helm:
	@echo "Installing Helm..."
	@curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
	@echo "Helm installed successfully!"


# Define default cluster name if not provided
CLUSTER_NAME ?= my-cluster

# Kind create a cluster
create_cluster:
	@kind create cluster -n ${CLUSTER_NAME}

# Kind destroy cluster
destroy_cluster:
	@kind delete cluster -n ${CLUSTER_NAME}


# Create bash completion directory
create_bash_completion_dir:
	@mkdir -p ~/.bash_completion.d

# Load bash completion to .bashrc
load_bash_completion:
	@echo '# Load custom bash completions' >> ~/.bashrc
	@echo 'if [ -d ~/.bash_completion.d ]; then' >> ~/.bashrc
	@echo '  for file in ~/.bash_completion.d/*; do' >> ~/.bashrc
	@echo '    [ -f "$file" ] && . "$file"' >> ~/.bashrc
	@echo '  done' >> ~/.bashrc
	@echo 'fi' >> ~/.bashrc

# Install kubectl bash completion
install_kubectl_bash_completion: create_bash_completion_dir
	@kubectl completion bash > ~/.bash_completion.d/kubectl
	@echo "source ~/.bash_completion.d/kubectl" >> ~/.bashrc
	@echo "Kubectl bash completion installed successfully!"