#!/bin/bash
set -e

echo "=== 1. Atualizando pacotes e instalando dependências base ==="
apt update
apt install -y git curl build-essential wget gpg

echo "=== 2. Instalando Docker Engine + Plugin Docker Compose ==="
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl enable docker
systemctl start docker

echo "=== 3. Criando arquivo de serviço do FFplayout (/etc/systemd/system/ffplayout.service) ==="
cat <<EOF > /etc/systemd/system/ffplayout.service
[Unit]
Description=FFplayout Service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/bin/ffplayout -l 0.0.0.0:8787 -c /etc/ffplayout/ffplayout.toml
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

echo "=== 4. Criando diretórios e ajustando permissões de persistência 1:1 ==="
mkdir -p /var/lib/ffplayout /usr/share/ffplayout/public /etc/ffplayout
chmod -R 777 /var/lib/ffplayout /usr/share/ffplayout/public /etc/ffplayout

echo "=== 5. Subindo o Container ffplayout (Modo CPU) ==="
if [ -f "/usr/local/src/docker_compose.yml" ]; then
    docker compose -f /usr/local/src/docker_compose.yml up -d
else
    echo "⚠️ Arquivo não encontrado em /usr/local/src/docker_compose.yml"
    echo "Certifique-se de salvar o arquivo docker_compose.yml nessa pasta e depois execute:"
    echo "docker compose -f /usr/local/src/docker_compose.yml up -d"
fi

echo "=== INSTALAÇÃO BASE CONCLUÍDA! ==="
