" vim-sendtowindow - Operator for sending text to adjacent windows.
" Maintainer: Karolis Koncevičius (karolis.koncevicius@gmail.com)
" Website: https://github.com/KKPMW/vim-sendtowindow


if exists("g:loaded_sendtowindow") || &compatible
  finish
endif
let g:loaded_sendtowindow = 1


function! s:SendToWindow(type, direction)

  let s:saved_register = @@
  let s:saved_registerK = @k
  let s:saved_pos = getpos(".")

  " Obtain wanted text
  if a:type == 'v' || a:type == 'V' || a:type == "\<C-V>"
    keepjumps normal! `<v`>y
    if a:type == 'V'
      let @@ = substitute(@@, '\n$', '', '')
    endif
    call setpos(".", getpos("'>"))
  elseif a:type ==# "char"
    keepjumps normal! `[v`]y
    call setpos(".", getpos("']"))
  elseif a:type ==# "line"
    keepjumps normal! `[V`]$y
    call setpos(".", getpos("']"))
  endif

  " Was the cursor at the end of line?
  let s:endofline = 0
  if col(".") >=# col("$")-1
    let s:endofline = 1
  endif

  " Go to the wanted split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    call setpos(".", s:saved_pos)
    return
  endif

  " Insert text and ammend end of line charater based on buffer type
  if &buftype ==# "terminal"
    let @k = "\r"
    if has('nvim')
      normal! gp
      normal! "kp
    else
      call term_sendkeys('', @0)
      call term_sendkeys('', "\r")
    endif
  elseif s:endofline
    normal! gp
    let @k = "\n"
    normal! "kp
  else
    normal! gp
  endif
  wincmd p

  " Position the cursor for the next action
  if s:endofline
    normal! j0
  elseif a:type ==# "char"
    normal! l
  endif

  " Restore register
  let @@ = s:saved_register
  let @k = s:saved_registerK

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
" Send specific text
function! s:SendTextToTerminal(text,direction)

  let s:saved_registerK = @k

  " Was the cursor at the end of line?
  let s:endofline = 0
  if col(".") >=# col("$")-1
    let s:endofline = 1
  endif

  " Go to the wanted split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    return
  endif

  " Insert text and ammend end of line charater based on buffer type
  if &buftype ==# "terminal"
    let @k = "\r"
    call term_sendkeys('', a:text)
    call term_sendkeys('', "\r")
  else
    echom "Not a terminal window!"
  endif
  wincmd p

  " Restore register
  let @k = s:saved_registerK

endfunction

function! SendTextToTerminalRight(text)
  call s:SendTextToTerminal(a:text, 'l')
endfunction
function! SendTextToTerminalLeft(text)
  call s:SendTextToTerminal(a:text, 'h')
endfunction
function! SendTextToTerminalUp(text)
  call s:SendTextToTerminal(a:text, 'k')
endfunction
function! SendTextToTerminalDown(text)
  call s:SendTextToTerminal(a:text, 'j')
endfunction

"================================================================================
"Sent Variable
function! s:SendVariableToWindow(direction)

  let s:saved_registerK = @k
  let s:saved_pos = getpos(".")

  " Obtain wanted text
  keepjumps normal! viwy

  " Was the cursor at the end of line?
  let s:endofline = 0
  if col(".") >=# col("$")-1
    let s:endofline = 1
  endif

  " Go to the wanted split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    call setpos(".", s:saved_pos)
    return
  endif

  " Insert text and ammend end of line charater based on buffer type
  if &buftype ==# "terminal"
    let @k = "\r"
    call term_sendkeys('', @0)
    call term_sendkeys('', "\r")
  elseif s:endofline
    normal! gp
    let @k = "\n"
    normal! "kp
  else
    normal! gp
  endif
  wincmd p

  " Recover cursor position
  call setpos(".", s:saved_pos)

  " Restore register
  let @k = s:saved_registerK

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

  let s:saved_registerK = @k
  let s:saved_pos = getpos(".")

  " Obtain wanted text
  keepjumps normal! `xV`zy

  " Was the cursor at the end of line?
  let s:endofline = 0
  if col(".") >=# col("$")-1
    let s:endofline = 1
  endif

  " Go to the wanted split
  let s:winnr = winnr()
  execute "wincmd " . a:direction
  if winnr() == s:winnr
    echom "No window in selected direction!"
    call setpos(".", s:saved_pos)
    return
  endif

  " Insert text and ammend end of line charater based on buffer type
  if &buftype ==# "terminal"
    let @k = "\r"
    call term_sendkeys('', @0)
    call term_sendkeys('', "\r")
  elseif s:endofline
    normal! gp
    let @k = "\n"
    normal! "kp
  else
    normal! gp
  endif
  wincmd p

  " Recover cursor position
  call setpos(".", s:saved_pos)

  " Restore register
  let @k = s:saved_registerK

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
