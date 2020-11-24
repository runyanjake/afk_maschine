;by pZ_aeriaL
; Ctrl+X OR Ctrl+Q to start
; Ctrl+B to toggle attack between Fire, Suck, Melee, LCLick swap
; Ctrl+C to stop

zombiesRoundNumberRed:=0x050599 ;approx hex for round nr
healthWhite:=0xE0E2E2
attackMode:=0

^c:: 
break:=break==1?0:1
RemoveRoundNrBox()
RemoveHealthBox()
return

^b::
attackMode:=attackMode>=3?0:(attackMode+1)
return

^x::
^q::
break:=1
avgMsDelay:=500
iterations:=0
CreateRoundNrBox(zombiesRoundNumberRed)
RoundNrBox(1719, 47, 200, 125, 2, "in")
CreateHealthBox(zombiesRoundNumberRed)
HealthBox(100, 1010, 130, 10, 2, "in")
while break==1 {
	;If round has just ended, wait 30s
	PixelSearch, Px, Py, 1720, 48, 1900, 152, %zombiesRoundNumberRed%, 50, Fast
	if ErrorLevel
	{
	    sleep, 30000
	}

	;Choose between suck/nonsuck
	if(attackMode == 1){
		Click Down Right
		sleep 1000
		Click Up Right
		if(Mod(iterations, 20) == 0){
			MouseClick, left
			sleep, 50
			MouseClick, left
			sleep, 50
			MouseClick, left
			sleep, 50
			MouseClick, left
			sleep, 50
		}
	}else if (attackMode == 2){
		Send e
	}else if (attackMode == 3){
		if(Mod(iterations, 100)==0){
			Send 2
		}else{
			MouseClick, left
		}
	}else{
		MouseClick, left
	}
	sleep 25

	;Pick up items with F
	Send f
	sleep 25

	;If at critical health, activate field upgrade and pause the game.
	PixelSearch, Px, Py, 101, 1011, 229, 1018, %healthWhite%, 50, Fast
	if ErrorLevel{
	    Send x
	    Send {Esc}
	    return
	}else{
		sleep 1
	}

	;Sleep between each iteration and increment
	Random, amt, 1, 25
	sleep (avgMsDelay + (amt/2))
	iterations++
}
return

;Gets color at mouse position.
^r::
MouseGetPos, mouseX, mouseY
PixelGetColor, pixelColor, mouseX, mouseY
MsgBox, "Pixel at (%mouseX%, %mouseY%) has color %pixelColor%"
return

;Checks if single pixel matches color.
^t::
MouseGetPos, mouseX, mouseY
PixelGetColor, pixelColor, mouseX, mouseY
ifEqual, pixelColor, %zombiesRoundNumberRed% 
{
	MsgBox, "Red"
}else{
	MsgBox, "Not Red"
}
return

CreateRoundNrBox(Color)
{
	Gui 81:color, %Color%
	Gui 81:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 82:color, %Color%
	Gui 82:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 83:color, %Color%
	Gui 83:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 84:color, %Color%
	Gui 84:+ToolWindow -SysMenu -Caption +AlwaysOnTop
}

RemoveRoundNrBox()
{
	Gui 81:destroy
	Gui 82:destroy
	Gui 83:destroy
	Gui 84:destroy
}

RoundNrBox(XCor, YCor, Width, Height, Thickness, Offset)
{
	If InStr(Offset, "In")
	{
		StringTrimLeft, offset, offset, 2
		If not Offset
			Offset = 0
		Side = -1
	} Else {
		StringTrimLeft, offset, offset, 3
		If not Offset
			Offset = 0
		Side = 1
	}
	x := XCor - (Side + 1) / 2 * Thickness - Side * Offset
	y := YCor - (Side + 1) / 2 * Thickness - Side * Offset
	h := Height + Side * Thickness + Side * Offset * 2
	w := Thickness
	Gui 81:Show, x%x% y%y% w%w% h%h% NA
	x += Thickness
	w := Width + Side * Thickness + Side * Offset * 2
	h := Thickness
	Gui 82:Show, x%x% y%y% w%w% h%h% NA
	x := x + w - Thickness
	y += Thickness
	h := Height + Side * Thickness + Side * Offset * 2
	w := Thickness
	Gui 83:Show, x%x% y%y% w%w% h%h% NA
	x := XCor - (Side + 1) / 2 * Thickness - Side * Offset
	y += h - Thickness
	w := Width + Side * Thickness + Side * Offset * 2
	h := Thickness
	Gui 84:Show, x%x% y%y% w%w% h%h% NA
}

CreateHealthBox(Color)
{
	Gui 85:color, %Color%
	Gui 85:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 86:color, %Color%
	Gui 86:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 87:color, %Color%
	Gui 87:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 88:color, %Color%
	Gui 88:+ToolWindow -SysMenu -Caption +AlwaysOnTop
}

RemoveHealthBox()
{
	Gui 85:destroy
	Gui 86:destroy
	Gui 87:destroy
	Gui 88:destroy
}

HealthBox(XCor, YCor, Width, Height, Thickness, Offset)
{
	If InStr(Offset, "In")
	{
		StringTrimLeft, offset, offset, 2
		If not Offset
			Offset = 0
		Side = -1
	} Else {
		StringTrimLeft, offset, offset, 3
		If not Offset
			Offset = 0
		Side = 1
	}
	x := XCor - (Side + 1) / 2 * Thickness - Side * Offset
	y := YCor - (Side + 1) / 2 * Thickness - Side * Offset
	h := Height + Side * Thickness + Side * Offset * 2
	w := Thickness
	Gui 85:Show, x%x% y%y% w%w% h%h% NA
	x += Thickness
	w := Width + Side * Thickness + Side * Offset * 2
	h := Thickness
	Gui 86:Show, x%x% y%y% w%w% h%h% NA
	x := x + w - Thickness
	y += Thickness
	h := Height + Side * Thickness + Side * Offset * 2
	w := Thickness
	Gui 87:Show, x%x% y%y% w%w% h%h% NA
	x := XCor - (Side + 1) / 2 * Thickness - Side * Offset
	y += h - Thickness
	w := Width + Side * Thickness + Side * Offset * 2
	h := Thickness
	Gui 88:Show, x%x% y%y% w%w% h%h% NA
}

;Searches for pixel in box that matches color.
^y::
PixelSearch, Px, Py, 1720, 48, 1900, 152, %zombiesRoundNumberRed%, 20, Fast
if ErrorLevel
    MsgBox, That color was not found in the specified region.
else
    MsgBox, A color within 2 0 shades of variation was found at X%Px% Y%Py%.
return