#SingleInstance, Force
Coordmode,Mouse,Screen
#NoEnv
Gdip_Startup()
OnExit, Exit
Width :=A_ScreenWidth, Height :=A_ScreenHeight
Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
Gui, 1: Show, NA
hwnd1 := WinExist(),hbm := CreateDIBSection(Width, Height),hdc := CreateCompatibleDC(),obm := SelectObject(hdc, hbm),G := Gdip_GraphicsFromHDC(hdc)
Gdip_SetSmoothingMode(G, 4)
UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)
color1:="0xffff0000",i:=0,j:=0
Return
Timer:
	If(GetKeyState("Ctrl")){
		MouseGetPos,x1,y1
		pPen := Gdip_CreatePen(color1, 3)
		Gdip_DrawLine(G, pPen,xStart,yStart, x1, y1)
		Gdip_DeleteBrush(pPen)
		pPen := Gdip_CreatePen(color1, 3)
		Gdip_DrawLine(G, pPen,xStart-1,yStart-1, x1-1, y1-1)
		Gdip_DeleteBrush(pPen)
		pPen := Gdip_CreatePen(color1, 3)
		Gdip_DrawLine(G, pPen,xStart+1,yStart+1, x1+1, y1+1)
		Gdip_DeleteBrush(pPen)
		UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)
		xStart:=x1,yStart:=y1
	}else
		SetTimer,Timer,Off
	return
*^LButton::
	MouseGetPos,xStart,yStart
	SetTimer,Timer,10
	return
*^RButton::
	Gui,1:Destroy
	Width :=A_ScreenWidth, Height :=A_ScreenHeight
	Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
	Gui, 1: Show, NA
	hwnd1 := WinExist()
	SelectObject(hdc, obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
	hbm := CreateDIBSection(Width, Height),hdc := CreateCompatibleDC(),obm := SelectObject(hdc, hbm),G := Gdip_GraphicsFromHDC(hdc)
	Gdip_SetSmoothingMode(G, 4)
	return
Update_Color:
	Gui,2:Submit
	tlist:=["0xff000000","0xffff0000","0xff0000ff","0xff00ff00","0xff00ffff","0xffffff00","0xffff00ff"],Color1:=tList[tColor1-1]
	Gui,2:Destroy
	return
^WheelUp::
^WheelDown::
	Gui,2:Destroy
	Gui,2:+AlwaysOnTop -Caption
	Gui,2:Add,ListBox,x0 y0 w200 r10 AltSubmit vtColor1 gUpdate_Color,|Black||Red|Blue|Green|Aqua|Yellow|Purple
	Gui,2:Show
	return
Exit:
*^NumPad7::
Gdip_Shutdown(pToken)
ExitApp
UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if ((x != "") && (y != ""))
		VarSetCapacity(pt, 8), NumPut(x, pt, 0, "UInt"), NumPut(y, pt, 4, "UInt")

	if (w = "") ||(h = "")
		WinGetPos,,, w, h, ahk_id %hwnd%

	return DllCall("UpdateLayeredWindow"
					, Ptr, hwnd
					, Ptr, 0
					, Ptr, ((x = "") && (y = "")) ? 0 : &pt
					, "int64*", w|h<<32
					, Ptr, hdc
					, "int64*", 0
					, "uint", 0
					, "UInt*", Alpha<<16|1<<24
					, "uint", 2)
}
CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)
	NumPut(w, bi, 4, "uint")
	, NumPut(h, bi, 8, "uint")
	, NumPut(40, bi, 0, "uint")
	, NumPut(1, bi, 12, "ushort")
	, NumPut(0, bi, 16, "uInt")
	, NumPut(bpp, bi, 14, "ushort")
	hbm := DllCall("CreateDIBSection"
					, Ptr, hdc2
					, Ptr, &bi
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "uint*", ppvBits
					, Ptr, 0
					, "uint", 0, Ptr)

	if !hdc
		ReleaseDC(hdc2)
	return hbm
}
CreateCompatibleDC(hdc=0)
{
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
SelectObject(hdc, hgdiobj)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}
DeleteObject(hObject)
{
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}
GetDC(hwnd=0)
{
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}
ReleaseDC(hdc, hwnd=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}
DeleteDC(hdc)
{
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawLine"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2)
}

Gdip_GraphicsFromHDC(hdc)
{
    DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
    return pGraphics
}
Gdip_CreatePen(ARGB, w)
{
   DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
   return pPen
}

Gdip_DeletePen(pPen)
{
   return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}
Gdip_DeleteBrush(pBrush)
{
   return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}

Gdip_DeleteGraphics(pGraphics)
{
   return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
{
   return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}
Gdip_Startup()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}
Gdip_Shutdown(pToken)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}
