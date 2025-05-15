# Setting up Ray for AIML Development on Windows
#Scope of work 
setting up Python, creating a virtual environment, installing Ray, and running a simple Ray program in Windows Subsystem for Linux (WSL) with Ubuntu and Windows 



STEP ON WSL

Open Ubuntu in WSL.
Update the package list and install Python 3 and pip by running: sudo apt update.
 sudo apt install 
python3 python3-pip -ypython3 --version
pip3 --version
This should display the Python and pip versions.

Create a Virtual Environment
Install the venv module if it's not already installed:sudo apt install python3-venv -y
Create the virtual environment:python3 -m venv ray_env

Activate the virtual environment:source ray_env/bin/activate
You should see (ray_env) at the beginning of your prompt, indicating the virtual environment is active.

Install Ray
With the virtual environment activated, install Ray using pip:

pip install ray


Start Ray with the dashboard by running:
ray start --head --include-dashboard=true



Access the Ray Dashboard on Windows from WSL:
* Since WSL operates in a Linux environment within Windows, the Ray Dashboard will still be accessible from Windows at http://localhost:8265.
* Open a web browser on Windows and go to http://localhost:8265 to view the Ray Dashboard.


ray stop


( if any issue )


ray stop

Sometimes, leftover files from previous sessions can cause conflicts. You may need to manually clear them out.
Locate Ray’s temporary session files and remove them:
* By default, these files are in ~/ray/session_latest (for WSL) or in a directory such as C:\tmp\ray (for Windows).
* If you’re using Windows, navigate to the directory (like C:\tmp\ray) and delete any session-related files.


ray start --head --include-dashboard=true

If you still encounter issues, you may want to reinstall Ray to ensure there are no missing or corrupted files:
bash
Copy code
pip uninstall ray
pip install "ray[default]"




