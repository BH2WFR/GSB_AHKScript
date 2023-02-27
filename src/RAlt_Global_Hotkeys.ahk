; encoding: UTF-8 with BOM


;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

; 全局热键
;* F23 释放时触发正常的 F23 功能，如果在韩文输入法下则输出汉字切换键
#If use_SemiColonAsRAlt == 0
;$F23 Up::
$F23::
	
	If(1 == IsInKoreanLayout()){	;* 如果处于韩文输入法下
		SendHanjaKey()	; 汉字切换
	}else{
		Send {F23} ; 释放正常 RAlt 点击
	}
	
return

;* 对于 RAlt 不方便按下的键盘, 用分号键替代 F23 功能键
#If use_SemiColonAsRAlt == 1
F24 & F23::
;$RAlt::
	
	If(1 == IsInKoreanLayout()){	;* 如果处于韩文输入法下
		SendHanjaKey()	; 汉字切换
	}else{
		
	}
return

+F23::	;* 输出正常的分号和冒号
	Send, :
return	
$F23 Up::
	Send, `;
return

#If

;*=============== F23：全局切换 RAlt 模式 ========





F23 & Esc::   ;* 查看当前 RAlt 模式
	if (GetKeyState("Shift")){
		AltModeTestToolTip(1)
	}else{
		AltModeTestToolTip()
	}
return
F23 & F1::SetRAltMode(1)	; 设置 RAlt 模式
F23 & F2::SetRAltMode(2)
F23 & F3::return
F23 & F4::return
F23 & F5::return
F23 & F6::return
F23 & F7::return
F23 & F8::return
F23 & F9::return
F23 & F10::return
F23 & F11::return
F23 & F12::return
F23 & PrintScreen::return
F23 & ScrollLock::return
F23 & Home::return
F23 & End::return
F23 & PgUp::return
F23 & PgDn::return
F23 & Delete::SetRAltMode(0)	;关闭RAlt模式


F23 & Backspace::Send, {Right}{Backspace 2}



;^===================================  系统特殊功能：=====================================
;系统功能
;*========== RAlt+方向键 以像素为单位移动鼠标指针, 加上 Shift 后快速移动鼠标
#If 1

#If use_SemiColonAsRAlt == 0
F23 & Right::
F23 & Left::
F23 & Up::
F23 & Down::
#If use_SemiColonAsRAlt == 1
RAlt & Right::
RAlt & Left::
RAlt & Up::
RAlt & Down::
#If
	if (GetKeyState("Shift")){
		increment := g_MouseQuickMoveUnitPixels
	}else{
		increment := 1
	}
	
	if (InStr(A_ThisHotkey, "Left")){
		MoveMouse("Left", increment)
	}else if (InStr(A_ThisHotkey, "Right")){
		MoveMouse("Right", increment)
	}else if (InStr(A_ThisHotkey, "Up")){
		MoveMouse("Up", increment)
	}else if (InStr(A_ThisHotkey, "Down")){
		MoveMouse("Down", increment)
	}
	;MsgBox, haha , %A_ThisHotkey%
return

#If use_SemiColonAsRAlt == 0
F23 & RWin::
#If use_SemiColonAsRAlt == 1
RAlt & RWin::
#If
	Send, {LButton}
return


#If use_SemiColonAsRAlt == 0
F23 & AppsKey::
#If use_SemiColonAsRAlt == 1
RAlt & AppsKey::
#If
	Send, {RButton}
return


#If



;* ================ RAlt+鼠标滚轮 横向滚动, 加 Shift 更快速
#If use_SemiColonAsRAlt == 0
F23 & WheelDown::	;* Right
#If use_SemiColonAsRAlt == 1
RAlt & WheelDown::
#If	
	if (GetKeyState("Shift")){
		WheelScroll("right", g_MouseQuickScrollUnit)
	}else{
		WheelScroll("right", 1)
	}
return

#If use_SemiColonAsRAlt == 0
F23 & WheelUp::		;* Left
#If use_SemiColonAsRAlt == 1
RAlt & WheelUp::
#If	
	if (GetKeyState("Shift")){
		WheelScroll("left", g_MouseQuickScrollUnit)
	}else{
		WheelScroll("left", 1)
	}
return



;* ================ Caps+鼠标滚轮  加速纵向滚动, 加 Shift 更快速
F24 & WheelDown::
	if (GetKeyState("Shift")){
		WheelScroll("down", g_MouseSuperScrollUnit)
	}else{
		WheelScroll("down", g_MouseQuickScrollUnit)
	}
return
F24 & WheelUp::
	if (GetKeyState("Shift")){
		WheelScroll("up", g_MouseSuperScrollUnit)
	}else{
		WheelScroll("up", g_MouseQuickScrollUnit)
	}
return



;*   ========================== 0 OFF 模式，关闭所有热键 =============================
#If rAltMode == 0
	F23 & Tab::return
	F23 & CapsLock::return
	F23 & Space::return
	;F23 & Enter::return
	;F23 & BackSpace::return
	F23 & `::return
	F23 & 1::return
	F23 & 2::return
	F23 & 3::return
	F23 & 4::return
	F23 & 5::return	
	F23 & 6::return
	F23 & 7::return
	F23 & 8::return
	F23 & 9::return
	F23 & 0::return
	F23 & -::return
	F23 & =::return
	F23 & [::return
	F23 & ]::return
	F23 & \::return	
	F23 & `;::return
	F23 & '::return
	F23 & ,::return
	F23 & .::return
	F23 & /::return
	F23 & a::return
	F23 & b::return	
	F23 & c::return	
	F23 & d::return
	F23 & e::return
	F23 & f::return
	F23 & g::return
	F23 & h::return
	F23 & i::return	
	F23 & j::return
	F23 & k::return
	F23 & l::return
	F23 & m::return
	F23 & n::return
	F23 & o::return	
	F23 & p::return
	F23 & q::return
	F23 & r::return
	F23 & s::return
	F23 & t::return
	F23 & u::return
	F23 & v::return
	F23 & w::return
	F23 & x::return
	F23 & y::return	
	F23 & z::return	
#If
