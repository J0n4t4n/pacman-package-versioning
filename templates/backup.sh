#!/bin/sh

GIT_DIR=insert_gitdir
GIT_REMOTE=insert_gitremote
REPO_LIST=insert_repolist
AUR_LIST=insert_aurlist

cd ${GIT_DIR}

pacman -Qqen > ${REPO_LIST} ; pacman -Qqem > ${AUR_LIST}

CURDATE=$(date +"%Y-%m-%d %H:%M:%S")

git add ${REPO_LIST} ${AUR_LIST}
git commit -m "${CURDATE} Package List updated."

git push -u origin main

