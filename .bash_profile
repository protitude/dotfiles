_complete_ssh_hosts ()
{
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
    cut -f 1 -d ' ' | \
    sed -e s/,.*//g | \
    grep -v ^# | \
    uniq | \
    grep -v "\[" ;
  cat ~/.ssh/config | \
    grep "^Host " | \
    awk '{print $2}'
  `
  COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
  return 0
}
complete -F _complete_ssh_hosts ssh
HISTCONTROL=ignoreboth

alias wtf="sudo !!"

alias gt="git for-each-ref --sort='*authordate' --format='%(refname:short)' refs/tags"
alias svn-remove="find . -name ".svn" -type d -exec rm -rf {} \;"
alias dsstore-remove="find . -name '*.DS_Store' -type f -delete"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias selenium-server="/usr/local/Cellar/selenium-server-standalone/2.49.0/bin/selenium-server"

alias gs='git status'
alias gc='git commit'
alias gco='git checkout'
alias gl='git pull --rebase'
alias gpom="git pull origin master"
alias gpu="git pull"
alias gp='git push'
alias gb='git branch'
alias gba='git branch -a'
alias gsc='chmod 775 sites/default; chmod 775 sites/default/settings.php; git checkout dev sites/default/settings.php'
alias del='git branch -d'
alias ddevel="git diff | egrep 'dpm|dsm|print'"

alias dsi="head -1 readme.md | bash"
alias dli="drush uli france"
alias ds-perm='drush eval "secure_permissions_rebuild();"'

alias ccp="compass compile -e production --force"
alias cw="compass watch --poll"
alias bccp="bundle exec compass compile -e production --force"
alias bcw="bundle exec compass watch --poll"

alias knox-temp="curl -s https://api.thingspeak.com/channels/132817/fields/1.json?results=1 | python -mjson.tool | grep field1"
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias sync-oitfiles='rsync -r --exclude="docs" --exclude="files" --exclude="printers" --exclude="overview-docs" --exclude="restricted" --include="*/" --include="*.[Jj][Pp][Gg]" --include="*.[Pp][Nn][Gg]" --exclude="*" oit:/home/cuboulderoit/prod/sites/default/files/ /web/oit/docroot/sites/default/files/'

alias bkup-web='cp -R web backups/web-$(date +%Y-%m-%d:%H:%M:%S)'

#composer install without xdebug
alias comp='php -n /usr/local/Cellar/composer/1.2.1_1/libexec/composer.phar'

#drush Commands
function pifind() {
  sudo nmap -sP 192.168.1.0/24 | awk '/^Nmap/{ip=$NF}/B8:27:EB/{print ip}'
}
function lifelog () {
  FILE="/web/cm/lifelog/2018/$(date +%Y%m%d).md"
  if [ -f $FILE ];
  then
    vi $FILE
  else
    cd /web/cm/lifelog/2018/
    cp $(ls -t | head -n1) $FILE
    echo "Created $FILE"
    sleep 1
    vi $FILE
  fi
}
# Super useful Docker container oneshots.
# Usage: dockrun, or dockrun [centos7|fedora24|debian8|ubuntu1404|etc.]
# https://www.jeffgeerling.com/blog/2017/dockrun-oneshot-quick-local-environments
dockrun() {
    docker run -it geerlingguy/docker-"${1:-ubuntu1604}"-ansible /bin/bash
  }

function chrometrust () {
  rm -fR /tmp/chrometrust
  mkdir /tmp/chrometrust
  /Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --user-data-dir=/tmp/chrometrust --unsafely-treat-insecure-origin-as-secure=$1
}
function chromefile () {
  cat "$1" | xargs open
}
function drush-sd () {
  drush "$1" sql-dump > $(date +%Y-%m-%d-%H.%M.%S).sql
}
function dlc () {
  drush uli "$1" | xargs open -a /Applications/Google\ Chrome.app
}
function did () {
  drush $3 sql-drop -y;drush $3 sqlc < $1;drush $3 cc all;drush $3 en views_ui devel update -y;drush $3 updb -y;drush $3 dis overlay -y;drush $3 en devel_generate -y;drush $3 sql-sanitize -y;drush $3 uli $2;vset acquia_key $ACQUIAKEY;cowsay 'Import Complete'
}

function title() {
  export PROMPT_COMMAND='echo -ne "\033]0;"'$1'"\007"'
}

function estone() {
  node -e "require('eddystone-beacon').advertiseUrl('$1');"
}

source ~/.goto_shortcuts
function short () {
  shortcut=$(pwd)
  echo 'alias .'$1'="cd '$shortcut'"' >> ~/.goto_shortcuts
  source ~/.bash_profile
}
if [ -f "$HOME/Dropbox/programs/bash/profile_sensitive" ]
then
  source "$HOME/Dropbox/programs/bash/profile_sensitive"
fi
if [ -f "$HOME/.sensitive_vars" ]
then
  source "$HOME/.sensitive_vars"
fi
if [ -f "$HOME/.bash_ps1" ]; then
  . "$HOME/.bash_ps1"
fi
# Delete a given line number in the known_hosts file.
knownrm() {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "error: line number missing" >&2;
  else
    sed -i '' "$1d" ~/.ssh/known_hosts
  fi
}
if hash gdate 2>/dev/null; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
# Load gems into home directory
export GEM_HOME=/Users/milesfrance/.gem

