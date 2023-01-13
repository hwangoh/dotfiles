" =============================================================================
"                                   Plugins
" =============================================================================
" Specify a director for plugins
    call plug#begin('~/.vim/plugged')

" Plugins
    Plug 'https://github.com/lervag/vimtex.git'
    Plug 'https://github.com/lambdalisue/fern.vim.git'
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clang-completer'}
    Plug 'https://github.com/vim-syntastic/syntastic.git'
    Plug 'https://github.com/vim-airline/vim-airline.git'
    Plug 'https://github.com/vim-airline/vim-airline-themes.git'
    Plug 'https://github.com/tpope/vim-fugitive.git'
    Plug 'https://github.com/tpope/vim-commentary.git'
    Plug 'https://github.com/tpope/vim-surround.git'
    Plug 'https://github.com/kshenoy/vim-signature.git'
    Plug 'https://github.com/edkolev/tmuxline.vim.git'
    Plug 'https://github.com/leafgarland/typescript-vim'
    Plug 'https://github.com/octol/vim-cpp-enhanced-highlight.git'

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
    " set lines=62 columns=120
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

" Navigate List
    nnoremap <Leader>e :lnext<CR>
    nnoremap <Leader>w :lprevious<CR>

" <CR> to Insert Line Below Without Entering Insert Mode
    nnoremap <silent> <CR>  :<c-u>put =repeat([''],v:count)<bar>'[-1<CR>

" Toggle line numbers
    noremap <F1> :set invnumber invrelativenumber<CR>

" Set no relative line numbers
    nnoremap <F2> :set norelativenumber!<CR>

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
    " nnoremap <Leader>R :source ~/.vimrc<CR>
    nnoremap <Leader>R :source ~/.vim/vimrc<CR>

" Text object full lines. With '-' the indentation is included and with 'i_' the indentation is excluded
    onoremap <silent> <expr> - v:count==0 ? ":<c-u>normal! 0vg_<CR>" : ":<c-u>normal! V" . (v:count) . "jk<CR>"
    vnoremap <silent> <expr> - v:count==0 ? ":<c-u>normal! 0vg_<CR>" : ":<c-u>normal! V" . (v:count) . "jk<CR>"
    onoremap <silent> <expr> i- v:count==0 ? ":<c-u>normal! ^vg_<CR>" : ":<c-u>normal! ^v" . (v:count) . "jkg_<CR>"
    vnoremap <silent> <expr> i- v:count==0 ? ":<c-u>normal! ^vg_<CR>" : ":<c-u>normal! ^v" . (v:count) . "jkg_<CR>"

" =============================================================================
"                                     Fern
" =============================================================================
" Use custom settings and mappings
    let g:fern#disable_default_mappings = 1
    let g:fern_disable_startup_warnings = 1

" Shortcut to toggle drawer open and closed
    noremap <silent> <F12> :Fern . -reveal=% -drawer -toggle -width=35<CR>

" File manipulation mappings
    function! s:init_fern() abort
        nmap <buffer> <Plug>(fern-my-open-and-stay) <Plug>(fern-action-open:select)<C-w><C-p>
        nmap <buffer><expr>
                \ <Plug>(fern-my-open-expand-and-stay)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-my-open-and-stay)",
                \   "\<Plug>(fern-action-expand)",
                \ )
        nmap <buffer><expr>
                \ <Plug>(fern-my-collapse-or-leave)
                \ fern#smart#drawer(
                \   "\<Plug>(fern-action-collapse)",
                \   "\<Plug>(fern-action-leave)",
                \ )
        nmap <buffer> l <Plug>(fern-my-open-expand-and-stay)
        nmap <buffer> h <Plug>(fern-my-collapse-or-leave)

        nnoremap <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
        nmap <buffer><silent> <Plug>(fern-action-open-and-close)
            \ <Plug>(fern-action-open:select)
            \ <Plug>(fern-close-drawer)
        nmap <buffer><nowait> L <Plug>(fern-action-open-and-close)
        nmap <buffer><nowait> H <Plug>(fern-action-leave)

        nmap <buffer><silent> <Plug>(fern-action-opensplit-and-close)
            \ <Plug>(fern-action-open:split)
            \ <Plug>(fern-close-drawer)
        nmap <buffer><silent> <Plug>(fern-action-openvsplit-and-close)
            \ <Plug>(fern-action-open:vsplit)
            \ <Plug>(fern-close-drawer)
        nmap <buffer> b <Plug>(fern-action-opensplit-and-close)
        nmap <buffer> v <Plug>(fern-action-openvsplit-and-close)

        nmap <buffer> R <Plug>(fern-action-reload)
        nmap <buffer> mv <Plug>(fern-action-move)
        nmap <buffer> cp <Plug>(fern-action-copy)
        nmap <buffer> rn <Plug>(fern-action-rename)
        nmap <buffer> rm <Plug>(fern-action-remove)
        nmap <buffer> tc <Plug>(fern-action-new-file)
        nmap <buffer> mk <Plug>(fern-action-new-dir)
        nmap <buffer> I <Plug>(fern-action-hidden:toggle)
        nmap <buffer> n <Plug>(fern-action-new-path)
    endfunction

    augroup fern-custom
        autocmd! *
        autocmd FileType fern call s:init_fern()
    augroup END

" =============================================================================
"                               You Complete Me
" =============================================================================
" Turn off automatic summoning of completion and semantic suggestions
    let g:ycm_auto_trigger = 0

" Completion Pop-Up Settings
    set pumheight=10
    set completeopt-=popup
    set previewpopup=height:10,width:60,highlight:PMenuSbar
    set completepopup=height:15,width:60,border:off,highlight:PMenuSbar
    let g:ycm_max_num_candidates = 50
    let g:ycm_max_num_identifier_candidates = 10

" Disable preview at bottom of terminal when using completion
    set completeopt-=preview
    let g:ycm_add_preview_to_completeopt = 0

" If using preview, close window after using a selection
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_autoclose_preview_window_after_completion = 1

" Disable summoning of documentation when hovering
    let g:ycm_auto_hover = ''

" Diagnostics UI settings
    let g:ycm_show_diagnostics_ui = 1
    let g:ycm_enable_diagnostic_signs = 1
    let g:ycm_enable_diagnostic_highlighting = 1
    let g:ycm_echo_current_diagnostic = 1
    let g:ycm_update_diagnostics_in_insert_mode = 0
    let g:ycm_always_populate_location_list = 1

" Commands to control completion pop up
    let g:ycm_key_invoke_completion = '<C-Space>'
    let g:ycm_key_list_stop_completion = ['<C-c>']

" Python Settings
    let g:ycm_python_interpreter_path = ''
    let g:ycm_python_sys_path = []
    let g:ycm_extra_conf_vim_data = [
    \  'g:ycm_python_interpreter_path',
    \  'g:ycm_python_sys_path'
    \]
    let g:ycm_global_ycm_extra_conf = '~/.vim/plugin/YouCompleteMe/global_extra_conf.py'

" Open Search
    nmap <Leader>Z <plug>(YCMFindSymbolInWorkspace)

" Instead of triggering after hovering, summon documentation using a command
    nmap <Leader>D <plug>(YCMHover)

" Use FixIt
    nmap <Leader>F :YcmCompleter FixIt<CR>

" Jumps
    nnoremap <Leader>G :YcmCompleter GoTo<CR>
    autocmd FileType python nnoremap <Leader>G :YcmCompleter GoToType<CR>
    nnoremap <Leader>gd :YcmCompleter GoToDefinition<CR>
    nnoremap <Leader>gy :YcmCompleter GoToType<CR>
    nnoremap <Leader>gi :YcmCompleter GoToImplementation<CR>
    nnoremap <Leader>gs :YcmCompleter GoToSymbol<CR>
    nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>

" For toggling error location list open and close
    noremap <F4> <ESC>:call YouCompleteMeWindowToggle()<CR>

    let g:ycm_is_open = 0
    function! YouCompleteMeWindowToggle()
    if g:ycm_is_open == 1
        lclose
        let g:ycm_is_open = 0
    else
        lopen
        let g:ycm_is_open = 1
    endif
    endfunction

" =============================================================================
"                                  Syntastic
" =============================================================================
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

" Always populate to error window
    let g:syntastic_always_populate_loc_list = 1

" Error window automated behaviour (can be set to 0,1,2,3; see docs for more details)
    let g:syntastic_auto_loc_list = 0

" Automatically check when buffer is open
    let g:syntastic_check_on_open = 1

" Echo error on command line
    let g:syntastic_echo_current_error = 1

" Run check when saving and closing
    let g:syntastic_check_on_wq = 0

" Which errors or warnings to suppress
    let g:syntastic_quiet_messages = { "type": "style" }

" Start Syntastic in passive mode
    let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [],'passive_filetypes': ["tex"] }

" Mapping to toggle Syntastic mode
    autocmd FileType python nnoremap <Leader>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" For toggling error location list open and close
    autocmd FileType python noremap <F4> <ESC>:call SyntasticWindowToggle()<CR>

    let g:syntastic_is_open = 0
    function! SyntasticWindowToggle()
    if g:syntastic_is_open == 1
        lclose
        let g:syntastic_is_open = 0
    else
        lopen
        let g:syntastic_is_open = 1
    endif
    endfunction

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
    autocmd FileType python noremap <F6> <Esc>:w<CR>:!clear;python3 %<CR>
    autocmd FileType python inoremap <F6> <Esc>:w<CR>:!clear;python3 %<CR>

" Insert pdb.set_trace()
    autocmd FileType python inoremap ;pdb pdb.set_trace()

" sendtowindow for IPython in Vim Terminal: IPython, clear, reset, run code, run variable, run marked section
    nnoremap <Leader>P :botright vertical terminal ipython --no-autoindent<CR><c-w>h
    autocmd FileType python noremap ,L :SendCommandToWindowRight clear<CR>
    autocmd FileType python noremap ,D :SendCommandToWindowRight %reset -f<CR>
    autocmd FileType python noremap ,R :w!<CR>:SendCommandToWindowRight run <c-r>%<CR>
    autocmd FileType python nmap ,V <Plug>SendVariableRight
    autocmd FileType python nmap ,M <Plug>SendMarkedSectionRight

" Reload IPython And Run Code
    autocmd FileType python nmap <Leader>p <Leader>H<Leader>P,R

" sendtowindow Docker Compose for Vim Terminal: yank build and run command to 'b' and 'r' registry first
    autocmd FileType python nmap ,C :w!<CR>:SendCommandToWindowRight <c-r>c<CR>

" Slimux for IPython in tmux terminal : IPython, clear, reset, run code, run variable, run marked section
    autocmd FileType python nnoremap ,tP :SlimuxShellRun ipython<CR>
    autocmd FileType python nnoremap ,tL :SlimuxShellRun clear<CR>
    autocmd FileType python nnoremap ,tD :SlimuxShellRun %reset -f<CR>
    autocmd FileType python nnoremap ,tR :w!<CR>:SlimuxShellRun run <c-r>%<CR>
    autocmd FileType python nmap ,tV <Plug>SlimuxREPLSendVariable
    autocmd FileType python nmap ,tM <Plug>SlimuxREPLSendMarkedSection

" =============================================================================
"                                    Webdev
" =============================================================================
    autocmd FileType html,javascript,javascriptreact,typescript,typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2

" =============================================================================
"                                    VimTex
" =============================================================================
" Use Zathura pdf viewer which enables forward and backward navigation between tex file and pdf
    let g:vimtex_view_method = 'zathura'

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

" =============================================================================
"                                   Sessions
" =============================================================================
" Sessions (note that sessions doesn't play well with NERDTree so need to add extra commands to close)
    :command! SStex :NERDTreeClose <bar> :mksession ~/.vim/vim_sessions/session_tex.vim <bar> :%bd! <bar> :q!
    :command! LStex :NERDTreeClose <bar> :source ~/.vim/vim_sessions/session_tex.vim <bar> :NERDTree

    :command! SSpy :NERDTreeClose <bar> :mksession! ~/.vim/vim_sessions/session_py.vim <bar> :%bd! <bar> :q!
    :command! LSpy :NERDTreeClose <bar> :source! ~/.vim/vim_sessions/session_py.vim <bar> :NERDTree

    :command! SSc :NERDTreeClose <bar> :mksession! ~/.vim/vim_sessions/session_c.vim <bar> :%bd! <bar> :q!
    :command! LSc :NERDTreeClose <bar> :source! ~/.vim/vim_sessions/session_c.vim <bar> :NERDTree

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

