#!/bin/bash
set -x

# TODO: remove these library functions once an AMI is baked!
### BEGIN LIBRARY FUNCTIONS ###

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y jq curl

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

function get_environment() {
    get_tag_value '${namespace}:environment'
}

function set_hostname() {
    local full_hostname="$${1}.node.$(get_environment).${namespace}"
    echo "127.0.0.1 $${full_hostname} $${1}" >> /etc/hosts
    hostnamectl set-hostname $${1}
}
### END LIBRARY FUNCTIONS ###

###
### CONFIG ###
###
ENVIRONMENT=$(get_environment)
SERVICE='${service}'
NAME="${name}"
SERVER_ID='${server_id}'
MONGODB='${mongodb}'
PROMPT_COLOR="${prompt_color}"

function setup_nat() {
  sysctl -w net.ipv4.ip_forward=1
  sed -i -e 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/' /etc/sysctl.conf
}

function install_pritunl() {
    cat <<EOF > /etc/yum.repos.d/mongodb-org-4.0.repo
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
EOF

    cat <<EOF > /etc/yum.repos.d/pritunl.repo
[pritunl]
name=Pritunl Repository
baseurl=https://repo.pritunl.com/stable/yum/centos/7/
gpgcheck=1
enabled=1
EOF

    gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
    gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp; sudo rpm --import key.tmp; rm -f key.tmp
    yum -y install pritunl-1.29.2276.91 mongodb-org
}

function configure_pritunl() {
    if [ ! -z $${MONGODB} ]; then
        pritunl set-mongodb "$${MONGODB}"
    else
        sed -i -e "s/.*bindIp: 127.0.0.1.*/  bindIp: 0.0.0.0/" /etc/mongod.conf
    fi
    echo "$${SERVER_ID}" > /var/lib/pritunl/pritunl.uuid
}

set_hostname $${NAME}
setup_nat

# Install Pritunl (UIDs and GIDs not created until install)
install_pritunl

# Configure Pritunl and start it
configure_pritunl
if [ ! -z $${MONGODB} ]; then
    systemctl enable mongod
    systemctl start mongod
fi

systemctl start pritunl
systemctl enable pritunl
