#!/bin/sh


#export EDITOR=jed
#export VISUAL=jed

# THE ONE AN ONLY PATH:
export PATH="$PATH:$HOME/bin"
#export PATH="$PATH:$HOME/.local/bin"            # pip y easy_install
#export PATH="$PATH:/usr/local/bin"              # homebrew
#export PATH="$PATH:/usr/local/sbin"             # homebrew
#export PATH="$PATH:$HOME/node_modules/.bin"     # npm
#export PATH="$PATH:$HOME/.gem/ruby/1.9.1/bin"   #ruby
#export PATH="$PATH:$HOME/.cask/bin"           # cask
#export PATH="$PATH:$HOME/.composer/vendor/bin"       # composer
#export PATH="$PATH:/usr/local/google_appengine" # GAE
#export PATH="$PATH:/usr/local/heroku/bin"       # heroku
#export PATH="$PATH:$HOME/.linuxbrew/bin:" # linuxbrew
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.linuxbrew/lib"


alias h="guake --toggle-visibility"
alias sudoe="SUDO_EDITOR=\"emacsclient -t -a jed\" sudoedit "
alias e="emacsclient -t -a jed"
alias ec="emacsclient -c -a jed"
alias em="emacsclient -n -a jed"
# alias make="nice -n 19 make -j 2"
alias tailf="tail -n0 -f"
alias ff="find . | grep"
alias iii="sudo apt-get install"
alias sss="apt-cache search --names-only"
alias fssh="ssh -o 'RSAAuthentication=no' -o 'PubkeyAuthentication=no' -o 'UserKnownHostsFile=/dev/null' -F /dev/null"
alias svnmeld='svn diff --diff-cmd=~/bin/svn-diff-meld'
alias ippublica="curl -s http://checkip.dyndns.org/ | grep -o \"[[:digit:].]\+\"" #curl ifconfig.me
alias ns="sudo netstat -nape --inet"
alias trash="mv --target-directory $HOME/.local/share/Trash/files"
alias mirsync="rsync -a --cvs-exclude --progress  --exclude='.*/' --include='*/' --include='*.c' --include='*.h' --include='*.cpp'  --exclude='*'"
alias mimonitor="vmstat 1 | awk '{now=strftime(\"%Y-%m-%d %T \"); print now $0}'"
alias mibackup='tar -cjvvf backup$(date +%Y%m%d_%H%M%S).tar.bz2'
alias generarips='nmap -n -iR 0 -sL | cut -d" " -f 2'



