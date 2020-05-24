" vim-sendtowindow - Operator for sending text to adjacent windows.
" Maintainer: Karolis Koncevičius (karolis.koncevicius@gmail.com)
" Website: https://github.com/KKPMW/vim-sendtowindow
" Modified by Hwan Goh (Hwan.Goh@gmail.com)


if exists("g:loaded_sendtowindow") || &compatible
  finish
endif
let g:loaded_sendtowindow = 1


function! s:SendToWindow(type, direction)

  " Storing original register
  let s:saved_register_t = @t
  let s:saved_register = @@
  let s:saved_register_k = @k

  " Obtain text
  if a:type == 'v' || a:type == 'V' || a:type == "\<C-V>"
    keepjumps normal! `<v`>"ty
    if a:type == 'V'
      let @@ = substitute(@@, '\n$', '', '')
    endif
  elseif a:type ==# "char"
    keepjumps normal! `[v`]"ty
  elseif a:type ==# "line"
    keepjumps normal! `[V`]$"ty
  endif

  " Was the cursor at the end of line?
  let s:endofline = 0
  if col(".") >=# col("$")-1
    let s:endofline = 1
  endif

  " Go to the target split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    return
  endif

  " Insert text and amend end of line charater based on buffer type
  if &buftype ==# "terminal"
    call term_sendkeys('', @t)
    call term_sendkeys('', "\r")
  elseif s:endofline
    normal! gp
    let @k = "\n"
    normal! "kp
  else
    normal! gp
  endif
  wincmd p

  " Restore register
  let @t = s:saved_register_t
  let @@ = s:saved_register
  let @k = s:saved_register_k

endfunction


function! s:SendRight(type)
  let s:saved_pos = getpos(".")
  call s:SendToWindow(a:type, 'l')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendLeft(type)
  let s:saved_pos = getpos(".")
  call s:SendToWindow(a:type, 'h')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendUp(type)
  let s:saved_pos = getpos(".")
  call s:SendToWindow(a:type, 'k')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendDown(type)
  let s:saved_pos = getpos(".")
  call s:SendToWindow(a:type, 'j')
  call setpos(".", s:saved_pos)
endfunction


nnoremap <silent> <Plug>SendRight :<C-U> set operatorfunc=<SID>SendRight<CR>g@
nnoremap <silent> <Plug>SendLeft  :<C-U> set operatorfunc=<SID>SendLeft<CR>g@
nnoremap <silent> <Plug>SendUp    :<C-U> set operatorfunc=<SID>SendUp<CR>g@
nnoremap <silent> <Plug>SendDown  :<C-U> set operatorfunc=<SID>SendDown<CR>g@

vnoremap <silent> <Plug>SendRightV :<C-U> call <SID>SendRight(visualmode())<CR>
vnoremap <silent> <Plug>SendLeftV  :<C-U> call <SID>SendLeft(visualmode())<CR>
vnoremap <silent> <Plug>SendUpV    :<C-U> call <SID>SendUp(visualmode())<CR>
vnoremap <silent> <Plug>SendDownV  :<C-U> call <SID>SendDown(visualmode())<CR>

"================================================================================
" Send Command
function! s:SendCommandToWindow(cmd,direction)

  " Storing original register
  let s:saved_register_t = @t

  " Adding cmd to register
  let @t = a:cmd

  " Go to the target split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    return
  endif

  " Insert text and amend end of line charater based on buffer type
  if &buftype ==# "terminal"
    call term_sendkeys('', @t)
    call term_sendkeys('', "\r")
  else
    normal! "tgp
  endif
  wincmd p

  " Restoring original register
  let @t = s:saved_register_t

endfunction


function! s:SendCommand(cmd,direction)
  call s:SendCommandToWindow(a:cmd,a:direction)
endfunction


command! -nargs=1 -complete=shellcmd SendCommandToWindowRight call s:SendCommand("<args>",'l')
command! -nargs=1 -complete=shellcmd SendCommandToWindowLeft call s:SendCommand("<args>",'l')
command! -nargs=1 -complete=shellcmd SendCommandToWindowUp call s:SendCommand("<args>",'l')
command! -nargs=1 -complete=shellcmd SendCommandToWindowDown call s:SendCommand("<args>",'l')

"================================================================================
"Send Variable
function! s:SendVariableToWindow(direction)

" Storing original register
  let s:saved_register_t = @t

  " Obtain text
  keepjumps normal! viw"ty

  " Go to the target split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    return
  endif

  " Insert text and amend end of line charater based on buffer type
  if &buftype ==# "terminal"
    call term_sendkeys('', @t)
    call term_sendkeys('', "\r")
  else
    normal! gp
  endif
  wincmd p

  " Restoring original register
  let @t = s:saved_register_t

endfunction


function! s:SendVariableRight()
  let s:saved_pos = getpos(".")
  call s:SendVariableToWindow('l')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendVariableLeft()
  let s:saved_pos = getpos(".")
  call s:SendVariableToWindow('h')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendVariableUp()
  let s:saved_pos = getpos(".")
  call s:SendVariableToWindow('k')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendVariableDown()
  let s:saved_pos = getpos(".")
  call s:SendVariableToWindow('j')
  call setpos(".", s:saved_pos)
endfunction


nnoremap <silent> <Plug>SendVariableRight :<C-U> call <SID>SendVariableRight()<CR>
nnoremap <silent> <Plug>SendVariableLeft  :<C-U> call <SID>SendVariableLeft()<CR>
nnoremap <silent> <Plug>SendVariableUp    :<C-U> call <SID>SendVariableUp()<CR>
nnoremap <silent> <Plug>SendVariableDown  :<C-U> call <SID>SendVariableDown()<CR>

"================================================================================
" Send marked section
function! s:SendMarkedSectionToWindow(direction)

  " Storing original register
  let s:saved_register_t = @t
  let s:saved_register_k = @k

  " Obtain wanted text
  keepjumps normal! `xV`z"ty

  " Go to the target split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    return
  endif

  " Insert text and amend end of line charater based on buffer type
  if &buftype ==# "terminal"
    call term_sendkeys('', @t)
    call term_sendkeys('', "\r")
  else
    normal! gp
    let @k = "\n"
    normal! "kp
  endif
  wincmd p

  " Restoring original register
  let @t = s:saved_register_t
  let @k = s:saved_register_k

endfunction


function! s:SendMarkedSectionRight()
  let s:saved_pos = getpos(".")
  call s:SendMarkedSectionToWindow('l')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendMarkedSectionLeft()
  let s:saved_pos = getpos(".")
  call s:SendMarkedSectionToWindow('h')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendMarkedSectionUp()
  let s:saved_pos = getpos(".")
  call s:SendMarkedSectionToWindow('k')
  call setpos(".", s:saved_pos)
endfunction
function! s:SendMarkedSectionDown()
  let s:saved_pos = getpos(".")
  call s:SendMarkedSectionToWindow('j')
  call setpos(".", s:saved_pos)
endfunction


nnoremap <silent> <Plug>SendMarkedSectionRight :<C-U> call <SID>SendMarkedSectionRight()<CR>
nnoremap <silent> <Plug>SendMarkedSectionLeft  :<C-U> call <SID>SendMarkedSectionLeft()<CR>
nnoremap <silent> <Plug>SendMarkedSectionUp    :<C-U> call <SID>SendMarkedSectionUp()<CR>
nnoremap <silent> <Plug>SendMarkedSectionDown  :<C-U> call <SID>SendMarkedSectionDown()<CR>
