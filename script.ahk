
;** ====================== GSB_AKHScript ======================
;|       版本：0.2.3(alpha)             作者：GSB Electronic       |
;|      AHK 最低支持版本：                      
;**|      提示：需要管理员权限，请以管理员权限启动！
;|  代码仓库：https://github.com/BH2WFR/GSB_AHKScript.git
;| 汉字
;============================================================




;================  申请管理员权限 =================
; if (! A_IsAdmin){ ;http://ahkscript.org/docs/Variables.htm#IsAdmin
; 	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
; 	ExitApp
; }
Loop, %0%  ; For each parameter:
  {
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    params .= A_Space . param
  }
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
 
if not A_IsAdmin
{
    If A_IsCompiled
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
    Else
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
    ExitApp
}



;===========================  全局变量 ========================
isTestMode := 1		; 是否处于测试模式
rAltMode := 0		; RAlt 特殊模式，0 为关闭状态
rAltModeList := {0:"OFF", 1:"Programming Mode", 2:"Galian Script", 3:"Esp Script", 4:"Colemak Input"}



;========================== 全局热键   ========================
$CapsLock::Send,^+{2} ; CapsLock 切换中英文，调用小狼毫输入法

$F13 Up:: Send {F13} ; RAlt 功能

F13 & Esc::   ; 查看当前 RAlt 模式
	if (GetKeyState("Shift")){
		AltModeTestToolTip(1)
	}else{
		AltModeTestToolTip()
	}
return

F13 & F1::
	SetRAltMode(1)
return

F13 & F2::
	SetRAltMode(2)
return

F13 & F3::

return

F13 & F4::
return

F13 & F5::
return

F13 & F6::
return

F13 & F7::
return

F13 & F8::
return

F13 & F9::
return

F13 & F10::
return

F13 & F11::
return

F13 & F12::
return

F13 & PrintScreen::
return

F13 & ScrollLock::
return

F13 & Home::
return

F13 & End::
return

F13 & PgUp::
return

F13 & PgDn::
return

F13 & Delete::
	SetRAltMode(0)
return


;======================== 程序特殊热键   ========================
#IfWinActive ahk_exe anki.exe
	F13::
		Send  ^b
		Sleep 30
		Send {F7}
	return
#IfWinActive	



#IfWinActive ahk_exe ONENOTE.EXE
	F20::
		Send {CtrlDown}{CtrlUp}
	return
#IfWinActive

#IfWinActive ahk_exe UV4.exe
	;快捷输入主函数


#IfWinActive



;========================  系统级别特殊功能：=====================



;  ==== win+F1  窗口置顶，Win+F2 窗口取消置顶
#F1::
	WinSet AlwaysOnTop,On,A
	tooltip, AlwaysOnTop: ON
	SetTimer, RemoveToolTip, -1000
return
#F2::
	WinSet AlwaysOnTop,Off,A
	tooltip, AlwaysOnTop: OFF
	SetTimer, RemoveToolTip, -1000
return

;appskey+方向键移动鼠标，第三个参数为移动速度
F13 & Right::	MouseMove, 1, 0, 100, R
F13 & Left::	MouseMove, -1, 0, 100, R
F13 & Up::		MouseMove, 0, -1, 100, R
F13 & Down::	MouseMove, 0, 1, 100, R
;$Insert Up:: Send {Insert} ; 确保 Insert 按钮功能仍然有用

;任务栏滚动鼠标滚轮调节音量
#If MouseIsOver("ahk_class Shell_TrayWnd")
	WheelUp::Send {Volume_Up}
	WheelDown::Send {Volume_Down}
	Mbutton::Send {Volume_Mute}

	MouseIsOver(WinTitle) {
		MouseGetPos,,, Win
		return WinExist(WinTitle . " ahk_id " . Win)
	}
#If

; LWin+鼠标滚轮：窗口置顶/取消置顶， LWin+Shift+鼠标滚轮：调节窗口透明度
~LWin & WheelUp::
; 透明度调整，增加。
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
return
 
~LWin & WheelDown::
;透明度调整，减少。
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


;======================= 自制函数 ===========================
SetRAltMode(mode)
{
	global rAltMode
	global rAltModeList
	rAltMode := mode
	ShowToolTip("切换到 rAlt 模式：" rAltMode ": " rAltModeList[rAltMode])
}

;==== 工具提示条显示当前模式
AltModeTestToolTip(ifPressedShift := 0){
	global rAltMode
	global rAltModeList
	If(ifPressedShift == 1){
		ShowToolTip("测试:当前 rAlt 模式为： " rAltMode ": " rAltModeList[rAltMode] " (Shift 键已按下)")
	}else{
		ShowToolTip("测试:当前 rAlt 模式为： " rAltMode ": " rAltModeList[rAltMode])
	}
}

;==== 工具提示条显示 **一秒钟**
ShowToolTip(str){
	ToolTip, %str%
	SetTimer, RemoveToolTip, -1000
}
RemoveToolTip:   ; 禁止删除，前面要用到，用于超时关闭工具提示
	ToolTip
return

;=== 绕过输入法直接输入字符（无法绕过 IDE 智能感知）
SendBypassIME(str){
	SendInput, {Text}%str%
}

;=== 使用剪贴板强制输入指定文本
SendByClipboard(str){
	lastClipboardString = Clipboard
	Clipboard = str
	Send, ^v
	Clipboard = lastClipboardString
}

;=== 输入对称的括号
SendSymmetricSymbles(str){
	if (StrLen(str) == 2){	;文本长度必须为 2
		;支持输入单侧花括号后自动补全另一侧的 智能 IDE
		If (WinActive("ahk_exe vscode.exe") || WinActive("ahk_exe devenv.exe") || WinActive("ahk_exe qtcreator.exe") ){
			SendBypassIME(SubStr(str, 1, 1))
		;不支持输入单侧花括号自动补全另一侧的 智障 IDE
		}Else{
			SendBypassIME(str)
			Send, {Left}			
		}
	}else{
		Msgbox, Length of String should to be 2 in function Calling "SendSymmetricSymbles"
	}
}

;=== 插入代码块并设置好缩进
SendCodeBlock(str){
	if (StrLen(str) == 2){	;文本长度必须为 2
		;支持输入单侧花括号后按下回车就可以创建代码块的智能 IDE
		If (WinActive("ahk_exe vscode.exe") || WinActive("ahk_exe devenv.exe") || WinActive("ahk_exe qtcreator.exe") ){
			SendBypassIME(SubStr(str, 1, 1))
			Send, {Enter}
		;支持输入双侧花括号，并控制光标后按下回车就可以创建代码块的 半智能 IDE
		}Else If (WinActive("ahk_exe UV4.exe")){
			SendSymmetricSymbles(str)
			Send, {Enter}
		;智障 IDE
		}Else{
			SendSymmetricSymbles(str)
			Send, {Enter 2}	{BackSpace}{Up} {Space 3}
		}		
	}else{
		Msgbox, Length of String should to be 2 in function Calling "SendCodeBlock"
	}	
}




;====================== RAlt 特殊方案列表：=======================
;    ========= 0 OFF 模式，关闭所有热键 ===============
#If rAltMode == 0
	F13 & Tab::return
	F13 & CapsLock::return
	F13 & Space::return
	F13 & Enter::return
	F13 & BackSpace::return
	F13 & `::return
	F13 & 1::return
	F13 & 2::return
	F13 & 3::return
	F13 & 4::return
	F13 & 5::return	
	F13 & 6::return
	F13 & 7::return
	F13 & 8::return
	F13 & 9::return
	F13 & 0::return
	F13 & -::return
	F13 & =::return
	F13 & [::return
	F13 & ]::return
	F13 & \::return	
	F13 & `;::return
	F13 & '::return
	F13 & ,::return
	F13 & .::return
	F13 & /::return
	F13 & a::return
	F13 & b::return	
	F13 & c::return	
	F13 & d::return
	F13 & e::return
	F13 & f::return
	F13 & g::return
	F13 & h::return
	F13 & i::return	
	F13 & j::return
	F13 & k::return
	F13 & l::return
	F13 & m::return
	F13 & n::return
	F13 & o::return	
	F13 & p::return
	F13 & q::return
	F13 & r::return
	F13 & s::return
	F13 & t::return
	F13 & u::return
	F13 & v::return
	F13 & w::return
	F13 & x::return
	F13 & y::return	
	F13 & z::return	
#If




;   =========== 1 编程模式 =================
#If rAltMode == 1
	F13 & CapsLock::return
	F13 & Space::return
	F13 & Enter::return
	F13 & BackSpace::return
	F13 & `::return
	
	F13 & Tab::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Space 4}
		}		
	return
	F13 & 1::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("!")
		}
	return
	F13 & 2::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("@")
		}
	return
	F13 & 3::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("#")
		}
	return
	F13 & 4::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("$")
		}
	return
	F13 & 5::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("%")
		}
	return	
	F13 & 6::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("^")
		}
	return
	F13 & 7::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("&")
		}
	return
	F13 & 8::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("*")
		}
	return
	F13 & 9::
		if (GetKeyState("Shift")){
			
		}else{
			SendSymmetricSymbles("()")
		}
	return
	F13 & 0::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Left}{BackSpace}{Right}
		}
	return
	F13 & -::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("_")
		}
	return
	F13 & =::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & [::
		if (GetKeyState("Shift")){
			SendSymmetricSymbles("{}")
		}else{
			SendSymmetricSymbles("[]")
		}
	return
	F13 & ]::
		if (GetKeyState("Shift")){
			SendCodeBlock("{}")
		}else{
			SendCodeBlock("[]")
		}
	return
	F13 & \::
		if (GetKeyState("Shift")){
			SendBypassIME("|")
		}else{
			SendBypassIME("\")
		}
	return	
	F13 & `;::
		if (GetKeyState("Shift")){
			SendBypassIME(":")
		}else{
			SendBypassIME(";")
		}
	return
	F13 & '::
		if (GetKeyState("Shift")){
			SendSymmetricSymbles("""""")
			
		}else{
			SendSymmetricSymbles("''")
			
		}
	return
	F13 & ,::
		if (GetKeyState("Shift")){
			
		}else{
			SendInput, {Text},
		}
	return
	F13 & .::
		if (GetKeyState("Shift")){
			SendBypassIME("->")
		}else{
			SendBypassIME(".")
		}
	return
	F13 & /::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & a::
		if (GetKeyState("Shift")){
			
		}else{
			Send, +{Left}
		}
	return
	F13 & b::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & c::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & d::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Down}
		}
	return
	F13 & e::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Up}
		}
	return
	F13 & f::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Right}
		}
	return
	F13 & g::
		if (GetKeyState("Shift")){
			
		}else{
			Send, +{Right}
		}
	return
	F13 & h::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & i::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & j::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & k::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & l::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & m::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & n::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & o::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & p::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & q::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^+{Left}
		}
	return
	F13 & r::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^{Right}
		}
	return
	F13 & s::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Left}
		}
	return
	F13 & t::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^+{Right}
		}
	return
	F13 & u::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & v::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & w::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^{Left}
		}
	return
	F13 & x::
		if (GetKeyState("Shift")){
				
		}else{
			
		}
	return
	F13 & y::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & z::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
#If



;   ========== 2 Galia输入法模式 ============
#If rAltMode == 2

	F13 & Tab::return
	F13 & CapsLock::return
	F13 & Space::return
	F13 & Enter::return
	F13 & BackSpace::return
	F13 & `::return
	
	F13 & 1::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 2::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 3::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 4::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 5::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & 6::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 7::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 8::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 9::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 0::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & -::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & =::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & [::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & ]::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & \::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & `;::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & '::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & ,::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & .::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & /::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & a::
		if (GetKeyState("Shift")){
			SendRaw, Ä
		}else{
			SendRaw, ä
		}
	return
	F13 & b::
		if (GetKeyState("Shift")){
			SendRaw, Ḉ
		}else{
			SendRaw, ḉ
		}
	return	
	F13 & c::
		if (GetKeyState("Shift")){
			SendRaw, Ć
		}else{
			SendRaw, ć
		}
	return	
	F13 & d::
		if (GetKeyState("Shift")){
			SendRaw, Ɖ
		}else{
			SendRaw, đ
		}
	return
	F13 & e::
		if(GetKeyState("Shift")) 
			SendRaw, Ĕ
		else 
			SendRaw, ĕ 
		return
	F13 & f::
		if (GetKeyState("Shift")){
			SendRaw, Ğ
		}else{
			SendRaw, ğ
		}
	return
	F13 & g::
		if (GetKeyState("Shift")){
			SendRaw, Ǵ
		}else{
			SendRaw, ǵ
		}
	return
	F13 & h::
		if (GetKeyState("Shift")){
			SendRaw, Ħ
		}else{
			SendRaw, ħ
		}
	return
	F13 & i::
		if (GetKeyState("Shift")){
			SendRaw, Ï
		}else{
			SendRaw, ï
		}
	return	
	F13 & j::
		if (GetKeyState("Shift")){
			SendRaw, Ë
		}else{
			SendRaw, ë
		}
	return
	F13 & k::
		if (GetKeyState("Shift")){
			SendRaw, Ꝁ
		}else{
			SendRaw, ꝁ
		}
	return
	F13 & l::
		if (GetKeyState("Shift")){
			SendRaw, Ł
		}else{
			SendRaw, ł
		}
	return
	F13 & m::
		if (GetKeyState("Shift")){
			SendRaw, Ñ
		}else{
			SendRaw, ñ
		}
	return
	F13 & n::
		if (GetKeyState("Shift")){
			SendRaw, Ń
		}else{
			SendRaw, ń
		}
	return
	F13 & o::
		if (GetKeyState("Shift")){
			SendRaw, Ö
		}else{
			SendRaw, ö
		}
	return	
	F13 & p::
		if (GetKeyState("Shift")){
			SendRaw, Ᵽ
		}else{
			SendRaw, ᵽ
		}
	return
	F13 & q::
		if (GetKeyState("Shift")){
			SendRaw, Ꝗ
		}else{
			SendRaw, ꝗ
		}
	return
	F13 & r::
		if (GetKeyState("Shift")){
			SendRaw, Ŕ
		}else{
			SendRaw, ŕ
		}
	return
	F13 & s::
		if (GetKeyState("Shift")){
			SendRaw, Ś
		}else{
			SendRaw, ś
		}
	return
	F13 & t::
		if (GetKeyState("Shift")){
			SendRaw, Ŧ
		}else{
			SendRaw, ŧ
		}
	return
	F13 & u::
		if (GetKeyState("Shift")){
			SendRaw, Ü
		}else{
			SendRaw, ü
		}
	return
	F13 & v::
		if (GetKeyState("Shift")){
			SendRaw, Ç
		}else{
			SendRaw, ç
		}
	return
	F13 & w::
		if (GetKeyState("Shift")){
			SendRaw, Ẅ
		}else{
			SendRaw, ẅ
		}
	return
	F13 & x::
		if (GetKeyState("Shift")){
			SendRaw, Ẍ
		}else{
			SendRaw, ẍ
		}
	return
	F13 & y::
		if (GetKeyState("Shift")){
			SendRaw, Ÿ
		}else{
			SendRaw, ÿ
		}
	return	
	F13 & z::
		if (GetKeyState("Shift")){
			SendRaw, Ź
		}else{
			SendRaw, ź
		}
	return
#If






;    ========= 3 Esp 模式 ================


