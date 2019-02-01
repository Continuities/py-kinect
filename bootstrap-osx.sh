#!/bin/bash

printf "Bootstrapping dev environment...\n\n"
  
function installed() {
  if command -v $1 >/dev/null; then
    return 0
  else
    return 1
  fi
}

if installed brew ; then
  printf "brew already installed\n"
else
  printf "Installing brew...\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if installed pyenv ; then
  printf "pyenv already installed\n"
else
  printf "Installing pyenv...\n"
  brew install pyenv > /dev/null
  echo -e "\n# Initialize pyenv\nif which pyenv > /dev/null; then eval \"\$(pyenv init -)\"; fi" >> ~/.bash_profile
fi

printf "Getting Python on my level...\n"
pyenv install -s 3.7.1 > /dev/null
eval "$(pyenv init -)"

printf "Installing library dependencies...\n"
pip install -r requirements.txt > /dev/null

printf "Installing libfreenect...\n"
brew install libfreenect > /dev/null

printf "Fetching latest Kinect firmware...\n"
python $(brew --prefix libfreenect)/share/fwfetcher.py > /dev/null

printf "Building the freenect python package...\n"
CFLAGS="-I$(brew --prefix libfreenect)/include/libfreenect" LDFLAGS="-L$(brew --prefix readline)/lib" python setup.py build_ext --inplace > /dev/null

printf "\nAll good!\nYou should now be able to import freenect from python programs.\n"