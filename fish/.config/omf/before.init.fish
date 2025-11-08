function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    builtin history delete --exact --case-sensitive -- $fucked_up_command
    builtin history merge
  end
end

function export
    if [ $argv ] 
        set var (echo $argv | cut -f1 -d=)
        set val (echo $argv | cut -f2 -d=)
        set -g -x $var $val
    else
        echo 'export var=value'
    end
end

set -g fish_greeting
fish_config theme choose Dracula

alias lola "git log --graph --decorate --pretty=oneline --abbrev-commit"
alias drop_cache "sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
alias vi nvim
alias py python
alias vact ". .venv/bin/activate.fish"
alias mapkeys "gsettings set org.gnome.desktop.input-sources xkb-options \"['ctrl:swap_lwin_lctl']\""
alias sc "sudo systemctl"
alias pacin "sudo pacman --noconfirm -S"
alias aptin "sudo apt install"


# Title options
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path yes


set -xg GTK_THEME Adwaita:dark

set -U fish_user_paths $HOME/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths
set -U fish_user_paths $HOME/.config/emacs/bin  $fish_user_paths
set -U fish_user_paths /snap/bin  $fish_user_paths
set -U fish_user_paths $HOME/.poetry/bin  $fish_user_paths
set -U fish_user_paths $HOME/.cargo/bin  $fish_user_paths
set -U fish_user_paths /opt/google-cloud-cli/bin  $fish_user_paths
#set -U fish_user_paths (gem env user_gemhome)/bin  $fish_user_paths

set -gx ANDROID_HOME $HOME/Android/Sdk
#set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
#set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
#set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
#fish_add_path -gP "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin";
#! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH;
#! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH;
set -gx NODE_OPTIONS "--openssl-legacy-provider"
#if not set -q VSCODE_TERM
#    tmux attach || tmux
#end
