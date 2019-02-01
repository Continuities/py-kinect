#!/bin/bash

printf "Bootstrapping dev environment...\n\n"
  
function installed() {
  if command -v $1 >/dev/null; then
    return 0
  else
    return 1
  fi
}

printf "Installing dependencies"
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

if installed pyenv ; then
  printf "pyenv already installed\n"
else
  printf "Installing pyenv...\n"
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  echo -e "\n# Initialize pyenv\nexport PATH=\"/root/.pyenv/bin:\$PATH\"\neval \"\$(pyenv init -)\"\neval \"\$(pyenv virtualenv-init -)\"\n" >> ~/.bashrc
  source ~/.bashrc
fi

printf "Getting Python on my level...\n"
pyenv install -s 3.7.1 > /dev/null
eval "$(pyenv init -)"

printf "Installing library dependencies...\n"
pip install -r requirements.txt > /dev/null

printf "Installing libfreenect...\n"
sudo apt-get install freenect

printf "Building the freenect python package...\n"
python setup.py build_ext --inplace > /dev/null

printf "\nAll good!\nYou should now be able to import freenect from python programs.\n"