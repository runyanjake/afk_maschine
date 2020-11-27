;by pZ_aeriaL
; Ctrl+Alt+X to start
; Ctrl+Alt+C to stop
; Ctrl+B to toggle modes (there will be a popup)

timer:=0 ;iteration counter
stopFlag:=0
mode:=0

SetControlDelay -1

^!c::
ExitApp

^b::
mode:=mode==3?0:(mode+1)
if(mode==0){
	MsgBox, "Enabled mode 1 (Shoot)"
}else if(mode==1){
	MsgBox, "Enabled mode 2 (Melee)"
}else if(mode==2){
	MsgBox, "Enabled mode 3 (Gun+Knife Farming)"
}else if(mode==3){
	MsgBox, "Enabled mode 4 (DIE Machine Farming)"
}
return

^!x::
while (stopFlag<1){
	if(mode==0){
		SendLClick()
		SendInteract()
	}else if(mode==1){
		SendMelee()
		SendInteract()
	}else if(mode==2){
		if(Mod(timer, 30)==0){
			SendWeaponSwap()
			sleep 2000
			SendCrouchUncrouch()
			sleep 250
			SendInteract()
			sleep 25
			SendInteract()
			sleep 25
			SendInteract()
			sleep 500
			SendCrouchUncrouch()
			sleep 250
		}else{
			SendLongLClick()
		}
	}else if(mode==3){
		if(Mod(timer, 10)==0){
			SendLClick()
		}else{
			SendRClick()
		}
		SendInteract()
	}
	RandomSleep()
	timer++
}
return

SendCrouchUncrouch(){
	ControlSend,,{Ctrl},ahk_exe BlackOpsColdWar.exe
}

SendWeaponSwap(){
	ControlSend,,2,ahk_exe BlackOpsColdWar.exe
	sleep, 50
}

SendInteract(){
	ControlSend,,f,ahk_exe BlackOpsColdWar.exe
}

SendMelee(){
	ControlSend,,e,ahk_exe BlackOpsColdWar.exe
	sleep, 500
}

SendLClick(){
	ControlClick,,ahk_exe BlackOpsColdWar.exe,,Left,1,NA x25 y25
}

SendLongLClick(){
	ControlClick,,ahk_exe BlackOpsColdWar.exe,,Left,1,D
	sleep, 1000
	ControlClick,,ahk_exe BlackOpsColdWar.exe,,Left,1,U
}

SendRClick(){
	ControlClick,,ahk_exe BlackOpsColdWar.exe,,Right,1,D
	sleep, 1000
	ControlClick,,ahk_exe BlackOpsColdWar.exe,,Right,1,U
}

RandomSleep(){
	Random, amt, 1, 25
	sleep (500 + (amt/2))
}