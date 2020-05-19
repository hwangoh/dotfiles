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

# vim server for vintex shortcut:
function vtex() {
    vim --servername "$1" "$1"tex
}
