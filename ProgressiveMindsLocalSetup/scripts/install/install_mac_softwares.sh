#!/bin/bash

# Load versions from properties file
source requirement_mac.properties

# Update Homebrew and install each software with the specified version

echo "Updating Homebrew..."
brew update

# Install Git
echo "Installing Git version $git..."
brew install git@$git

# Install OpenVSCode Server
echo "Installing OpenVSCode Server version $openvscode_server..."
brew install openvscode-server@$openvscode_server

# Install Docker and Docker Compose V2
echo "Installing Docker version $docker and Docker Compose V2 version $docker_compose..."
brew install docker@$docker
brew install docker-compose@$docker_compose

# Install OpenJDK 11
echo "Installing OpenJDK version $openjdk..."
brew install openjdk@$openjdk

# Install Apache Maven
echo "Installing Maven version $maven..."
brew install maven@$maven

# Install Gradle
echo "Installing Gradle version $gradle..."
brew install gradle@$gradle

# Install Node.js version manager (n) and Node.js, npm, TypeScript
echo "Installing n (Node.js version manager)..."
brew install n
echo "Installing Node.js version $node..."
n $node
echo "Installing npm version $npm..."
npm install -g npm@$npm
echo "Installing TypeScript version $typescript..."
npm install -g typescript@$typescript

# Install Rust and Cargo
echo "Installing Rust and Cargo version $rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain $rust

# Install Deno
echo "Installing Deno version $deno..."
brew install deno@$deno

# Install KVM and Qemu
echo "Installing KVM version $kvm and Qemu version $qemu..."
brew install kvm
brew install qemu@$qemu

# Install PostgreSQL
echo "Installing PostgreSQL version $postgresql..."
brew install postgresql@$postgresql

# Install Minikube
echo "Installing Minikube version $minikube..."
brew install minikube@$minikube

echo "All software installed successfully."
