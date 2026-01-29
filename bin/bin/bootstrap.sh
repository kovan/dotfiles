#git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs
#~/.config/emacs/bin/doom install

if cat /etc/arch-release 
then
	INSTALL_CMD="pacman -S --noconfirm --needed"
else
	INSTALL_CMD="apt install -y"
fi


packages="
cmake
editorconfig
fd
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
starship
lsof
ttf-fira-code
"

echo "$packages" | while read -r pkg; do
	sudo $INSTALL_CMD $pkg
done 



cd dotfiles
git remote set-url origin "git@github.com:kovan/dotfiles.git"
make

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fish -c "
fisher install PatrickF1/fzf.fish
fisher install jhillyerd/plugin-git
fisher install IlanCosman/tide@v6
fisher install gazorby/fish-pacman
tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Dark --show_time='24-hour format' --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Dotted --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Lightest --prompt_spacing=Compact --icons='Many icons' --transient=Yes
"





chsh --shell /usr/bin/fish k

