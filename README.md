# 📦 pacman-package-versioning

This repository provides a shell script and a pacman hook for automatic backup of explicitly installed packages on Arch Linux.

🚀 Getting Started
---------------------
1. Clone this repository to your local machine.
2. Open the `install.sh` script and review its contents.
3. Adjust the values of the four variables on lines 9-12 according to your preferences:
   - `GIT_DIR`: Specify the directory where you want the Git repository to be created (e.g., `/path/to/repository`).
   - `GIT_REMOTE`: Set the remote Git repository URL where you want to push the backup files.
   - `REPO_LIST`: Define the filename for the package list of installed packages (e.g., `installed_packages.txt`).
   - `AUR_LIST`: Define the filename for the package list of installed AUR packages (e.g., `aur_packages.txt`).
4. Save the changes to the `install.sh` script.
5. Run the `install.sh` script to set up the backup solution.
6. Enjoy automated backups of your explicitly installed packages!

📃 License
---------------------
This project is licensed under the [MIT License](LICENSE).

🔗 Relevant Links
---------------------
- [Arch Linux](https://www.archlinux.org/)
- [Pacman Package Manager](https://wiki.archlinux.org/title/pacman)
