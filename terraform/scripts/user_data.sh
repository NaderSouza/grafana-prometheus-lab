#!/bin/bash

set -e  # Interrompe o script em caso de erro

echo "🔹 Atualizando pacotes e instalando dependências..."
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release ufw git vim

echo "🔹 Adicionando chave GPG e repositório oficial do Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "🔹 Instalando Docker e Docker Compose..."
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "🔹 Iniciando e habilitando o Docker..."
systemctl start docker
systemctl enable docker

echo "🔹 Criando grupo 'docker' e ajustando permissões..."
if ! getent group docker > /dev/null; then
  groupadd docker
fi
usermod -aG docker ubuntu
chmod 666 /var/run/docker.sock

echo "🔹 Reiniciando o Docker..."
systemctl restart docker

echo "✅ Instalação concluída!"
