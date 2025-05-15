# Machine Setup in Windows

At this point, you are able to run the powershell script. Please follow along. The code is executing several steps.

1. Enabling WSL2
2. Installing Ubuntu 24.04 Distro (named as Chimera-2404 in our project) within WSL2
3. Updating the base packages within Chimera-2404
4. Setting up source code
5. Installation other required softwares. List of softwares along with its version is present in [requirements.txt](requirements.txt)

It takes about 30 mins to an hour to install everything depending on network connectivity. There are some places where your input is required, so do not leave the system unattended for auto-installation. There are some important messages for you to read through and take a note. In the next release, we will fix this, so all the critical notes will get appended to installation notes.

## Code walkthrough

WIP

### Enabling WSL2

Enable Windows Subsystem for Linux
***This step is only required if WSL support was never activated before on your Windows machine***

Open a powershell with **administrative** privileges and execute this script to enable WSL and VM platform on your machine.
It might be necessary to adjust the security policy (see first commnd below) because the Powershell scripts are not digitally signed (https:/go.microsoft.com/fwlink/?LinkID=135170):

```powershell
# Optional: Set Security to Bypass
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# Enable WSL
.\enableWSL.ps1
```

This will take a couple of minutes. If it was not enabled before, you need to reboot Windows.

A restart is required if any of the two above features have not been installed before.

### Set WSL default version to 2

Set the default WSL version to 2. Open a powershell with administrative privileges:

```powershell
.\installWSL2.ps1
```

## Distribution Installation

### Download and Install Ubuntu LTS (24.04)

If not already done, open a new powershell with administrative privileges and install Ubuntu LTS. You **need** to provide four arguments. If you don't specify them on command line, then the script will ask:

- `<wslName>`: Provide a name for the WSL that is goind to be created (e.g. `devbox`)
- `<wslInstallationPath>`: The directory where the vhdx disk of the new WSL is stored
- `<username>`: the name of the user that is used when WSL distro is launched without `-u`
- `<installAllSoftware>`: Use `true`|`false`. Tell if all software packages (see [Available Software](#Available-Software)) shall be installed or if `false` only a fully updated system with configured user is supplied

For example, the command can look as follows:

```powershell
.\installUbuntuLTS.ps1 chimeraDevBox D:\WSL2\devbox chimera true
```

### Available Software Package

If don't want to install all packages during initial WSL creation, you can install them one buy one. They are available here [./scripts](./scripts). These are currently available

- Ubuntu Base Package (git, virt-manager, firefox, dbus-x11, x11-apps, make, unzip) ([scripts/install/installBasePackages.sh](./scripts/install/installBasePackages.sh))
- OpenVSCode Server ([scripts/install/installOpenVSCodeServer.sh](./scripts/install/installOpenVSCodeServer.sh)). It is started automatically when you start and log into the WSL on port 3000.
- docker & compose V2 ([scripts/install/installDocker.sh](./scripts/install/installDocker.sh))
- OpenJDK 11 ([scripts/install/installOpenjdk.sh](scripts/install/installOpenjdk.sh))
- Apache Maven ([scripts/install/installMaven.sh](./scripts/install/installMaven.sh))
- Gradle ([scripts/install/installGradle.sh](./scripts/install/installGradle.sh))
- n (node manager), Nodejs, npm & Typescript ([scripts/install/installNodejs.sh](./scripts/install/installNodejs.sh)
- Rust and Cargo ([scripts/install/installRust.sh](./scripts/install/installRust.sh))
- Deno ([scripts/install/installDeno.sh](./scripts/install/installDeno.sh))
- Google Chrome ([scripts/install/installChrome.sh](./scripts/install/installChrome.sh))
- KVM & Qemu ([scripts/install/installKvm.sh](./scripts/install/installKvm.sh))
- Intellij Idea ([scripts/install/installIntellij.sh](./scripts/install/installIntellij.sh))
- Postgres ([scripts/install/installPostgres.sh](./scripts/install/installPostgres.sh))
- MiniKube ([scripts/install/installMinikube](./scripts/install/installMinikube))

Firefox and other tools can be installed directly with Ubuntu's package manager `apt`. Some of the above scripts also use `apt` and apply additional configuration.

#### Removal

Not available yet, but with a fast internet connection and fast SSD you have the WSL recreated in approx. five minutes. :sunglasses:

## Usage

### X-Server

***Once Windows 11 including WSLg is generally available this will become superfluous.***

I recommend to use [VcXsrv](https://sourceforge.net/projects/vcxsrv/) (also available via chocolatey) to connect to user interfaces launched from WSL on display 0. The WSL linux setup configures everything properly. Use the following Powershell script to launch (it assume vcxsrv is installed at default location `C:\Program Files\VcXsrv\vcxsrv.exe`):

```powershell
.\scripts\xserver\xerver.ps1
```
