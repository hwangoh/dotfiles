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
    colorscheme meditate
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

" Disable swap and backup files
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

" Allows you to switch between buffers without first saving the buffer
    set hidden

" Displays unprintable characters like indents and trailing white spaces
    set listchars=tab:•\ ,trail:•,extends:»,precedes:«

" Automatically remove all trailing whitespaces upon saving
    autocmd BufWritePre * %s/\s\+$//e

" Wipe register
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

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

" <CR> to Insert Line Below Without Entering Insert Mode
    nnoremap <silent> <CR>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

" Toggle line numbers
    noremap <F1> :set invnumber invrelativenumber<CR>

" Toggle highlight
    let hlstate=0
    noremap <F3> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>

" Buffer Navigation
    noremap <F8> <c-^>
    noremap <F9> :ls<CR>:b<space>

" Yanks the visually selected text to the " redister and then performs a serch command
    vnoremap <Leader>f y/\V<C-R>=escape(@",'/\')<CR><CR>

" Yanks the inner word to the z register and then performs a search in the whole buffer outputting number of appearances
    nnoremap <Leader>f "zyiw:exe "%s/".@z."//gn"<CR>

" Begins command line for search and replace for the word under the cursor
    nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" Toggle Spellcheck
    nnoremap <Leader>sp :setlocal spell! spelllang=en_us<CR>

" Toggle displaying unprintable characters
    nnoremap <Leader>tr :setlocal invlist<CR>

" Force save
    nnoremap <Leader>S :w!<CR>

" Closer buffer
    nnoremap <Leader>W :Bclose!<CR>

" Force quit
    nnoremap <Leader>Q :q!<CR>

" Open terminal vertically on the right
    nnoremap <Leader>T :botright vertical terminal<CR><c-w>h

" Cancel process on the terminal on the right
    nnoremap <Leader>C <c-w>l<c-c><c-w>h

" Exit terminal on the right and quit Vim window
    nnoremap <Leader>H <c-w>lexit<CR><c-w>q

" Reload vimrc
    nnoremap <Leader>R :source ~/.vimrc<CR>

" Text object full lines. With '-' the indentation is included and with 'i_' the indentation is excluded
    onoremap <silent> <expr> - v:count==0 ? ":<c-u>normal! 0vg_<CR>" : ":<c-u>normal! V" . (v:count) . "jk<CR>"
    vnoremap <silent> <expr> - v:count==0 ? ":<c-u>normal! 0vg_<CR>" : ":<c-u>normal! V" . (v:count) . "jk<CR>"
    onoremap <silent> <expr> i- v:count==0 ? ":<c-u>normal! ^vg_<CR>" : ":<c-u>normal! ^v" . (v:count) . "jkg_<CR>"
    vnoremap <silent> <expr> i- v:count==0 ? ":<c-u>normal! ^vg_<CR>" : ":<c-u>normal! ^v" . (v:count) . "jkg_<CR>"

" =============================================================================
"                                 sendtowindow
" =============================================================================
" Primer for Vim motions to select text to be sent
    nmap , <Plug>SendRight

" Send text selected in visual mode
    vmap ,s <Plug>SendRightV

" Send terminal commands
    nnoremap ,T :SendCommandToWindowRight<Space>
    nnoremap ,E :SendCommandToWindowRight exit<CR>

" =============================================================================
"                                   Slimux
" =============================================================================
" Primer for Vim motions to select text to be sent
    nmap ,t <Plug>SlimuxREPLSendWithMotion

" Send text selected in visual mode
    vnoremap ,t :SlimuxREPLSendSelection<CR>

" Send terminal commands
    nnoremap ,tX :SlimuxShellPrompt<CR>
    nnoremap ,tT :SlimuxShellRun<Space>
    nnoremap ,tE :SlimuxShellRun exit<CR>

" Send keys using the 'tmux send-keys' syntax
    nnoremap ,tK :SlimuxSendKeys<Space>
    nnoremap ,tC :SlimuxSendKeys<Space>c-c<CR>

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

" To check current folder for tags file and keep going one directory all the way to root folder
" so you can be in any sub-folder in your project and it'll be able to find the tags files
    set tags=tags;/

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
    autocmd FileType python,c,cpp noremap <F4> <ESC>:call SyntasticToggle()<CR>

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
"                                Signature
" =============================================================================
" Toggling marks on and off
    noremap <F2> :SignatureToggle<CR>

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
" Shortcut for Running Python Code
    autocmd FileType python noremap <F6> <Esc>:w<CR>:!clear;python3  %<CR>
    autocmd FileType python inoremap <F6> <Esc>:w<CR>:!clear;python3 %<CR>

" Reload IPython And Run Code
    autocmd FileType python nmap <Leader>p <Leader>H<Leader>P,R

" Insert pdb.set_trace()
    autocmd FileType python inoremap ;pdb pdb.set_trace()

" sendtowindow for IPython in Vim Terminal: IPython, clear, reset, run code, run variable, run marked section
    nnoremap <Leader>P :botright vertical terminal ipython --no-autoindent<CR><C-w><left>
    autocmd FileType python noremap ,L :SendCommandToWindowRight clear<CR>
    autocmd FileType python noremap ,D :SendCommandToWindowRight %reset -f<CR>
    autocmd FileType python noremap ,R :w!<CR>:SendCommandToWindowRight run <c-r>%<CR>
    autocmd FileType python nmap ,V <Plug>SendVariableRight
    autocmd FileType python nmap ,M <Plug>SendMarkedSectionRight

" Slimux for IPython in tmux terminal : IPython, clear, reset, run code, run variable, run marked section
    autocmd FileType python nnoremap ,tP :SlimuxShellRun ipython<CR>
    autocmd FileType python nnoremap ,tL :SlimuxShellRun clear<CR>
    autocmd FileType python nnoremap ,tD :SlimuxShellRun %reset -f<CR>
    autocmd FileType python nnoremap ,tR :w!<CR>:SlimuxShellRun run <c-r>%<CR>
    autocmd FileType python nmap ,tV <Plug>SlimuxREPLSendVariable
    autocmd FileType python nmap ,tM <Plug>SlimuxREPLSendMarkedSection

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
    let g:vimtex_fold_enabled = 0

" Turn off autoindent when using Vimtex
    let g:latex_indent_enabled = 0

" Toggle Error Window On and Off
    autocmd FileType tex map <F4> \le

" Shortcut for Compiling and Viewing PDF
    autocmd FileType tex nnoremap <F5> :VimtexView<CR>
    autocmd FileType tex inoremap <F5> <Esc> :VimtexView<CR>
    autocmd FileType tex nnoremap <F6> :w! <bar> :VimtexCompileSS<CR>
    autocmd FileType tex inoremap <F6> <Esc> :w! <bar> :VimtexCompileSS<CR>

" VimtexClean on exit
  augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
  augroup END

" Section and Subsection
    autocmd FileType tex inoremap ;sec %==============================================================================<CR>\section{}<CR>%==============================================================================<CR><++><Esc>2k0f}i
    autocmd FileType tex inoremap ;ssec %------------------------------------------------------------------------------<CR>\subsection{}<CR>%------------------------------------------------------------------------------   <CR><++><Esc>2k0f}i

" Teleportation!
    autocmd FileType tex inoremap <Space><Space> <Esc>/<++><CR>"_c4l

" Inline Stuff
    autocmd FileType tex inoremap ;mm $$<++><Esc>5ha
    autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;it \textit{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;em \emph{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;bfs \boldsymbol{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;ct \cite{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;lb \label{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;rf \ref{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;erf (\ref{})<++><Esc>7hf}i

" Environments
    autocmd FileType tex inoremap ;itm \begin{itemize}<CR><CR>\end{itemize}<CR><++><Esc>2kA\item<Space>
    autocmd FileType tex inoremap ;enu \begin{enumerate}<CR><CR>\end{enumerate}<CR><++><Esc>2kA\item<Space>
    autocmd FileType tex inoremap ;aln \begin{align}<CR><CR>\end{align}<CR><++><Esc>2kA
    autocmd FileType tex inoremap ;sub \begin{subequations}<CR>\begin{align}<CR><CR>\end{align}<CR>\end{subequations}<CR><++><Esc>3kA<Tab>
    autocmd FileType tex inoremap ;mat \begin{bmatrix}<CR><CR>\end{bmatrix}<CR><++><Esc>2kA
    autocmd FileType tex inoremap ;cas \begin{cases}<CR><CR>\end{cases}<CR><++><Esc>2kA
    autocmd FileType tex inoremap ;lst \begin{lstlisting}<CR><CR>\end{lstlisting}<CR><++><Esc>2kA
    autocmd FileType tex inoremap ;fig \begin{figure}[H]<CR>\centering<CR>\includegraphics[scale=\figscale]{}<CR>\caption{<++>}<CR>\label{<++>}<CR>\end{figure}<CR><++><Esc>4kf}i

" Math Environments
    autocmd Filetype tex inoremap ;def \begin{definition}<CR><CR>\end{definition}<CR><++><Esc>2kA
    autocmd Filetype tex inoremap ;thm \begin{theorem}<CR><CR>\end{theorem}<CR><++><Esc>2kA
    autocmd Filetype tex inoremap ;lem \begin{lemma}<CR><CR>\end{lemma}<CR><++><Esc>2kA
    autocmd Filetype tex inoremap ;cor \begin{corollary}<CR><CR>\end{corollary}<CR><++><Esc>2kA
    autocmd Filetype tex inoremap ;prp \begin{proposition}<CR><CR>\end{proposition}<CR><++><Esc>2kA

" Math Stuff
    autocmd Filetype tex inoremap ;T ^\mathrm{T}
    autocmd FileType tex inoremap ;sd _{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;su ^{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;frc \frac{}{<++>}<++><Esc>12hf}i
    autocmd FileType tex inoremap ;mbb \mathbb{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;mrm \mathrm{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;txt \textrm{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;mcl \mathcal{}<++><Esc>6hf}i
    autocmd FileType tex inoremap ;lrp \left(<CR><CR>\right)<CR><++><Esc>2kA<Tab>
    autocmd FileType tex inoremap ;lrs \left[<CR><CR>\right]<CR><++><Esc>2kA<Tab>
    autocmd FileType tex inoremap ;lrn \left\lVert<CR><CR>\right\rVert<CR><++><Esc>2kA<Tab>
    autocmd FileType tex inoremap ;lra \left\langle<CR><CR>\right\rangle<CR><++><Esc>2kA<Tab>
    autocmd FileType tex inoremap ;lrc \left\{<CR><CR>\right\}<CR><++><Esc>2kA<Tab>
    autocmd FileType tex inoremap ;lrb \left<Bar><CR><CR>\right<Bar><CR><++><Esc>2kA<Tab>
