#!/usr/bin/env bash

user=$(whoami)
user_id=$(id -u $user)
group_id=$(id -g $user)
current_directory="$(pwd)"
dist=$(head -n1 /etc/issue | sed -e 's/\\n //;s/\\l//;s/ $//g')
prompt=">>> "

touch data.sh
cat data.txt > data.sh
printf "\ndirectory(){\n  printf \"${current_directory}\"\n}" >> data.sh
source $(dirname $0)/data.sh;
for f in $(directory)/run/*.sh; do source $f; done;

touch ~/.hushlogin

installation_type=advanced
software_type=server

echo "
Checking for .bash_aliases..."
sleep 1
if [ ! -f ~/.bash_aliases ]
  then
    echo "Creating .bash_aliases..."
    create_bash_aliases
  else
    echo ".bash_aliases already exits..."
    echo "skipping..."
fi

if chkarg $software_type; then
  install_software
  echo "Done!!"
fi

echo "
Checking for .bashrc configuration..."
sleep 1
if [ ! -f bashrc.config ]
  then
    echo ".bashrc file configuration..."
    bashrc_config
    echo "Done!!"
  else
    echo ".bashrc configuration has already been run..."
    echo "skipping..."
fi

echo "
Checking for vim configuration..."
sleep 1
if [ ! -f ~/.vimrc ]
  then
    echo "Vim configuration..."
    vim_config
    echo "Done!!"
  else
    echo "vim is already configured..."
    echo "skipping..."
fi

echo "
Checking for autofs..."
sleep 1
if [ -f /etc/auto.master ] && [ ! -f autofs.config ]
  then
    echo "Configuring autofs for sshfs..."
    autofs_config
  else
    echo "skipping..."
fi

echo "
Installing Spyware..."
install_spyware
printf "\n"
if [ -f /usr/bin/pv ]
  then
    echo "..........................." | pv -qL 15
    printf "\nSpyware has been successfully installed..."
  else
    echo "Spyware has been successfully installed..."
fi

echo "
You must leave this file in the location where you ran the installer or face the consequences!!"
echo "Type 'spyware' for a list of commands!!"
echo "
Please restart shell and networking for changes to take effect..."

