# Install Sublime Text 2

## Download Sublime Text 2
http://www.sublimetext.com/2
Extract to /home/<me>/Apps/

## Setup a symlink
	$sudo ln -s /home/<me>/Apps/Sublime\ Text\ 2/sublime_text /usr/bin/slime

## Install SASS and HAML code highlighting
	$git clone git://github.com/nathansmith/sublime-text-haml-sass.git ~/Downloads/sublime-text-haml-sass
	$cp -r ~/Downloads/sublime-text-haml-sass/Ruby\ Haml/ ~/.config/sublime-text-2/Packages/
	$cp -r ~/Downloads/sublime-text-haml-sass/Ruby\ Sass/ ~/.config/sublime-text-2/Packages/

