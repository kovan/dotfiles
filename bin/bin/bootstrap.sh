#!/bin/sh

git clone https://bitbucket.org/kovan/dotfiles.git
cd dotfiles
git remote set-url origin "git@bitbucket.org:kovan/dotfiles.git"
cd ..

#git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs
#~/.config/emacs/bin/doom install

if cat /etc/arch-release 
then
	INSTALL_CMD="pacman -S --noconfirm --needed"
else
	INSTALL_CMD="apt install -y"
fi

for pkg in fish stow curl wget tmux git fzf neovim net-tools apt-file netcat strace ltrace bwm-ng ripgrep htop fd-find aptitude bpytop rsync lsb-release gnupg ca-certificates lsof
do
	sudo $INSTALL_CMD $pkg
done

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

fish -c "omf install https://github.com/jhillyerd/plugin-git"
fish -c "omf install https://github.com/jethrokuan/fzf"
fish -c "omf install fisk"
fish -c "omf theme fish"

