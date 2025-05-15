# Machine Setup in MacOS

This repository provides a shell script to install essential development software on macOS using Homebrew. The script reads software versions from a properties file, ensuring you install the exact versions specified.

## Requirements

- **macOS** with [Homebrew](https://brew.sh) installed.

## Installation Instructions

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
5. Certificates

Copy any certificates you require under `/usr/local/share/ca-certificates/` and the run the command:

```bash
sudo update-ca-certificates
```
