# Rebinding capslock to escape
setxkbmap -option "caps:escape"

# new latex templates:
function new_tex_simple() {
    cd ~/.vim/LaTeX_Templates/tex_template_simple
    ./new_tex "$1"
}

function new_tex_siam() {
    cd ~/.vim/LaTeX_Templates/tex_template_siam
    ./new_tex "$1"
}

# vim server for vimtex:
function vtex() {
    vim --servername "$1" "$1"tex
}

# tmux session with vim and IPython:
function vpmux() {
    dir_name=$PWD # get path of current directory
    cd ~/.vim/tmux_sessions
    ./tmux_sess_vimipython "$1" "$dir_name"
    tmux attach -t $1
    cd $dir_name # return to current directory so you're there when session is detached
}
