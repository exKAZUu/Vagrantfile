#!/bin/bash

case $(id -u) in
    0) 
        # Update system
        aptitude update
        aptitude dist-upgrade -y
        # General
        aptitude install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion zsh python-pip
        # Others
        aptitude install -y imagemagick libarchive-dev dos2unix
        # MySQL
        aptitude install -y libmysql-ruby libmysqlclient-dev
        # PostgreSQL
        aptitude install -y libpq-dev
        # Docker
        aptitude install -y docker.io
        ln -sf /usr/bin/docker.io /usr/local/bin/docker
        sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
        chsh vagrant -s /bin/zsh
        sudo -u vagrant -i $0  # script calling itself as the vagrant user
        ;;
    *) 
        # Install oh-my-zsh
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
        # Install RVM
        \curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles
        source ~/.zshrc
        # Install Ruby 2.0, Bundler and Rails
        rvm install ruby-2.0.0-p451
        rvm alias create default ruby-2.0.0-p451
        rvm use 2.0.0
        gem install bundler
        gem install rails
        # Install heroku-toolbelt
        wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
        # Install nodebrew
        curl -L git.io/nodebrew | perl - setup
        echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.zshrc
        source ~/.zshrc
        # Install Node.js
        nodebrew install stable
        nodebrew use stable
        npm install -g bower grunt-cli
        # Install Meteor
        curl https://install.meteor.com/ | sh
        ;;
esac
