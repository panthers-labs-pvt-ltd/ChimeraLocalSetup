#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

read -p "Have you created your account on GitLab? If no, please pause this and create one first. Once done, press any key." _

read -p "Please provide the username and email with a space as delimiter, you used to set up your account on GitLab. It must match. ->" username email

echo "User Name: $username"
echo "email: $email"

git config --global user.name $username
git config --global user.email $email

echo -e "\nNow setting up Access using credential file"

read -p "Please provide the personal access token, you used to set up your account on GitLab. It must match. It is not possible to generate this key via API. ->" gitlab_token

GIT_CREDENTIALS_FILE="/home/$(whoami)/.git-credentials"

# Configure Git to use credential helper
git config --global credential.helper store
# Write credentials to the .git-credentials file
echo "https://$username:$gitlab_token@gitlab.com" > $GIT_CREDENTIALS_FILE
echo -e "\nCredentials saved to $GIT_CREDENTIALS_FILE. Hopefully you would not be prompted to enter you user id and access token each time you interact with git lab"

echo -e "\nNow setting up SSH key"
# Variables
SSH_KEY_PATH="/home/$(whoami)/.ssh/id_rsa"
GITLAB_URL="https://gitlab.com/api/v4/user/keys"

# Generate SSH key
ssh-keygen -t rsa -b 4096 -C "$email" -f "$SSH_KEY_PATH" -N ""

# Display the public key
PUB_KEY=$(cat "$SSH_KEY_PATH.pub")
echo "Generated SSH Key: $PUB_KEY"

# Add SSH key to GitLab
curl --header "PRIVATE-TOKEN: $gitlab_token" --data-urlencode "title=My Chimera Key" --data-urlencode "key=$PUB_KEY" $GITLAB_URL

echo -e "\nNow setting code clones for development tasks"
read -p "I am setting up you code repo under a folder call projects in your home directory. You can choose to clone either Infrastructure, Frameworks, or Both, or None if already done (respond with I/F/B/N) " option
echo "You selected: $option"

DIR_PROJECT="/home/$(whoami)/projects"

shopt -s nocasematch

if [[ "$option" != "N" ]]; then
    if [ ! -d "$DIR_PROJECT" ]; then
        mkdir -p "$DIR_PROJECT"
        echo "projects folder created: $DIR_PROJECT"
    else
        echo "projects folder already exists: $DIR_PROJECT"
    fi
fi

if [[ "$option" == "B" || "$option" == "I" ]]; then
    git clone https://gitlab.com/progressivemind1/IaC.git $DIR_PROJECT/IaC
fi

if [[ "$option" == "B" || "$option" == "F" ]]; then
    git clone https://gitlab.com/progressivemind1/Chimera.git $DIR_PROJECT/Framework
fi
shopt -u nocasematch

echo -e "\nGit Cloning complete. You are good to go"
