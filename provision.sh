#!/bin/bash

case $(id -u) in
    0) 
        # Update system
        aptitude update
        #aptitude dist-upgrade -y
        aptitude install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion zsh python-pip -y
        chsh vagrant -s /bin/zsh
        sudo -u vagrant -i $0  # script calling itself as the vagrant user
        ;;
    *) 
        # Install oh-my-zsh
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
        # Install rbenv
        git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
        echo 'eval "$(rbenv init -)"' >> ~/.zshrc
        # Install rbenv
        git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
        source ~/.zshrc
        # Install Ruby 2.0, Bundler and Rails
        rbenv install 2.0.0-p451
        rbenv global 2.0.0-p451
        gem install rbenv-rehash
        rbenv rehash
        gem install bundler
        gem install rails
        # Install heroku-toolbelt
        wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
        # Install nodebrew
        curl -L git.io/nodebrew | perl - setup
        echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.zshrc
        ;;
esac
