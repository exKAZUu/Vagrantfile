#!/bin/bash

case $(id -u) in
    0) 
        # Update system
        apt-get update
        apt-get dist-upgrade -y
        # General
        apt-get install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion zsh python-pip
        # Others
        apt-get install -y imagemagick libarchive-dev dos2unix
        # MySQL
        apt-get install -y libmysql-ruby libmysqlclient-dev
        # PostgreSQL
        apt-get install -y libpq-dev
        # Docker
        curl -s https://get.docker.io/ubuntu/ | sh
        docker login -e aicomp364@gmail.com -u aicomp -p aicomp364-akiramenai
        docker pull exkazuu/execution
        # Zsh
        chsh vagrant -s /bin/zsh
        sudo -u vagrant -i $0  # script calling itself as the vagrant user
        ;;
    *) 
        # Install oh-my-zsh
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
        source ~/.zshrc
        # Install nodebrew
        curl -L git.io/nodebrew | perl - setup
        echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.zshrc
        source ~/.zshrc
        # Install Node.js
        nodebrew install stable
        nodebrew use stable
        npm install -g bower grunt-cli
        # Install rbenv with ruby-build and rbenv-gem-rehash
        git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
        git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
        git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
        echo 'eval "$(rbenv init -)"' >> ~/.zshrc
        source ~/.zshrc
        # Install Ruby 2.0, Bundler and Rails
        rbenv install 2.0.0-p481
        rbenv rehash
        rbenv global 2.0.0-p481
        rbenv rehash
        gem install bundler
        gem install rails
        # Install heroku-toolbelt
        wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
        # Install Meteor
        curl https://install.meteor.com/ | sh
        # Set up Docker
        sudo groupadd docker
        sudo gpasswd -a ${USER} docker
        sudo service docker restart
        # Set up SSH
        cp -R /VagrantData/.ssh ~/
        chmod 600 -R ~/.ssh/id_rsa
        # ------------ Check Versions ------------
        cd ~
        docker -v >> vagrant_installation_log
        docker images >> vagrant_installation_log
        node -v >> vagrant_installation_log
        bower -v >> vagrant_installation_log
        ruby -v >> vagrant_installation_log
        gem -v >> vagrant_installation_log
        bundle -v >> vagrant_installation_log
        rails -v >> vagrant_installation_log
        ;;
esac
