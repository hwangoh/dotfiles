; Makes the mouse cursor follow window focus, but ONLY if the focus change
; wasn't caused by the mouse - e.g. Alt-Tab, Win+<Number>, hotkeys, ...
; Saves a lot of mousing around on multi-monitor setups!

Gui +LastFound

lastMouseClickTime := 0
hWnd := WinExist()

DllCall("RegisterShellHookWindow", UInt, hWnd)
msgNum := DllCall("RegisterWindowMessage", Str, "SHELLHOOK")
OnMessage(msgNum, "OnShellMessage")
OnMessage(WM_MOUSEMOVE:=0x0201, "OnMouseDown")
Return

OnShellMessage( wParam, lParam )
{
	global
	; HSHELL_WINDOWACTIVATED | HSHELL_RUDEAPPACTIVATED
	If (wParam = 4 or wParam = 32772) {
		; ignore when dragging
		GetKeyState, mouseDown, LButton
		if (mouseDown <> "D" and A_TickCount - lastMouseClickTime > 500) {
			; delay a tiny bit to ignore taskbar focus on Win+Number switching
			Sleep, 10
			CoordMode, Mouse, Screen
			WinGetPos, wx, wy, width, height, A

			; puts the cursor in the upper right corner of the active window, tweak to your needs
			mx := Round(wx + width * 0.5)
			my := Round(wy + height * 0.5)

			DllCall("SetCursorPos", int, mx, int, my)
		}
	}
}

*~LButton::
	lastMouseClickTime := A_TickCount
Return

*~RButton::
	lastMouseClickTime := A_TickCount
Return

*~MButton::
	lastMouseClickTime := A_TickCount
Return
