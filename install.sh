#!/bin/sh

# Check we are running as a normal user
if [ "$EUID" -eq 0 ]
then
  echo "Please don't run install.sh as root, it will use sudo where needed."
  exit 0
fi

GIT_DIR=/home/jonatan/Git/t480-packages/
GIT_REMOTE=git@github.com:J0n4t4n/T480-Packages.git
REPO_LIST=pkglist-repo.txt
AUR_LIST=pkglist-aur.txt

# Install hook and backup script
if [ ! -d /etc/pacman.d/hooks ] || [ ! -d /etc/pacman.d/hooks.bin ]
then
  sudo mkdir -p /etc/pacman.d/hooks /etc/pacman.d/hooks.bin
fi

if [ ! -f /etc/pacman.d/hooks/backup.hook ]
then
  sudo cp ./templates/backup.hook /etc/pacman.d/hooks/backup.hook
fi

if [ ! -f /etc/pacman.d/hooks.bin/backup.sh ]
then
  sed \
    -e "s=insert_gitdir=${GIT_DIR}=g" \
    -e "s=insert_gitremote=${GIT_REMOTE}=g" \
    -e "s=insert_repolist=${REPO_LIST}=g" \
    -e "s=insert_aurlist=${AUR_LIST}=g" \
    ./templates/backup.sh | sudo tee /etc/pacman.d/hooks.bin/backup.sh
  sudo chmod +x /etc/pacman.d/hooks.bin/backup.sh
fi

if [ ! -f ${GIT_DIR} ]
then
  mkdir -p ${GIT_DIR}
fi

if [ ! -f ${GIT_DIR}backup_key ]
then
  ssh-keygen -f ${GIT_DIR}backup_key -t ed25519 -q -N ""
  echo "Backup Key generated, please add this public key as \"Deploy Key\" with \"Write\" access to repository"
  cat ${GIT_DIR}backup_key.pub
  exit 0
fi

if [ ! -d ${GIT_DIR}\.git ]
then
  cp templates/\.gitignore ${GIT_DIR}\.gitignore
  cd ${GIT_DIR}
  git init
  # Otherwise it would try to sign the commits using my GPG Key from my YubiKey
  git config --local --add user.name "T480 Backup Script"
  git config --local --add user.email "bot@jsteuernagel.de"
  git config --local --add commit.gpgsign false
  git config --local --add core.sshCommand "ssh -i ${GIT_DIR}backup_key"
  git remote add origin ${GIT_REMOTE}
  git add \.gitignore
  git commit -m "Initial commit"
  cd -
fi
