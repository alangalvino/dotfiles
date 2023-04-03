source ~/.aliasme/aliasme.sh

alias k="kubectl"

em() {
    emacsclient -n -e "(> (length (frame-list)) 1)" | grep -q t
    if [ "$?" = "1" ]; then
        (emacsclient -c -n -a "" "$@" &>/dev/null &)
    else
        (emacsclient -n -a "" "$@" &>/dev/null &)
    fi
    xdotool search --onlyvisible --name "one-emacs" windowactivate
}

alias emt="emacsclient -t"
