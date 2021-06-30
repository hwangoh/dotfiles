; =================================
; === Quality of Life Settings  ===
; =================================
; === Disable Windows Visual Effects ===
RegWrite, REG_DWORD, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects, AnimateMinMax, 2

; === Remapping Capslock to Esc ===
SetCapsLockState, alwaysoff
Capslock::Esc

; ====================
; === Key Bindings ===
; ====================
; 1. Any lines starting with ; are ignored
; 2. After changing this config file run script file "i3wm_windows_emulator.ahk"
; 3. Every line is in the format HOTKEY::ACTION

; === SYMBOLS ===
; !   <- Alt
; +   <- Shift
; ^   <- Ctrl
; #   <- Win
; For more, visit https://autohotkey.com/docs/Hotkeys.htm

; === Window Manipulation ===
#+q::quitWindow()
#f::toggleMaximize()
#m::#+Left
#j::#Down
#k::#Up
#h::#Left
#l::#Right

; === Windows Terminal ===
#Enter::openAndPositionTerminal()

; === File Explorer ===
#z::openAndPositionExplorer("\\wsl$\Ubuntu\home\hwangoh")
#+z::openAndPositionExplorer("C:\")

; === Desktop Navigation ===
#+c::createVirtualDesktop()
#+d::deleteVirtualDesktop()

#+1::switchDesktopByNumber(1)
#+2::switchDesktopByNumber(2)
#+3::switchDesktopByNumber(3)
#+4::switchDesktopByNumber(4)
#+5::switchDesktopByNumber(5)
#+6::switchDesktopByNumber(6)
#+7::switchDesktopByNumber(7)
#+8::switchDesktopByNumber(8)
#+9::switchDesktopByNumber(9)

#+Numpad1::switchDesktopByNumber(1)
#+Numpad2::switchDesktopByNumber(2)
#+Numpad3::switchDesktopByNumber(3)
#+Numpad4::switchDesktopByNumber(4)
#+Numpad5::switchDesktopByNumber(5)
#+Numpad6::switchDesktopByNumber(6)
#+Numpad7::switchDesktopByNumber(7)
#+Numpad8::switchDesktopByNumber(8)
#+Numpad9::switchDesktopByNumber(9)

;#+1::MoveCurrentWindowToDesktop(1)
;#+2::MoveCurrentWindowToDesktop(2)
;#+3::MoveCurrentWindowToDesktop(3)
;#+4::MoveCurrentWindowToDesktop(4)
;#+5::MoveCurrentWindowToDesktop(5)
;#+6::MoveCurrentWindowToDesktop(6)
;#+7::MoveCurrentWindowToDesktop(7)
;#+8::MoveCurrentWindowToDesktop(8)
;#+9::MoveCurrentWindowToDesktop(9)

;#+Numpad1::MoveCurrentWindowToDesktop(1)
;#+Numpad2::MoveCurrentWindowToDesktop(2)
;#+Numpad3::MoveCurrentWindowToDesktop(3)
;#+Numpad4::MoveCurrentWindowToDesktop(4)
;#+Numpad5::MoveCurrentWindowToDesktop(5)
;#+Numpad6::MoveCurrentWindowToDesktop(6)
;#+Numpad7::MoveCurrentWindowToDesktop(7)
;#+Numpad8::MoveCurrentWindowToDesktop(8)
;#+Numpad9::MoveCurrentWindowToDesktop(9)
