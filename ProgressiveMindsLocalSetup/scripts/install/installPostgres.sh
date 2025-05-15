#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))
DATABASE_NAME="chimera_db"

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

VERSION_POSTGRES=$(getVersionToInstall "postgres")

installed=false

if [[ $(which psql | wc -l) > 0 ]]; then
  version_string=$( psql --version | grep "psql (PostgreSQL)" )
  if [[ $version_string == *"${VERSION_POSTGRES}"* ]]; then
    echo "PostgreSQL ${VERSION_POSTGRES} is already installed"
    installed=true
  fi
fi

# Ubuntu comes with Postgres 16
if [ $installed = false ]; then

  #Update package lists
  echo "Updating package lists..."
  sudo apt update

  # Install PostgreSQL
  echo "Installing PostgreSQL..."
  sudo apt install -y postgresql postgresql-contrib

  # Start PostgreSQL service
  echo "Starting PostgreSQL service..."
  sudo service postgresql start

  # Create a new PostgreSQL role
  echo "Creating a new PostgreSQL role..."
  #sudo -u postgres createuser --interactive
  sudo -u postgres psql -c "CREATE USER chimera WITH PASSWORD 'chimera123';"

  # Create a new database
  echo "Creating a new database..."
  sudo -u postgres createdb ${DATABASE_NAME} owner chimera

  # Enable PostgreSQL to start on boot
  echo "Enabling PostgreSQL to start on boot..."
  sudo systemctl enable postgresql

  echo "PostgreSQL installation and configuration complete!"
  echo "Postgres SQL version `psql --version` Installed"
  modifyBashrc "postgres" "sudo service postgresql start"

fi
