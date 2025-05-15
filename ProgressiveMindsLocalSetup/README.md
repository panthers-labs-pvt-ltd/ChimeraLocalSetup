# Machine Set up

Welcome to the Progressive Mind Chimera Setup Tooling repository. The aim of this project is to supply you with machine set up you would need to contribute to Chimera Project. Chimera Project works within Linux environment. Hence, it is important that everyone has a similar development environment to avoid integration issues later.

The project assumes that you are working on a Windows or Linux machine or on a MacBook. 

As of 2-Nov-2024, this tool is updated to support installation of WSL2 within Windows machines. Once the Windows machine is capable of running WSL 2 instances, the Ubuntu 24.02 LTS WSL 2 and minimum required packages are automatically deployed as well.

## Assumptions

The tool assumes that -

- You have fair working knowledge of git.
- Your machine has at least 4 cores and 8 GB of RAM. Ideally, you should have 8 cores and 16 GB RAM.
- The OS in your machine has Windows 11 or above, Ubuntu 24.04, or MacOS 11 or above.
- You are comfortable working within Ubuntu environment.

## List of Software Packages required for the project

1. **IDE -** IntelliJ Idea or VSCode
2. Java JDK 17
3. Python 3.10
4. Docker and Docker Compose
5. Minikube
6. **Build tools -** Maven (Optionally Gradle)
7. PostgreSQL
8. Nodejs
9. Rust
10. MinIO

## Installation Guide

## Cloning the tools project

This repository must be cloned on your local disk.

```cmd
git clone git@gitlab.com:manishkumargupta/progressive-mind-chimera-setup.git #using SSH

git clone https://gitlab.com/manishkumargupta/progressive-mind-chimera-setup.git #using https  
```

Based on your machine type, please appropriate installation steps

1. [Windows](#installation-in-windows)
2. [MacOs](#installation-in-macos)
3. [Linux](#installation-in-linux)

### Installation in Windows

Open a powershell with **administrative** privileges.

```powershell
cd ..progressive-mind-chimera-setup\ProgressiveMindsLocalSetup
..progressive-mind-chimera-setup\ProgressiveMindsLocalSetup> .\ChimeraLocalSetup.ps1
```

You may get an error: `~\ChimeraLocalSetup.ps1 cannot be loaded because running scripts is disabled on this system...". You would need to allow the Remote

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

An execution policy is part of the PowerShell security strategy. Execution policies determine whether you can load configuration files, such as your PowerShell profile, or run scripts. And, whether scripts must be digitally signed before they are run. For more information, please read set-executionpolicy document [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.4).

Follow the next steps as mentioned in [Machine Setup Windows Guide](Machine_Setup_Windows.md)

### Installation in MacOS

This repository provides a shell script to install essential development software on macOS using Homebrew. The script reads software versions from a properties file, ensuring you install the exact versions specified.

#### Requirements

- **macOS** with [Homebrew](https://brew.sh) installed.

#### Installation Instructions

1. **Clone this repository** (or download the script and `requirement_mac.properties` file directly).

2. **Prepare the properties file**  
   Edit the `requirement_mac.properties` file to specify the versions of each software you want to install:
   Each line specifies a software package and the version to install.
   Modify versions as needed, or use "latest" for the most recent stable release of a package.
3. Run the Installation Script
   Run the install_software.sh script to install all specified software:

   ```install_script
    chmod +x install_software.sh
    ./install_mac_softwares.sh
   ```

4. The script will:
   Update Homebrew.
   Install each software package listed in requirement_mac.properties, using the specified version.

## Installation in Linux

To be done

## Experiments

### Convert Docker to WSL2

I have created a CentOS 7 based Dockerfile that serves as a demonstrator. You can convert the container image to a WSL with to quick commands. For instructions look [here](./containers/centos7/README)).

## Misc

- My Terminal recommendation in 2021 clearly is [Microsoft Terminal](https://github.com/microsoft/terminal)
- Overview of [WSL commands and launch configurations](https://docs.microsoft.com/en-us/windows/wsl/wsl-config)
- For Development wiht Visual Studio Code use the `Remote - WSL` extension

Constructive feedback is appreciated!

Have fun!
