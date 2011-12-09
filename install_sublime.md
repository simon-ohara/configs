# Install Sublime Text 2

## Update Package Dependencies
	$ sudo apt-get install gtk2-engines-pixbuf

## Download Sublime Text 2
http://www.sublimetext.com/2
Extract to ~/Applications/

## Setup a symlink
	$ sudo ln -s /home/<me>/Applications/Sublime\ Text\ 2/sublime_text /usr/bin/slime

## Install SASS and HAML code highlighting
$ git clone git://github.com/nathansmith/sublime-text-haml-sass.git ~/Downloads/sublime-text-haml-sass; mkdir ~/.config/sublime-text-2; mkdir ~/.config/sublime-text-2/Packages; cp -r ~/Downloads/sublime-text-haml-sass/Ruby\ Haml/ ~/.config/sublime-text-2/Packages/; cp -r ~/Downloads/sublime-text-haml-sass/Ruby\ Sass/ ~/.config/sublime-text-2/Packages/

