# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH=/opt/homebrew/bin:$PATH

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# Misc
alias ..='cd ..'
alias ls='lsd'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias loadConf='source ~/.zshrc'
alias formatJSON='pbpaste | jq . | pbcopy'
alias localip='ifconfig | grep "inet " | grep -v 127.0.0.1'
alias da='direnv allow'
alias mc='mix compile'
alias mdg='mix deps.get'


# Containers and stuff (docker, kubernetes)

alias d='docker'
alias dc='docker compose'
alias mk='minikube'
alias k='kubectl'
alias dcd='docker compose down'
alias dcu='docker compose up'
alias dcud='dcu -d'

function dsh {
    docker exec -it $1 /bin/bash
}

# Set iterm tab title
function precmd() {
    window_title="\033];${PWD##*/}\007"
    echo -ne "$window_title"
}

function gcdb() {
    targetBranch="main"
    if [ "$1" != "" ]
    then
        targetBranch=$1
    fi
    curBranch=`git rev-parse --abbrev-ref HEAD`
    git checkout $targetBranch
    git branch -D $curBranch
    git pull
    git remote prune origin
    git br
}

function grau() {
    # $1 should be the git address of the original repo
    git remote add upstream $1
    git fetch upstream
}

function griu() {
    git rebase -i upstream/main
}

function grub() {
    targetBranch="main"
    if [ "$1" != "" ]
    then
        targetBranch=$1
    fi
    git fetch upstream
    git rebase upstream/$targetBranch
}

function gprod() {
    targetCommit="HEAD"
    if [ "$1" != "" ]
    then
        targetCommit=$1
    fi
    git tag -d prod
    git push --delete origin prod
    git tag -a prod $targetCommit -m "prod"
    git push origin prod
}

function grum() {
    targetBranch="main"
    if [ "$1" != "" ]
    then
        targetBranch=$1
    fi
    git rebase -i upstream/$targetBranch
}

function gared() {
    git reset --hard HEAD~$1
}

function gyolo() {
    curBranch=`git rev-parse --abbrev-ref HEAD`
    git push --force-with-lease origin $curBranch 2>&1 | egrep -o "https://.*" | xargs open
}

# renameFiles old new
function renameFiles() {
    find . -iname "*$1*" -exec rename "s/$1/$2/" '{}' \;
}

function getBranch() {
    git rev-parse --abbrev-ref HEAD
}

function gl() {
    git log -p --all -S$1
}

fpath=(~/.zsh.d/ $fpath)

export GIT_HOOKS_DIR="$HOME/git-hooks"
export PATH="${HOME}/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:${HOME}/.bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export BUILD_OS='darwin'
export CC='gcc'
export CXX='g++'
export VISUAL=/usr/bin/vim
export KERL_BUILD_DOCS="yes"
# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR=code
export EDITOR=code

# Set ipdb as the default Python debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump alias-tips zsh-peco-history zsh-autosuggestions git-open)

source $ZSH/oh-my-zsh.sh

# Git
alias createGitlab="git push --set-upstream git@gitlab.com:RealVidy/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)"
alias excludeGit='vim .git/info/exclude'
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gbclean='git remote prune origin'
alias gbD='git branch -D'
alias gbm='git branch -m'
alias gcia='git commit --amend'
alias gciaa='git commit -a --amend --no-edit'
alias gclean='git clean -i'
alias gcm='git add -A && git commit -a -m'
alias gd='git diff'
alias gerard='git reset --hard'
alias gers='git reset --soft HEAD^ && git reset HEAD'
alias gfap='git fetch --all --prune'
alias gh="open \`git remote -v | grep fetch | awk '{print \$2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'\`| head -n1"
alias glg="git lo"
alias glo="git lo"
alias go='git open'
alias gp='git push'
alias gpl='git pull'
alias gplm='git fetch && git pull --rebase origin main'
alias gpo='getBranch | git push origin 2>&1 | egrep -o "https://.*" | xargs open; git br'
alias gpot='git push origin --tags'
alias gpp='git push && git fetch && git pull origin main'
alias gpr='git co main && git fetch && git pull origin main && git co - && git rebase main'
alias gprm='git rebase main'
alias gprune='git remote prune origin'
alias gprunen='git remote prune origin --dry-run'
alias gptt='git-push-to-target'
alias gpu='git push -u'
alias grim='git rebase -i origin/main'
alias gs='git status'
alias gss='git stash save'
alias gst='git st'
alias gsu='git submodule update'
alias gsur='git submodule update --remote'
alias gstat='git quick-stats'

# LE WAGON - BEGIN
# Load pyenv (to manage your Python versions)
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init - 2> /dev/null)" && RPROMPT+='[🐍 $(pyenv version-name)]'

# LE WAGON - END

if [ -f ~/.zshrc-local.sh ]; then
    source ~/.zshrc-local.sh
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
