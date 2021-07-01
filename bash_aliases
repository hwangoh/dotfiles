# =============================================================================
#                               Morning Routine
# =============================================================================
alias web_browsers="google-chrome & firefox & exit"
alias morning_routine="google-chrome & firefox & quick_daily_update; exit"

alias Share_Trading="cd ~/Documents/Github_Codes/Share_Trading; bash"
alias quick_daily_update="cd ~/Documents/Work/Codes/Share_Trading; bash quick_daily_report"

# =============================================================================
#                               Configuration
# =============================================================================
# Vim
alias vrc="cd ~/.vim; vim vimrc"
alias LStex="vim -c LStex"
alias LSpy="vim -c LSpy"
alias LSc="vim -c LSc"

# tmux
alias lsmux="tmux ls"
alias killallmux="tmux kill-server"

alias texmux="tmux new -s tex"
alias cmux="tmux new -s c"
alias Ltexmux="tmux attach-session -t tex"
alias Lcmux="tmux attach-session -t c"

alias kpmux="cd ~/.vim/tmux_sessions; bash ./tmux_sess_KAUST"
alias Lkpmux="tmux attach-session -t KAUST"

# i3
alias i3c="cd ~/.vim; vim i3_config"

# =============================================================================
#                                   Other
# =============================================================================
alias rg="ranger"
alias pc="cd ~; ./pcloud &"
