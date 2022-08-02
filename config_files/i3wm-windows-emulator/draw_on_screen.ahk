;source: https://autohotkey.com/board/topic/28662-drawing-on-screen/
#SingleInstance,Force
CoordMode, Mouse, Screen

Black    = 000000
Green    = 008000
White    = FFFFFF
Yellow   = FFFF00
Red      = FF0000
Blue     = 0000FF
Eraser   = FFE7E0 ;some random color to be made transparent in GUI to use as eraser NOTE: while any area erased doesn't mean there is nothing on the screen after the erasure (there is an area colored in the deemed transparent color) however you will still be able to interact with the stuff on your screen underneath the erased area (because the color is transparent)

hh := A_ScreenHeight - 75
ww := A_ScreenWidth / 3
ColorChoice = Red
LineWidth = 7
xpos=0
ypos=0
word=

Gui 2: Color, Black
Gui 2: Margin, 0, 0
Gui 2: +LastFound +AlwaysOnTop +ToolWindow -Caption -DPIScale
Try{
Gui 2: Add, DropDownList, w80 vColorChoice gchange, Black|Red||Blue|Green|Yellow|White|Eraser|
Gui 2: Add, DropDownList, w45 xp+80 vLineWidth gchange2, 1|2||3|4|8|10|12|14|16|18|20|24|28|36|48|72|
}
Gui 2: Show, x0 y%hh% w125 h22

Gui, 1:+LastFound +AlwaysOnTop -DPIScale +ToolWindow -Caption
;~ Gui, 1:-Caption
Gui, 1:Color, FFE7E0
WinSet, TransColor, FFE7E0
GuiHwnd := WinExist()
Gui, 1:Show, w%A_ScreenWidth% h%A_ScreenHeight%
;~ Gui, 1:Maximize

SetTimer, DrawLine, 100

return


DrawLine:
GetKeyState, state, LButton
GetKeyState, state2, Ctrl
MouseGetPos, M_x, M_y
if state = D
if state2 = D
{

sleep 25
MouseGetPos, M_x2, M_y2
Canvas_DrawLine(GuihWnd, M_x, M_y, M_x2, M_y2, LineWidth, %ColorChoice%)

loop 30
{
GetKeyState, state, LButton
GetKeyState, state2, Ctrl
if state = U
{
break
}
else if state2 = U
{
break
}
sleep 25
MouseGetPos, M_x3, M_y3
Canvas_DrawLine(GuihWnd, M_x3, M_y3, M_x2, M_y2, LineWidth, %ColorChoice%)
sleep 25
MouseGetPos, M_x2, M_y2
Canvas_DrawLine(GuihWnd, M_x3, M_y3, M_x2, M_y2, LineWidth, %ColorChoice%)
}
}
return

Canvas_DrawLine(hWnd, p_x1, p_y1, p_x2, p_y2, p_w, p_color) ; r,angle,width,color)
   {
   p_x1 -= 1, p_y1 -= 1, p_x2 -= 1, p_y2 -= 1
   hDC := DllCall("GetDC", UInt, hWnd)
   hCurrPen := DllCall("CreatePen", UInt, 0, UInt, p_w, UInt, Convert_BGR(p_color))
   DllCall("SelectObject", UInt,hdc, UInt,hCurrPen)
   DllCall("gdi32.dll\MoveToEx", UInt, hdc, Uint,p_x1, Uint, p_y1, Uint, 0 )
   DllCall("gdi32.dll\LineTo", UInt, hdc, Uint, p_x2, Uint, p_y2 )
   DllCall("ReleaseDC", UInt, 0, UInt, hDC)  ; Clean-up.
   DllCall("DeleteObject", UInt,hCurrPen)
   }

Convert_BGR(RGB)
   {
   StringLeft, r, RGB, 2
   StringMid, g, RGB, 3, 2
   StringRight, b, RGB, 2
   Return, "0x" . b . g . r
   }

return

change:
lastColor:= ColorChoice
Gui 2: submit, nohide
If (ColorChoice="Eraser")
{
   Guicontrol, Choose, LineWidth, 16
   Gui 2: submit, nohide
}
if (lastColor="Eraser")
{
   Guicontrol, Choose, LineWidth, 2
   Gui 2: submit, nohide
}
return

change2:
Gui 2: submit, nohide
return

GuiClose:
2GuiClose:
ExitApp
return

~Capslock::
	if (A_PriorHotkey <> "~Capslock" or A_TimeSincePriorHotkey > 200)
	{
		KeyWait, Capslock
		return
	}
	Reload
return
