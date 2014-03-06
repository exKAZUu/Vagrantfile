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
        # Install RVM
        \curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles
        # Install Ruby 2.0, Bundler and Rails
        rvm install ruby-2.0.0-p451
        rvm install 1.9.3
        rvm alias create default ruby-2.0.0-p451
        gem install bundler
        gem install rails
        # Install heroku-toolbelt
        wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
        # Install nodebrew
        curl -L git.io/nodebrew | perl - setup
        echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.zshrc
        ;;
esac
