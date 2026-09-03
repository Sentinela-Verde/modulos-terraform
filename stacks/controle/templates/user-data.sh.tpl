#!/usr/bin/env bash
set -euo pipefail

# --- Docker ---
dnf install -y docker
systemctl enable --now docker
usermod -aG docker ec2-user

mkdir -p /usr/local/lib/docker/cli-plugins
curl -fsSL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64" \
  -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# --- Swap (quase mandatorio numa t3.micro rodando Docker) ---
SWAP_FILE=/swapfile
if [[ ! -f "$SWAP_FILE" ]]; then
  fallocate -l ${swap_size_gb}G "$SWAP_FILE"
  chmod 600 "$SWAP_FILE"
  mkswap "$SWAP_FILE"
  swapon "$SWAP_FILE"
  echo "$SWAP_FILE none swap sw 0 0" >> /etc/fstab
fi

# --- Stack (Postgres + MLflow) ---
mkdir -p /opt/controle
cat > /opt/controle/docker-compose.yml <<'COMPOSE_EOF'
${docker_compose_content}
COMPOSE_EOF

cd /opt/controle
docker compose up -d

# --- Backup diario do Postgres para o S3 (rede de seguranca, nao HA) ---
cat > /opt/controle/backup.sh <<'BACKUP_EOF'
#!/usr/bin/env bash
set -euo pipefail
cd /opt/controle
PGPASSWORD="${postgres_password}" docker compose exec -T postgres \
  pg_dump -U mlflow mlflow | gzip | aws s3 cp - "s3://${mlflow_bucket}/backups/$(date +%F).sql.gz"
BACKUP_EOF
chmod +x /opt/controle/backup.sh

cat > /etc/cron.d/mlflow-backup <<'CRON_EOF'
0 3 * * * root /opt/controle/backup.sh >> /var/log/mlflow-backup.log 2>&1
CRON_EOF
