# Rebinding capslock to escape
setxkbmap -option "caps:escape"

# Toggle suspended program
stty susp undef
bind '"\C-z":"fg\015"'

# Run ls immediately after cd
function cd {
    builtin cd "$@" && ls -F
}

# new latex templates:
function new_tex_simple() {
    cd ~/.vim/LaTeX_Templates/tex_template_simple
    ./new_tex "$1"
}

# vim server for vimtex:
function vtex() {
    vim --servername "$1" "$1"tex
}

# tmux new session
function newmux(){
    tmux new -s $1
}

# tmux attach session
function attmux(){
    tmux attach-session -t $1
}

# tmux kill session
function killmux(){
    tmux kill-session -t $1
}

# tmux session with vim and IPython:
function vpmux() {
    dir_name=$PWD # get path of current directory
    cd ~/.vim/tmux_sessions
    ./tmux_sess_vimipython "$1" "$dir_name"
    tmux attach -t $1
    cd $dir_name # return to current directory so you're there when session is detached
}

# Windows Client Server
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
