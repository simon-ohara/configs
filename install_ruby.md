# Installing Ruby Guidelines

## Get required system packages for Ruby
	$ sudo apt-get install build-essential libssl-dev libreadline5 libreadline5-dev zlib1g zlib1g-dev

## Install GIT
	$ sudo apt-get install git git-core
[ruby-build](https://github.com/sstephenson/ruby-build)
[Setup SSH keys](http://help.github.com/linux-set-up-git/#_set_up_ssh_keys)
[Setup your info](http://help.github.com/linux-set-up-git/#_set_up_your_info)

## Install ruby-build
Full instructions: https://github.com/sstephenson/ruby-build

	$ git clone git://github.com/sstephenson/ruby-build.git
	$ cd ruby-build
	$ sudo ./install.sh

## Install rbenv
Full instructions: https://github.com/sstephenson/rbenv

	$ cd
	$ git clone git://github.com/sstephenson/rbenv.git .rbenv
	$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	$ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
Restart terminal

## Install ruby
	$ rbenv install 1.9.2-p290
	$ touch ~/.gemrc
	$ echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc

## Install bundler
	$ gem install bundler

## Install rails
	$ gem install rails
