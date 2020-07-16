#!/bin/bash
set -x

# TODO: remove these library functions once an AMI is baked!
### BEGIN LIBRARY FUNCTIONS ###

# Install azure cli
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'

# Install epel
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Install basic packages
yum install -y jq curl azure-cli
yum groupinstall -y "Development tools"

# azure specific
function get_availability_zone() {
  echo $(curl -H 'Metadata:true' --retry 3 --silent --fail 'http://169.254.169.254/metadata/instance/compute?api-version=2019-06-01' | jq -r '.zone')
}
function get_region() {
  echo $(curl -H 'Metadata:true' --retry 3 --silent --fail 'http://169.254.169.254/metadata/instance/compute?api-version=2019-06-01' | jq -r '.location')
}
function get_tag_value() {
  local tag_key_to_query=$${1}
  local tags_as_string=$(curl -H 'Metadata:true' --retry 3 --silent --fail 'http://169.254.169.254/metadata/instance/compute?api-version=2019-06-01' | jq -r '.tags')
  declare -a array_of_tags
  local IFS=';'; read -r -a array_of_tags <<< "$${tags_as_string}"
  declare -A tags
  declare -a elements_in_tag
  for tag in "$${array_of_tags[@]}"; do
    local tag_value=$(echo $${tag} | rev | cut -d ':' -f 1 | rev)
    IFS=':' read -r -a elements_in_tag <<< "$${tag}"
    if [ "$${#elements_in_tag[@]}" -eq 2 ]; then
      local tag_key=$${elements_in_tag[0]}
    elif [ "$${#elements_in_tag[@]}" -eq 3 ]; then
      local tag_key=$(echo $${tag} | cut -d ':' -f 1-2)
    fi
    tags["$${tag_key}"]=$${tag_value}
  done
  echo "$${tags["$${tag_key_to_query}"]}"
}

function get_azure_storage_access_token() {
  az login --identity
  AZURE_STORAGE_ACCESS_TOKEN="$(az account get-access-token --resource=https://storage.azure.com/ | jq -r .accessToken)"
}

function get_environment() {
  get_tag_value '${namespace}:environment'
}

function set_hostname() {
  local full_hostname="$${1}.node.$(get_environment).${namespace}"
  local full_hostname_no_ip="$${2}.node.$(get_environment).${namespace}"
  echo "127.0.0.1 $${full_hostname} $${1} $${full_hostname_no_ip} $${2}" >> /etc/hosts
  hostnamectl set-hostname $${full_hostname_no_ip}
}

# Install nvidia drivers
function install_nvidia () {
 curl -sL 'https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo' -o /etc/yum.repos.d/cuda-rhel7.repo
 echo -e '[nvidia-machine-learning]
name=nvidia-machine-learning
baseurl=https://developer.download.nvidia.com/compute/machine-learning/repos/rhel7/x86_64/
enabled=1
gpgcheck=1
gpgkey=https://developer.download.nvidia.com/compute/machine-learning/repos/rhel7/x86_64/7fa2af80.pub' > /etc/yum.repos.d/nvidia-machine-learning.repo
 yum install -y cuda-10-0
}

function configure_smb_mounts() {
  local STORAGE_CONTAINER_ENDPOINT="$${1}"
  local CSV_MOUNTS="$${2}"
  IFS=',' read -r -a MOUNTS <<< "$${CSV_MOUNTS}"

  if [ -z $${AZURE_STORAGE_ACCESS_TOKEN:-""} ]; then
    get_azure_storage_access_token
  fi

  if [ ! -d "/etc/smbcredentials" ]; then
      mkdir /etc/smbcredentials
  fi

  # See this terraform module's README for more details on these files
  for mount in "$${MOUNTS[@]}"; do
    curl -o "/etc/smbcredentials/$${mount}.cred" "$${STORAGE_CONTAINER_ENDPOINT}/$${mount}.cred" -H "x-ms-version: 2017-11-09" -H "Authorization: Bearer $${AZURE_STORAGE_ACCESS_TOKEN}"
    curl -o "/etc/systemd/system/mnt-$${mount}.mount" -sL "$${STORAGE_CONTAINER_ENDPOINT}/$${mount}.systemd" -H "x-ms-version: 2017-11-09" -H "Authorization: Bearer $${AZURE_STORAGE_ACCESS_TOKEN}"
    systemctl enable "mnt-$${mount}.mount"
    systemctl start "mnt-$${mount}.mount"
  done
}

### END LIBRARY FUNCTIONS ###

###
### CONFIG ###
###
ENVIRONMENT=$(get_environment)
SERVICE='${service}'
NAME="${name}"
STORAGE_CONTAINER_ENDPOINT='${storage_container_id}'
CSV_MOUNTS='${csv_mounts}'

PROMPT_COLOR="${prompt_color}"

function setup_docker() {
  local MOUNT_PATH="/mnt"
  local ACCOUNT_NAME="$${1}"
  local FILES=('docker-ca.pem' 'jupyterlab-server-key.pem' 'jupyterlab-server-cert.pem')
  mkdir -p /etc/docker/tls
  mkdir -p /var/lib/docker
  ln -s $${MOUNT_PATH} /var/lib/docker
  if [ -z $${AZURE_STORAGE_ACCESS_TOKEN:-""} ]; then
    get_azure_storage_access_token
  fi
  for file in "$${FILES[@]}"; do
    curl -o "/etc/docker/tls/$${file}" "$${STORAGE_CONTAINER_ENDPOINT}/$${file}" -H "x-ms-version: 2017-11-09" -H "Authorization: Bearer $${AZURE_STORAGE_ACCESS_TOKEN}"
  done
  yum install -y yum-utils device-mapper-persistent-data lvm2
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  yum install -y docker-ce docker-ce-cli containerd.io
  sed -i 's!-H fd:// !!g' /usr/lib/systemd/system/docker.service
  cat << 'EOF' > /etc/docker/daemon.json
{
    "storage-driver": "overlay2",
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "300m",
        "max-file":"3"
    },
    "hosts": [
      "fd://",
      "tcp://0.0.0.0:2376"
    ],
    "tlsverify": true,
    "tlscacert": "/etc/docker/tls/docker-ca.pem",
    "tlscert": "/etc/docker/tls/jupyterlab-server-cert.pem",
    "tlskey": "/etc/docker/tls/jupyterlab-server-key.pem"
}
EOF

  mkdir -p /opt/ivy
  cat << 'EOF' > /opt/ivy/cleanup_docker.sh
#!/bin/bash

echo "cleaning up docker images at $(date)"
docker system prune -af
echo "finished cleaning up docker images at $(date)"
EOF

  cat << 'EOF' > /etc/cron.daily/cleanup_docker.cron
#
# Clean up unused docker images
#
/opt/ivy/cleanup_docker.sh | logger -t cleanup_docker
EOF

}

setup_docker "$${STORAGE_ACCOUNT_NAME}"

if [ -n "$${CSV_MOUNTS+x}" ]; then
  configure_smb_mounts "$${STORAGE_CONTAINER_ENDPOINT}" "$${CSV_MOUNTS}"
fi

if lspci -vnn | grep VGA -A 12 | grep 'NVIDIA' &> /dev/null; then
  install_nvidia
fi

set_hostname $${NAME} $${SERVICE}

systemctl daemon-reload
systemctl start docker
