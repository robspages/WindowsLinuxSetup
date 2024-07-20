#!/bin/sh


#### FUNCTIONS!! ####

do_the_zsh_thing(){
  if [ $(echo $SHELL) != *"zsh"* ];
  then
    fancy_echo "Upgrading you to ZSH"
    fancy_install "zsh"
    if [ ! -f "~/.zshrc" ]; 
    then 
      touch ~./zshrc
      touch ~/.zprofile 
      touch ~/.zlogin 
    fi

    chsh -s $(which zsh)
    exec zsh --login
    fancy_echo "You are now on ZSH"
  else 
    fancy_echo "You are already on ZSH"
  fi
}

# stolen from Thoughtbot's Laptop Mac script
append_to_zshrc(){
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\\n" "$text" >> "$zshrc"
    else
      printf "\\n%s\\n" "$text" >> "$zshrc"
    fi
  fi

  zsh_update
}

zsh_update(){
  #make sure to reload all of the goodies
  #we can try exec zsh -l but this seems safer 
  source ~/.zlogin
  source ~/.zprofile
  source ~/.zshrc
}

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

fancy_install(){
  fancy_echo "Installing $1"
  sudo apt-get install $1
  zsh_update
}

### Getting Things Done ###

do_the_zsh_thing

#install other prereqs
fancy_install "git"
fancy_install "curl"
fancy_install "gpg"
fancy_install "gawk"

#getting the ASDF programming language version manager
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
append_to_zshrc 'export PATH="$HOME/.asdf/asdf.sh:$PATH"'

#plugins 
asdf plugin-list
asdf plugin install ruby "https://github.com/asdf-vm/asdf-ruby.git"
asdf plugin install node "https://github.com/asdf-vm/asdf-node.git"
zsh_update 

# languages 
fancy_echo "Installing Ruby 3.3.4"
asdf list all ruby
asdf install ruby 3.3.4

fancy_echo "Installing the latest version of Node.js"
asdf list all node 
asdf install node latest 

zsh_update

#### RAILS!
fancy_echo "creating a Projects folder ..."
mkdir -p ~/Projects 

fancy_echo "Installing Rails 7.1 ..."
gem install rails -v 7.1

fancy_echo "Thats It! Your Ubuntu Terminal is ready to start building!"