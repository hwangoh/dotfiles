" vim-sendtowindow - Operator for sending text to adjacent windows.
" Maintainer: Karolis Koncevičius (karolis.koncevicius@gmail.com)
" Website: https://github.com/KKPMW/vim-sendtowindow
" Modified by Hwan Goh (Hwan.Goh@gmail.com)


if exists("g:loaded_sendtowindow") || &compatible
  finish
endif
let g:loaded_sendtowindow = 1


function! s:SendToWindow(type, direction)

  " Storing original register and cursor position
  let s:saved_register_t = @t
  let s:saved_register = @@
  let s:saved_register_k = @k
  let s:saved_pos = getpos(".")

  " Obtain text
  if a:type == 'v' || a:type == 'V' || a:type == "\<C-V>"
    keepjumps normal! `<v`>"ty
    if a:type == 'V'
      let @@ = substitute(@@, '\n$', '', '')
    endif
    call setpos(".", getpos("'>"))
  elseif a:type ==# "char"
    keepjumps normal! `[v`]"ty
    call setpos(".", getpos("']"))
  elseif a:type ==# "line"
    keepjumps normal! `[V`]$"ty
    call setpos(".", getpos("']"))
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
    call setpos(".", s:saved_pos)
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

  " Position the cursor for the next action
  if a:type ==# "char"
    normal! l
  endif

  " Restore register
  let @t = s:saved_register_t
  let @@ = s:saved_register
  let @k = s:saved_register_k

endfunction


function! s:SendRight(type)
  call s:SendToWindow(a:type, 'l')
endfunction
function! s:SendLeft(type)
  call s:SendToWindow(a:type, 'h')
endfunction
function! s:SendUp(type)
  call s:SendToWindow(a:type, 'k')
endfunction
function! s:SendDown(type)
  call s:SendToWindow(a:type, 'j')
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

" Storing original register and cursor position
  let s:saved_register_t = @t
  let s:saved_pos = getpos(".")

  " Obtain text
  keepjumps normal! viw"ty

  " Go to the target split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    call setpos(".", s:saved_pos)
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

  " Recover cursor position
  call setpos(".", s:saved_pos)

  " Restoring original register
  let @t = s:saved_register_t

endfunction


function! s:SendVariableRight()
  call s:SendVariableToWindow('l')
endfunction
function! s:SendVariableLeft()
  call s:SendVariableToWindow('h')
endfunction
function! s:SendVariableUp()
  call s:SendVariableToWindow('k')
endfunction
function! s:SendVariableDown()
  call s:SendVariableToWindow('j')
endfunction


nnoremap <silent> <Plug>SendVariableRight :<C-U> call <SID>SendVariableRight()<CR>
nnoremap <silent> <Plug>SendVariableLeft  :<C-U> call <SID>SendVariableLeft()<CR>
nnoremap <silent> <Plug>SendVariableUp    :<C-U> call <SID>SendVariableUp()<CR>
nnoremap <silent> <Plug>SendVariableDown  :<C-U> call <SID>SendVariableDown()<CR>

"================================================================================
" Send marked section
function! s:SendMarkedSectionToWindow(direction)

  " Storing original register and cursor position
  let s:saved_register_t = @t
  let s:saved_register_k = @k
  let s:saved_pos = getpos(".")

  " Obtain wanted text
  keepjumps normal! `xV`z"ty

  " Go to the target split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    call setpos(".", s:saved_pos)
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

  " Recover cursor position
  call setpos(".", s:saved_pos)

  " Restoring original register
  let @t = s:saved_register_t
  let @k = s:saved_register_k

endfunction


function! s:SendMarkedSectionRight()
  call s:SendMarkedSectionToWindow('l')
endfunction
function! s:SendMarkedSectionLeft()
  call s:SendMarkedSectionToWindow('h')
endfunction
function! s:SendMarkedSectionUp()
  call s:SendMarkedSectionToWindow('k')
endfunction
function! s:SendMarkedSectionDown()
  call s:SendMarkedSectionToWindow('j')
endfunction


nnoremap <silent> <Plug>SendMarkedSectionRight :<C-U> call <SID>SendMarkedSectionRight()<CR>
nnoremap <silent> <Plug>SendMarkedSectionLeft  :<C-U> call <SID>SendMarkedSectionLeft()<CR>
nnoremap <silent> <Plug>SendMarkedSectionUp    :<C-U> call <SID>SendMarkedSectionUp()<CR>
nnoremap <silent> <Plug>SendMarkedSectionDown  :<C-U> call <SID>SendMarkedSectionDown()<CR>
