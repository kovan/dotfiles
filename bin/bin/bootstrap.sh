#git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs
#~/.config/emacs/bin/doom install

if cat /etc/arch-release 
then
	INSTALL_CMD="pacman -S --noconfirm --needed"
else
	INSTALL_CMD="apt install -y"
fi


packages="
bandwhich
tree
tldr
thefuck
make
fish
stow
curl
wget
tmux
git
fzf
nvim
neovim
net-tools
apt-file
netcat
strace
ltrace
bwm-ng
ripgrep
htop
fd-find
aptitude
bpytop
rsync
lsb-release
gnupg
ca-certificates
lsof"

echo "$packages" | while read -r pkg; do
	sudo $INSTALL_CMD $pkg
done 



cd dotfiles
git remote set-url origin "git@bitbucket.org:kovan/dotfiles.git"
make

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

fish -c "omf install https://github.com/jhillyerd/plugin-git"
fish -c "omf install https://github.com/jethrokuan/fzf"
fish -c "omf install fisk"
fish -c "omf theme fisk"

chsh --shell /usr/bin/fish k

