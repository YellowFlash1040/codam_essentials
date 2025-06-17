alias c='cc -Wall -Wextra -Werror'
alias n='norminette --use-gitignore | grep Error || echo success'
alias gs='git status'
alias ga='git add'
alias gaa='git add *.c *.h Makefile'
alias gp='git push'
alias gpp='git push --set-upstream origin master'
alias gao='git remote add origin'
alias gano='git remote remove origin; git remote add origin'
alias grv='git remote -v'
alias gc='git commit -m'
alias gce='git commit'
alias gl='git log'
alias gunst='git restore --staged'
alias gch='git checkout'
alias gb='git branch'
alias gsw='git switch'
alias gu='git add -u'
alias grc='git rm --cached'
alias gm='git merge'
alias gpl='git pull'
alias gre='git reset --hard HEAD'
alias gi='git init'
alias grf='git restore'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gulc='git reset --soft HEAD~1'
alias grb='git rebase -i'
alias gplf='git fetch origin && git reset --hard origin/'
alias ca='find -name "*.c" -exec sh -c "cc -Wall -Wextra -Werror \"\$0\"" {} \;'
alias tre='source ~/.bashrc'
alias l='clear'
alias f='francinette'
alias m='micro'
alias cb='code ~/.bashrc'
alias cz='code ~/.zshrc'
alias capt="~/.capt/capt"
alias checkf='nm -u'
# alias micro='$HOME/.capt/root/usr/bin/micro'
#see what's inside a stash: git stash show -p stash@{0}

# command to synchronize remote "remote branches" with local "remote branches"
# git fetch --prune
# command to set up git to do it automatically during every git fetch
# git config --global fetch.prune true

gclo() {
    if [ "$#" -eq 1 ]; then
        git clone "https://github.com/YellowFlash1040/$1" .
    elif [ "$#" -eq 2 ]; then
        git clone "https://github.com/YellowFlash1040/$1" "$2"
    else
        echo "Usage: gcl <repo-name> [target-dir]" >&2
        return 1
    fi
}

ct() {
    c -o "unit_tests" "${@:1}" -lcunit -I$HOME/.capt/root/usr/include -L$HOME/.capt/root/usr/lib/x86_64-linux-gnu
}

cct() {
    c -o "tests" "${@:1}" -lcheck -lm -lsubunit -I$HOME/.capt/root/usr/include -L$HOME/.capt/root/usr/lib/x86_64-linux-gnu
}


alias francinette=/home/akovtune/francinette/tester.sh
alias paco=/home/akovtune/francinette/tester.sh


export LD_LIBRARY_PATH=~/.capt/root/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
alias xclean="/bin/bash $HOME/xclean.sh"

upscale() {
  magick "$1" -filter point -resize 64x64 "${1%.png}_upscaled.png"
}

xpm() {
  magick "$1" "${1%.png}.xpm"
}

magick() {
    "$HOME/.capt/root/usr/bin/convert-im6.q16" "$@"
}

eclass() {
    "$HOME/codam/core/scripts/c/create_empty_class.sh" "$@"
}

class() {
    "$HOME/codam/core/scripts/c/create_class.sh" "$@"
}

cppclass() {
    "$HOME/codam/core/scripts/cpp/class.sh" "$@"
}

snippet() {
    "$HOME/codam/core/scripts/snippet/snippet.sh" "$@"
}

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/akovtune/.dotnet/tools:$HOME/.capt/root/usr/bin:$HOME/.unity/src"

export UNITY_HOME="$HOME/.unity/src"
export UNITY="$UNITY_HOME/unity.c -I$UNITY_HOME"

fix_edge()
{
	ps aux | grep microsoft-edge; pkill microsoft-edge; rm ~/.config/microsoft-edge/SingletonLock; microsoft-edge
}
