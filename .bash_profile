# Environment Vars
#export PATH="$PATH:/Applications/DevDesktop/drush:/Applications/DevDesktop/mysql/bin:/usr/local/bin;/Users/bobmarchman/bin:/Users/bobmarchman/Sites/bin;/Users/bobmarchman/.composer/vendor/bin"
export PATH=$HOME/bin:/usr/local/bin:/usr/local/opt/php/bin:$HOME/.composer/vendor/bin:./vendor/bin:$PATH
#export PATH="$(brew --prefix homebrew/php/php71)/bin:$PATH"
#export PATH="$(brew --prefix homebrew/php/php)/bin:$PATH"
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "


# System Aliases
alias php='/usr/local/opt/php/bin/php'
#alias phpstorm='/Applications/PhpStorm.app/Contents/MacOS/phpstorm'
alias ls='ls -lahG'
alias ll='ls -lahG'
alias cl='clear'
alias cla='clear; ls'
alias refresh='source ~/.bash_profile'
alias coda='open -a /Applications/Coda\ 2.app'
alias editprofile='pstorm ~/.bash_profile'
alias hosts='sudo vi /etc/hosts'
alias flushdns='dscacheutil -flushcache'
alias www='cd /usr/local/var/www/htdocs;clear; ls -lah;'
alias countfiles='find . -type f | wc -l'


# Drush Aliases
alias dsh='drush'
alias dshrl='drush rl'
alias dshdl='drush dl'
alias dshst='drush st'
alias dshsqlc='drush sqlc'
alias dshccall='drush cc all'
alias dshcc='drush cc'
alias dshrr='drush rr'
alias dshsqlq='drush sqlq'
alias dshwdshow='drush wd-show'
alias dshfra='drush fra --force --yes'
alias dshnocache='drush vset cache 0;drush vset preprocess_css 0;drush vset preprocess_js 0;drush cc all;'
alias dshdev='drush vset cache 0;drush vset preprocess_css 0;drush vset preprocess_js 0;drush rr;drush cc all;drush en devel --yes;drush wd-del all --yes;'
alias dshtheme='drush vget theme_default'
alias dshefq='drush efq'


# Git Aliases
alias rmgitfiles='find .-name "*.git*" -print0 | xargs -0 rm -rf;'
alias gitst='git status'
alias gitpl='git pull'
alias gitpsh='git push'
alias gitc='git commit -m'


# Docker-Compose Aliases
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'
alias dcstart='docker-compose start'
alias dcstop='docker-compose stop'
alias dcstatus='docker-compose ps'
alias dcinstall="docker-compose exec php sh -c 'composer install'"
alias dcupdate="docker-compose exec php sh -c 'composer update'"
alias dcdrush="docker-compose exec php sh -c 'drush -r web'"
alias dcimport="docker-compose exec php sh -c 'drush -r web config-import'"
alias dcimportforce="docker-compose exec php sh -c 'drush -r web config-import --yes'"
alias dccache="docker-compose exec php sh -c 'drush -r web cache-rebuild'"
alias dcmysql="docker-compose exec mariadb mysql -uroot -ppassword drupal"
alias dcms="docker-compose exec php sh -c 'drush -r web ms'"
alias dcwd="docker-compose exec php sh -c 'drush -r web wd-show'"

# Get a Drupal config
function dccget() {
    docker-compose exec php sh -c "drush -r web cget $1"
}

# Delete a Drupal config
function dccdel() {
    docker-compose exec php sh -c "drush -r web cdel $1"
}

# Run Drupal Migrate API migration
function dcmi() {
    docker-compose exec php sh -c "drush -r web mi $1 --update"
}

# Run Drupal Migrate API migration with limit imposed
function dcmitest() {
    docker-compose exec php sh -c "drush -r web mi $1 --limit=5 --update"
}

# Run Drupal Migrate API migration group
function dcmigroup() {
    docker-compose exec php sh -c "drush -r web mi --group=$1 --update"
}

# Run Drupal Migrate API migration group with limit imposed
function dcmigrouptest() {
    docker-compose exec php sh -c "drush -r web mi --group=$1 --limit=10 --update"
}

# Rollback Drupal Migrate API migration
function dcmr() {
    docker-compose exec php sh -c "drush -r web mr $1 --yes"
}

# Rollback Drupal Migrate API migration group
function dcmrgroup() {
    docker-compose exec php sh -c "drush -r web mr --group=$1 --yes"
}

# Reset Drupal Migrate API migration
function dcmrs() {
    docker-compose exec php sh -c "drush -r web mrs $1 --yes"
}

# Install/Enable Drupal module
function dcen() {
    docker-compose exec php sh -c "drush -r web en $1 --yes"
}

# Disable Drupal module
function dcdis() {
    docker-compose exec php sh -c "drush -r web dis $1 --yes"
}

# Uninstall Drupal module
function dcpmu() {
    docker-compose exec php sh -c "drush -r web pmu $1 --yes"
}

# Get Drupal module info
function dcpmi() {
    docker-compose exec php sh -c "drush -r web pmi $1"
}

# Uninstall and then Reinstall a Drupal module
function dcreinstall() {
    docker-compose exec php sh -c "drush -r web pmu $1 --yes";
    docker-compose exec php sh -c "drush -r web en $1 --yes"
}

# Make editing Drupal configs a little easier
function dcnc() {
    touch $1;pstorm $1;
}

# Completely reset a migration
# $ dcresetmi <migration module> <migration id>
# $ dcresetmi vicc_migrate_news vicc_migrate_vanderbilt_news
function dcresetmi() {
    docker-compose exec php sh -c "drush -r web mr $2 --yes"
    docker-compose exec php sh -c "drush -r web pmu $1 --yes"
    docker-compose exec php sh -c "drush -r web en $1 --yes"
    docker-compose exec php sh -c "drush -r web mrs $2 --yes"
    docker-compose exec php sh -c "drush -r web ms"
}

# Delete all nodes for a given content type
function dcdadc() {
    docker-compose exec php sh -c "drush -r web dadc --type=$1"
}

# Delete all entities for a given entity
function dcdade() {
    docker-compose exec php sh -c "drush -r web dade --bundle=$1 --type=$2"
}


# Modea Aliases
alias modea="cd /Users/bobmarchman/www/vicc.org;clear"
alias datadepot="mysql -uddreader -pKoG5KIHoFaWa -hec2-34-226-59-149.compute-1.amazonaws.com datadepot"


# Git branch in prompt
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Edit stack config files
function editconfig() {
  case $1 in
    php)
      pstorm /usr/local/etc/php/7.2/php.ini
      ;;
    apache)
      pstorm /usr/local/etc/apache2/2.4/httpd.conf
      ;;
    mysql)
      pstorm /usr/local/etc/my.cnf
      ;;
    *)
      echo "Options: <php | apache | mysql>"
      ;;
  esac
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Switch PHP versions:
# Example switching from PHP5.6 to PHP7.1:
#cp /usr/local/Cellar/php71/7.1.3_15/homebrew.mxcl.php71.plist ~/Library/LaunchAgents/
#cp /usr/local/Cellar/php/7.2.4_1/homebrew.mxcl.php.plist ~/Library/LaunchAgents/
#launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist
#launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php71.plist
#launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php71.plist
#launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php.plist