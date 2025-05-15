
## Progressive Mind 

<div align="center">
   <img src="	https://th.bing.com/th/id/OIP.fv51w2lO_LOCYEpDB-WkQwAAAA?rs=1&pid=ImgDetMain" width="150px" alt="Project Logo" />
<h2>Chimera Tooling (Local Setup)</h2>
</div>

#### Getting started

Welcome to the Progressive Mind - Chimera Tooling repository. The aim of this project is to supply you with the ability to automatically install a fully working WSL 2 development Chimera environment just by invoking a powershell script

## Installation

This repository must be cloned on your local disk using below command

```text
git clone add origin https://gitlab.com/progressivemind1/progressive-mind-tooling.git
```
Open a powershell with administrative privileges and execute this script to enable WSL and VM platform on your machine.


```powershell
cd ProgressiveMindsLocalSetup
./ChimeraLocalSetup.ps1
```


## Description

Progressive Mind - Chimera Tooling repository will autodownload and install below Software packages into WSL 2

If don't want to install all packages during initial WSL creation, you can install them one buy one. They are available here [./scripts](./scripts). These are currently available

if you want to customized the version or packages, please modify the ([requirements.txt](requirements.txt)) according to your needs

## Avaliable Softwares Packages


- Ubuntu Base Package ([scripts/install/installBasePackages.sh](./scripts/install/installBasePackages.sh))
   - git (Code version control system)
   - virt-manager (virt-manager is a desktop virtual machine monitor)
   - firefox (Browser)
   - dbus-x11 (mechanism that allows communication between multiple processes running concurrently on the same machine.)
   - x11-apps (WSL & Windows in a fully integrated desktop experience)
   - make
   - unzip
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

## Screenshots
you will get the screen when Script will execute with administrative access with Powershell,User will
be asked to customized the WSL Configuration, e.g WSL Name, Installation Path, User Name & Install Software
- [Execution Screenshot](/screenshots/Screen-001.png)
- [User Input Screenshot](/screenshots/Screen-002.png)


## Feedback

If you have any feedback, please contact us at [progressive.mind.chimera@gmail.com](mailto:progressive.mind.chimera@gmail.com)

<div align="center">
