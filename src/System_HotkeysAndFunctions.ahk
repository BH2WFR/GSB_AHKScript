; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

;*=============== 任务栏上：任务栏上滚动鼠标滚轮以调节音量（更新：副屏的任务栏也可以了）
#if MouseIsOver("ahk_class Shell_TrayWnd") || MouseIsOver("ahk_class Shell_SecondaryTrayWnd")
	WheelUp::Send {Volume_Up}
	WheelDown::Send {Volume_Down}
	Mbutton::Send {Volume_Mute}

	MouseIsOver(WinTitle) {
		MouseGetPos,,, Win
		return WinExist(WinTitle . " ahk_id " . Win)
	}
#If


;*===============窗口上： LWin+鼠标滚轮：窗口置顶/取消置顶， LWin+Shift+鼠标滚轮：调节窗口透明度
~LWin & WheelUp::
#F1::
; 透明度调整，增加。
	BlockInput, On	;* 新增：阻塞键盘鼠标输入（不含触控板）
	if (GetKeyState("Shift")){
		WinGet, Transparent, Transparent,A
		If (Transparent="")
			Transparent=255
		Transparent_New := Transparent + 20    ;◆透明度增加速度。
		If (Transparent_New > 254)
			Transparent_New =255
		WinSet,Transparent,%Transparent_New%,A
		tooltip now: ▲%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
		;sleep 1500
		SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
	}else{
		WinSet AlwaysOnTop,On,A
		tooltip, AlwaysOnTop ON
		SetTimer, RemoveToolTip, -1000
	}
	BlockInput, Off
return
 
~LWin & WheelDown::
#F2::
;透明度调整，减少。
	BlockInput, On
	if (GetKeyState("Shift")){
		WinGet, Transparent, Transparent,A
		If (Transparent="")
			Transparent=255
		Transparent_New := Transparent - 20  ;◆透明度减少速度。
		If (Transparent_New < 35)    ;◆最小透明度限制。
			Transparent_New = 35
		WinSet,Transparent,%Transparent_New%,A
		tooltip now: ▼%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
		;sleep 1500
		SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
	}else{
		WinSet AlwaysOnTop,Off,A
		tooltip, AlwaysOnTop OFF
		SetTimer, RemoveToolTip, -1000
	}
	BlockInput, Off
return
 
;设置Lwin &Mbutton直接恢复透明度到255。
~LWin & Mbutton:: 
	WinGet, Transparent, Transparent,A
	WinSet,Transparent,255,A 
	tooltip ▲Restored ;查看当前透明度（操作之后的）。
	;sleep 1500
	SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
return
 
 
removetooltip_transparent_Lwin__2016.09.20:     ;LABEL
	tooltip
	SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, Off
return

;* ================ Win+鼠标左右滚动 切换桌面
~LWin & WheelLeft::Send, ^#{Left}
~LWin & WheelRight::Send, ^#{Right}


;* ================ RAlt+鼠标滚轮 横向滚动, 加 Shift 更快速
F23 & WheelDown::	;* Right
	if (GetKeyState("Shift")){
		WheelScroll("right", 3)
	}else{
		WheelScroll("right", 1)
	}
return
F23 & WheelUp::		;* Left
	if (GetKeyState("Shift")){
		WheelScroll("left", 3)
	}else{
		WheelScroll("left", 1)
	}
return



;* ================ Caps+鼠标滚轮  加速纵向滚动, 加 Shift 更快速
F24 & WheelDown::
	if (GetKeyState("Shift")){
		WheelScroll("down", 6)
	}else{
		WheelScroll("down", 3)
	}
return
F24 & WheelUp::
	if (GetKeyState("Shift")){
		WheelScroll("up", 6)
	}else{
		WheelScroll("up", 3)
	}
return

;TODO 浏览器触控板缩放
#If ! WinActive("ahk_exe msedge.exe") || WinActive("ahk_exe chrome.exe")
	; ^WheelUp::
	
	; return
	
	; ^WheelDown::
	
	; return
	
#If

;^==================================== 测试代码和临时函数 ==================================
;* ============ 测试代码：当前键盘布局和输入法
#If use_test_getIMEcode == 1
	F16:: 
		InputLocaleID := GetCurrentKeyboardLayoutCode()
		;MsgBox, 0x40, 输入法%InputLocaleID%
		InputName := GetCurrentKeyboardLayoutName()
		MsgBox,  0x40, 当前输入法检测, ID:   %InputLocaleID% `nName: %InputName%
	return
#If
 
 
 
 
 
 
 
 
 
;^==================================== 函数部分 ==================================
 
 
 
 
 
 