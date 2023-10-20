#! /bin/sh

git clone github.com:kovan/dotfiles.git

#git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs
#~/.config/emacs/bin/doom install

if cat /etc/arch-release 
then
	INSTALL_CMD="pacman -S --noconfirm"
else
	INSTALL_CMD="apt install -y"
fi

for pkg in fish curl wget tmux git fzf vim net-tools apt-file netcat strace ltrace bwm-ng ripgrep htop fd-find aptitude bpytop rsync lsb-release gnupg ca-certificates lsof
do
	sudo $INSTALL_CMD $pkg
done

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish


