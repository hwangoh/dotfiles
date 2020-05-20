" =============================================================================
"                                   Plugins 
" =============================================================================	
" Specify a director for plugins
    call plug#begin('~/.vim/plugged')

" Plugins
    Plug 'https://github.com/tpope/vim-fugitive.git'
    Plug 'https://github.com/preservim/nerdtree.git'
    Plug 'https://github.com/vim-syntastic/syntastic.git'
    Plug 'https://github.com/edkolev/tmuxline.vim.git'
    Plug 'https://github.com/vim-airline/vim-airline.git'
    Plug 'https://github.com/vim-airline/vim-airline-themes.git'
    Plug 'https://github.com/tpope/vim-commentary.git'
    Plug 'https://github.com/octol/vim-cpp-enhanced-highlight.git'
    Plug 'https://github.com/tpope/vim-surround.git'
    Plug 'https://github.com/lervag/vimtex.git'
    Plug 'https://github.com/kshenoy/vim-signature.git'

" List ends here. Plugins become visible to Vim after this call
    call plug#end()

" =============================================================================
"                                General Settings 
" =============================================================================	
" Standard Stuff
    syntax on
    filetype plugin indent on
    set encoding=utf-8

" Quality of Life Stuff
    colorscheme apprentice 
    set backspace=indent,eol,start
    set noerrorbells
    set title
    set ruler
    set undolevels=1001
    set history=10000
    set number relativenumber
    set lines=62 columns=120
    set nostartofline
    set splitbelow splitright
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "Disable automatic comment
    
" Line Wrapping and Indentation
    set wrap
    set linebreak
    set tw=80
    set autoindent

" Search Options
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase

" Use 4 Spaces For Tabs
    set expandtab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set shiftround

" Disable swap and backup files (I save all the time)
    set nobackup
    set nowritebackup
    set noswapfile

" Spellcheck
    set spelllang=en_us

" Autocompletion using tab with menu
    set wildmenu
    set wildmode=longest,list,full

" Automatically set working directory to directory of current file 
    autocmd BufEnter * silent! lcd %:p:h

" This allows buffers to be hidden if you've modified a buffer
    set hidden

" =============================================================================
"                               General Mappings 
" =============================================================================	
" All up and down movements agnostic to text wrap type. Further, these follow relative numbers and treat wrapped lines as one line
    nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
    nnoremap <expr> <Up>   v:count == 0 ? 'gk' : 'k'
    nnoremap <expr> <Down> v:count == 0 ? 'gj' : 'j'

" Increase scrolling speed with <C-e> and <C-y>
    nnoremap J 4<C-e>
    nnoremap K 4<C-y>

" Join line below (default binding is J)
    nnoremap <c-j> J

" Break undo chain while in insert mode whenever a space, tab or new line is added
    inoremap <Space> <Space><c-g>u
    inoremap <Tab> <Tab><c-g>u
    inoremap <CR> <CR><c-g>u

" Shifting blocks of code selected in visual mode 
    xnoremap > >gv
    xnoremap < <gv

" Miscellaneous Remaps
    nnoremap ' `
    nnoremap Y y$

" <Enter> to Insert Line Below Without Entering Insert Mode
    nnoremap <silent> <Enter>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

" Toggle line numbers
    noremap <F1> :set invnumber invrelativenumber<CR>

" Toggle highlight 
    let hlstate=0
    noremap <F2> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>

" Toggle Spellcheck
    noremap <F3> :setlocal spell! spelllang=en_us<CR>

" Buffer Navigation
    noremap <F8> :bprev<CR>
    noremap <F9> :bnext<CR>
    noremap <Leader>b :ls<CR>:b<space>

" Yanks the inner word to the z registure and then performs a search in the whole buffer outputting number of appearances
    nnoremap <c-f> "zyiw:exe "%s/".@z."//gn"<CR>

" Begins command line for search and replace for the word under the cursor
    nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" Use \T to open terminal vertically on the right
    nnoremap <Leader>T :botright vertical terminal<CR>

" Use \R to reload vimrc
    nnoremap <Leader>R :source ~/.vimrc<CR>

" =============================================================================
"                                 sendtowindow 
" =============================================================================	
" Use own mappings for sendtowindow plugin
    let g:sendtowindow_use_defaults=0

" Primer for Vim motions. 
    nmap ,s <Plug>SendRight
    xmap ,s <Plug>SendRightV

" Text object full lines. With '_' alone the indentation is left intact and 'i_' is without indentation
    onoremap <silent> <expr> - v:count==0 ? ":<c-u>normal! 0V$h<cr>" : ":<c-u>normal! V" . (v:count) . "jk<cr>"
    vnoremap <silent> <expr> - v:count==0 ? ":<c-u>normal! 0V$h<cr>" : ":<c-u>normal! V" . (v:count) . "jk<cr>"
    onoremap <silent> <expr> i- v:count==0 ? ":<c-u>normal! ^vg_<cr>" : ":<c-u>normal! ^v" . (v:count) . "jkg_<cr>"
    vnoremap <silent> <expr> i- v:count==0 ? ":<c-u>normal! ^vg_<cr>" : ":<c-u>normal! ^v" . (v:count) . "jkg_h<cr>"

" =============================================================================
"                                   Slimux 
" =============================================================================	
" Key-bindings
    nnoremap ,- mq:SlimuxREPLSendLine<CR>`q
    vnoremap ,- :SlimuxREPLSendSelection<CR>
    nnoremap ,T :SlimuxShellRun 
    nnoremap ,l :SlimuxShellLast<CR>

" =============================================================================
"                                  Fuzzy Finder 
" =============================================================================	
" Search down into subfolders
" Provides tab-completion for all file-related tasks
    set path+=**

" Instructions
" - Use :find and type in a partial substring, then hit tab to search
" - Use * to make it fuzzy
" - :b lets you autocomplete any open buffer

" =============================================================================
"                                  Tag Jumping 
" =============================================================================	
" Might need to install ctags first: sudo apt-get install ctags

" Command to create the `tags' file 
    command! MakeTags !ctags -R .

" Instructions
" - Either use `:MakeTags' while in vim or `ctags -R .' while in directory.
"   This will create a file called `tags' in the directory.
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags. This will generate a list of possible matches you can jump to
" - Use ^t to jump back up the tag stack
" - This doesn't help if you want a visual list of tags

" =============================================================================
"                                    Sessions 
" =============================================================================	
" Sessions (note that sessions doesn't play well with NERDTree so need to add extra commands to close)
    :command! SStex :NERDTreeClose <bar> :mksession ~/.vim/vim_sessions/session_tex.vim <bar> :%bd! <bar> :q!
    :command! LStex :NERDTreeClose <bar> :source ~/.vim/vim_sessions/session_tex.vim <bar> :NERDTree

    :command! SSpy :NERDTreeClose <bar> :mksession! ~/.vim/vim_sessions/session_py.vim <bar> :%bd! <bar> :q!
    :command! LSpy :NERDTreeClose <bar> :source! ~/.vim/vim_sessions/session_py.vim <bar> :NERDTree
 
    :command! SSc :NERDTreeClose <bar> :mksession! ~/.vim/vim_sessions/session_c.vim <bar> :%bd! <bar> :q!
    :command! LSc :NERDTreeClose <bar> :source! ~/.vim/vim_sessions/session_c.vim <bar> :NERDTree

" =============================================================================
"                                   NERDTree 
" =============================================================================	
" Startup NERDTree automatically if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Prevent NERDTree from starting up again when session is reloaded
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

" Shortcut to toggle NERDTree on and off
    noremap <F12> :NERDTreeToggle<CR>

" Window Size
    let g:NERDTreeWinSize=60

" Relative Numbers on Startup 
    let NERDTreeShowLineNumbers=1
    autocmd FileType nerdtree setlocal relativenumber

" =============================================================================
"                                   Airline
" =============================================================================	
" Airline plugin buffers
    let g:airline#extensions#tabline#enabled = 1 "enable list of buffers
    let g:airline#extensions#tabline#fnamemod = ':t' "show just the file name
    let g:airline#extensions#tabline#buffer_nr_show = 1 "show buffer number

" Set default Airline theme
    let g:airline_theme='lucius'

" tmuxline plugin
    let g:airline#extensions#tmuxline#enabled = 1
    let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
    
" =============================================================================
"                                  Syntastic 
" =============================================================================	
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    let g:syntastic_quiet_messages = { "type": "style" }

" Start Syntastic in passive mode
    let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

" Mapping to start Syntastic
    nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" For toggling error window open and close
    noremap <F4> <ESC>:call SyntasticToggle()<CR>

    let g:syntastic_is_open = 0
    function! SyntasticToggle()
    if g:syntastic_is_open == 1
        lclose
        let g:syntastic_is_open = 0
    else
        Errors
        let g:syntastic_is_open = 1
    endif
    endfunction

" =============================================================================
"                            Cpp Enhanced Highlight 
" =============================================================================	
    let g:cpp_class_scope_highlight = 0
    let g:cpp_member_variable_highlight = 0
    let g:cpp_class_decl_highlight = 0
    let g:cpp_posix_standard = 0

" =============================================================================
"                                   Python 
" =============================================================================	
" Shortcut to open IPython in a terminal to the right
    nnoremap <leader>P :botright vertical terminal ipython --no-autoindent<CR><C-w><left>

" Shortcut for Running Python Code
    autocmd FileType python noremap <F6> <Esc>:w<CR>:!clear;python3  %<CR>
    autocmd FileType python inoremap <F6> <Esc>:w<CR>:!clear;python3 %<CR>

" Insert pdb.set_trace()
    autocmd FileType python inoremap ;pdb pdb.set_trace()

" Insert current file name
    autocmd FileType python inoremap ;F <C-R>=expand("%:t")<CR>

" sendtowindow commands: clear, reset, run variable, run marked section, run code
    autocmd FileType python nmap ,sC mqA<CR>clear<Esc>V,suu`qdmq
    autocmd FileType python nmap ,sD mqA<CR>%reset<Esc>V,suiy<Esc>v,suu`qdmq
    autocmd FileType python nmap ,sV mqviw,s`qdmq
    autocmd FileType python nmap ,sM mq'xV'z,s`qdmq
    autocmd FileType python nmap ,sR :w!<CR>mqA<CR>run ;F<Esc>V,suuu`qdmq

" Slimux commands:  clear, reset, run variable, run marked section, run code
    autocmd FileType python nnoremap ,C mq:SlimuxShellRun clear<CR>`qdmq
    autocmd FileType python nnoremap ,D mq:SlimuxShellRun %reset<CR>:SlimuxShellRun y<CR>`qdmq
    autocmd FileType python nmap ,V mqviw,-`qdmq
    autocmd FileType python nmap ,M mq'xV'z,-`qdmq
    autocmd FileType python nmap ,R :w!<CR>mqA<CR>run ;F<Esc>V,-uuu`qdmq

" =============================================================================
"                                    LaTeX
" =============================================================================	
" Use Zathura pdf viewer which enables forward and backward navigation between tex file and pdf. On MacOS, use skim
    if has('macunix')
        let g:vimtex_view_method = 'skim'
    else
        let g:vimtex_view_method = 'zathura'
    end

" Avoids opening an empty .tx file only to have vimtex recognize it as plain Tex rather than Latex
    let g:tex_flavor = 'latex'

" Use folding. Use zx to unfold and zX to fold all
    let g:vimtex_fold_enabled = 1

" Turn off autoindent when using Vimtex
    let g:latex_indent_enabled = 0

" Toggle Error Window On and Off
    autocmd FileType tex map <F4> \le

" Shortcut for Compiling and Viewing PDF
    autocmd FileType tex nnoremap <F5> :VimtexView<Enter>
    autocmd FileType tex inoremap <F5> <Esc> :VimtexView<Enter>
    autocmd FileType tex nnoremap <F6> :w! <bar> :VimtexCompileSS<Enter>
    autocmd FileType tex inoremap <F6> <Esc> :w! <bar> :VimtexCompileSS<Enter>

" VimtexClean on exit
  augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
  augroup END

" Section and Subsection
    autocmd FileType tex inoremap ;sec %===============================================================<Enter>\section{}<Enter>%===============================================================<Enter><++><Esc>2k0f}i
    autocmd FileType tex inoremap ;ssec %---------------------------------------------------------------<Enter>\subsection{}<Enter>%---------------------------------------------------------------   <Enter><++><Esc>2k0f}i

" Teleportation!
    autocmd FileType tex inoremap <Space><Space> <Esc>/<++><Enter>"_c4l

" Inline Stuff
    autocmd FileType tex inoremap ;mm $$<++><Esc>5ha
    autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;it \textit{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;bfs \boldsymbol{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;ct \cite{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;lb \label{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;rf \ref{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;erf (\ref{})<++><Esc>7hf}i

" Create Environments
    autocmd FileType tex inoremap ;itm \begin{itemize}<Enter><Enter>\end{itemize}<Enter><++><Esc>2kA\item<Space>
    autocmd FileType tex inoremap ;enu \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><++><Esc>2kA\item<Space>
    autocmd FileType tex inoremap ;aln \begin{align}<Enter><Enter>\end{align}<Enter><++><Esc>2kA
    autocmd FileType tex inoremap ;sub \begin{subequations}<Enter>\begin{align}<Enter><Enter>\end{align}<Enter>\end{subequations}<Enter><++><Esc>3kA<Tab>
    autocmd FileType tex inoremap ;mat \begin{bmatrix}<Enter><Enter>\end{bmatrix}<Enter><++><Esc>2kA
    autocmd FileType tex inoremap ;lst \begin{lstlisting}<Enter><Enter>\end{lstlisting}<Enter><++><Esc>2kA
    autocmd FileType tex inoremap ;fig \begin{figure}[H]<Enter>\centering<Enter>\includegraphics[scale=\figscale]{}<Enter>\caption{<++>}<Enter>\label{<++>}<Enter>\end{figure}<Enter><++><Esc>4kf}i

" Math Environments
    autocmd Filetype tex inoremap ;def \begin{definition}<Enter><Enter>\end{definition}<Enter><++><Esc>2kA
    autocmd Filetype tex inoremap ;thm \begin{theorem}<Enter><Enter>\end{theorem}<Enter><++><Esc>2kA
    autocmd Filetype tex inoremap ;lem \begin{lemma}<Enter><Enter>\end{lemma}<Enter><++><Esc>2kA
    autocmd Filetype tex inoremap ;cor \begin{corollary}<Enter><Enter>\end{corollary}<Enter><++><Esc>2kA
    autocmd Filetype tex inoremap ;prp \begin{proposition}<Enter><Enter>\end{proposition}<Enter><++><Esc>2kA
    autocmd Filetype tex inoremap ;prf \begin{proof}<Enter><Enter>\end{proof}<Esc>1kA

" Math Stuff
    autocmd Filetype tex inoremap ;T ^\mathrm{T}
    autocmd FileType tex inoremap ;sd _{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;su ^{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;frc \frac{}{<++>}<++><Esc>12hf}i
    autocmd FileType tex inoremap ;mbb \mathbb{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;mrm \mathrm{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;mcl \mathcal{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;lrp \left(\right)<++><Esc>12hf(a
    autocmd FileType tex inoremap ;lrs \left[\right]<++><Esc>12hf[a
    autocmd FileType tex inoremap ;lrn \left\lVert\right\rVert<++><Esc>15hi<Space>
    autocmd FileType tex inoremap ;lra \left\langle\right\rangle<++><Esc>16hi<Space>
    autocmd FileType tex inoremap ;lrc \left\{\right\}<++><Esc>13hf{a
    autocmd FileType tex inoremap ;lrb \left<Bar>\right<Bar><++><Esc>12hf<Bar>a
