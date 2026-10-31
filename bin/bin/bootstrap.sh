#git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs
#~/.config/emacs/bin/doom install

packages="
cmake
editorconfig
tree
thefuck
make
fish
stow
curl
wget
tmux
git
fzf
neovim
net-tools
strace
ltrace
bwm-ng
ripgrep
htop
bpytop
rsync
lsb-release
gnupg
ca-certificates
starship
lsof
mg
"

if [ -f /etc/arch-release ]
then
	ARCH=1
	INSTALL_CMD="pacman -S --noconfirm --needed"
	packages="$packages
fd
bandwhich
tldr
openbsd-netcat
ttf-fira-code
"
else
	INSTALL_CMD="apt install -y"
	packages="$packages
fd-find
tealdeer
netcat-openbsd
fonts-firacode
apt-file
aptitude
"
fi

echo "$packages" | while read -r pkg; do
	[ -n "$pkg" ] && sudo $INSTALL_CMD $pkg
done

# Debian ships fd as fdfind
if [ -z "$ARCH" ] && command -v fdfind >/dev/null && ! command -v fd >/dev/null; then
	mkdir -p ~/.local/bin
	ln -s "$(command -v fdfind)" ~/.local/bin/fd
fi



cd "$(dirname "$(realpath "$0")")/../.."
git remote set-url origin "git@github.com:kovan/dotfiles.git"
make

fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

fish -c "
fisher install PatrickF1/fzf.fish
fisher install jhillyerd/plugin-git
fisher install IlanCosman/tide@v6
tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Dark --show_time='24-hour format' --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Dotted --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Lightest --prompt_spacing=Compact --icons='Many icons' --transient=Yes
"
[ -n "$ARCH" ] && fish -c "fisher install gazorby/fish-pacman"





[ "$(getent passwd "$USER" | cut -d: -f7)" = "$(command -v fish)" ] || sudo chsh --shell "$(command -v fish)" "$USER"
