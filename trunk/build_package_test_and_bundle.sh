#!/bin/bash

./build.sh

GIT_VERSION=$(git --version | sed 's/git version //')
echo "Git version is $GIT_VERSION"

open "Git Installer.pmdoc/"

echo "Once the package is built, press a key"
read -n 1

./test_installer.sh

printf "$GIT_VERSION" | pbcopy
open "./Make DMG Image.workflow/"

echo "Once the DMG image is bundled, press a key"
read -n 1


echo "Git Installer $GIT_VERSION - OS X - Leopard - Intel" | pbcopy

open "http://code.google.com/p/git-osx-installer/downloads/entry"
sleep 1
open "./"
