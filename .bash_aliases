alias python=python3
alias rick="echo 'Never gonna let you down' && touch prout"
alias t='tmux'
alias pip="echo 'Surtout pas!!!'"
function c() {
    "$@" | xclip -selection clipboard
}

function workdir() {
	rm -f ~/.workdir && echo $PWD  > ~/.workdir
}

function workgo() {
	cd $(cat ~/.workdir)
}
