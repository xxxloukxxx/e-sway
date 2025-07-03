all: upgrade install config suckless ohmyzsh keyb locales

upgrade:
	echo "\n>>> Update and upgrade"
	sudo sh -c 'echo "cedric ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/cedric && chmod 0440 /etc/sudoers.d/cedric'
	sudo cp -fr .install/sources.list /etc/apt/
	sudo apt -y -qq update
	sudo apt -y -qq full-upgrade

install:
	echo "\n>>> Install zsh, vim and friends"
	sudo apt -y -qq install git make build-essential cmake ninja-build micro nnn vim vim-gtk3 zsh stterm lsd ripgrep suckless-tools aptitude nala universal-ctags
	sudo apt -y -qq install curl wget tmux gettext unzip p7zip-full rsync fd-find bat tree btop locales-all gcc silversearcher-ag
	sudo apt -y -qq install moc pulseaudio pavucontrol fzf caja flameshot trash-cli
	sudo apt -y -qq install x11-utils libreadline-dev libx11-dev libxinerama-dev libxft-dev numlockx xdotool
	sudo apt -y -qq install greetd sway xwayland dex i3blocks feh suckless-tools dunst
	sudo cp -fr .install/greetd.config.toml /etc/greetd/config.toml
	sudo apt -y -qq install 'fonts-hac*' 'fonts-libe*' fonts-font-awesome fonts-terminus-otb fonts-agave 'fonts-ibm*'
	sudo apt -y -qq install fonts-noto-color-emoji fonts-noto-core fonts-noto-extra fonts-noto-hinted fonts-noto-mono fonts-noto-ui-core
	sudo apt -y autoremove
	sudo aptitude -y -q=5 autoclean
	sudo aptitude -y -q=5 purge

ohmyzsh:
	echo "\n>>> Install Oh-my-zsh"
	sudo apt -y -qq install zsh
	nala --install-completion zsh
	rm -fr ~/.oh-my-zsh 2> /dev/null
	wget -q "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
	chmod +x ./install.sh
	./install.sh --unattended
	rm -fr ./install.sh
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	cp -fr .zshrc ~/
	cp -fr .install/avit.zsh-theme ~/.oh-my-zsh/themes/
	echo "\n>>> Change Shell to zsh"
	chsh -s /bin/zsh

config:
	echo "\n>>> Copy .zshrc, .vimrc and friends to ~/"
	cp -fr .w ~/
	cp -fr .vimrc ~/
	cp -fr .zshrc ~/
	cp -fr .moc ~/
	cp -fr .latexmkrc ~/
	cp -fr .config ~/
	sudo cp -fr bin/* /usr/bin/
	cp -fr .fonts ~/
	fc-cache -r

suckless:
	echo "\n>>> Install st and friends"
	sudo make -C dev clean install --silent
	sudo make -C dev clean --silent

locales:
	sudo dpkg-reconfigure locales

keyb:
	sudo dpkg-reconfigure keyboard-configuration

packages:
	echo "\n>>> Install some packages"
	sudo apt -y -qq install gimp firefox-esr firefox-esr-l10n-fr texlive-full evince zathura okular pdftk imagemagick eog qimgv

xcmd:
	wget -O xcmd.sh https://get.x-cmd.com
	sudo chmod 777 xcmd.sh
	./xcmd.sh
	rm -fr xcmd.sh

.SILENT:
