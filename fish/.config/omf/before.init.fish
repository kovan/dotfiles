alias lola "git log --graph --decorate --pretty=oneline --abbrev-commit"
alias drop_cache "sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
alias vi nvim
alias mapkeys "gsettings set org.gnome.desktop.input-sources xkb-options \"['ctrl:swap_lwin_lctl']\""
alias sc "sudo systemctl"
alias pacin "sudo pacman --noconfirm -S"
alias aptin "sudo apt install"

set -U fish_user_paths $HOME/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths
set -U fish_user_paths $HOME/.config/emacs/bin  $fish_user_paths
set -U fish_user_paths /snap/bin  $fish_user_paths
set -U fish_user_paths $HOME/.poetry/bin  $fish_user_paths


