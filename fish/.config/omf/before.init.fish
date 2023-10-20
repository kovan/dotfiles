alias lola "git log --graph --decorate --pretty=oneline --abbrev-commit"
alias drop_cache "sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
alias vi vim
alias mapkeys "gsettings set org.gnome.desktop.input-sources xkb-options \"['ctrl:swap_lwin_lctl']\""
alias sc "sudo systemctl"
alias pacin "sudo pacman --noconfirm -S"
alias aptin "sudo apt install"

fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.config/emacs/bin 
fish_add_path /snap/bin 
fish_add_path $HOME/.poetry/bin 

