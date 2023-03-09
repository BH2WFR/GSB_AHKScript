; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

#If GSB_IsInMainScript == 1

;*======================  输入法 特殊热键, 注意: 要先使用其他软件将 CapsLock 映射为 F24
;GetKeyState("CapsLock", "T") = 1
;SetCapsLockState, on


;*Caps+空格 或 Caps+"`" 弹出小狼毫菜单
F24 & Space::
F24 & `::  
	ShowRimeImputMenu(0,0)	;
return

 ;*松开Caps键, 或者 Caps+F2 切换中英/韩英/日英
$F24 Up:: 
F24 & F2::
	SwitchIMEmode()
return


;* Ctrl+CapsLock 释放 Shift Ctrl Alt 并关闭大写锁定
^F24::ReleaseShiftCtrlAltKeys(1,1)


;  Shift+CapsLock 切换大小写锁定
; $+F24 Up::
; 	SwitchCapsLockStatus(,1)
; return



;*================== 其余 F24（CapsLock）组合快捷键, 用掉一个注释一个 =============

F24 & Esc::ShowSettingsGUI() ; 设置
F24 & F1::return	;输入法占用
;F24 & F2::return						 ;* 中英切换 已占用
F24 & F3::SwitchFullHalfShapeMode()		 ;* 全角/半角
F24 & F4::SwitchChineseSimplicatedMode() ;* 简繁体转换
F24 & F5::return						 ;* 增廣字集
F24 & F6::return
F24 & F7::return
F24 & F8::return
F24 & F9::return
F24 & F10::LoadSettings()			;* 重新加载配置文件里面的设置
F24 & F11::System_CancelShutdown()  ;* 取消强制关机发送 shutdown -a 命令
F24 & F12::DeleteAndroidEvents()	;* 安卓 ADB 删除日志
F24 & PrintScreen::return
F24 & ScrollLock::return
F24 & Home::return
F24 & End::return
F24 & PgUp::MouseWheelScroll_detectKey("Up") ; 鼠标滚动
F24 & PgDn::MouseWheelScroll_detectKey("Down")
F24 & Delete::DeleteComputerPersonalData() ;* 跑路!

F24 & Tab::SendRawTabs_detectShiftKey()		;
;F24 & CapsLock::return	;无效组合
;F24 & Space::return	;输入法占用
F24 & Enter::return		;
F24 & Backspace::Send, {Left}{Backspace}{Right}	;* 删除二字词的第一个字


F24 & Right::MoveMouse_detectKey("Right")	; 鼠标光标移动
F24 & Left::MoveMouse_detectKey("Left")
F24 & Up::MoveMouse_detectKey("Up")
F24 & Down::MoveMouse_detectKey("Down")



;F24 & `::return		;;输入法占用
F24 & 1::return			;
F24 & 2::return		
F24 & 3::return		
F24 & 4::return		
F24 & 5::Func_F24_5()		
F24 & 6::return			;
F24 & 7::return			;
F24 & 8::Func_F24_8()	;
F24 & 9::Func_F24_9()	;
F24 & 0::return	;
F24 & -::SwitchRemapMinusToUnderline()	;
F24 & =::return	;

F24 & [::return	;        "	""	"
F24 & ]::return	;
F24 & \::return	;		;
F24 & `;::return		;
F24 & '::return	;
F24 & ,::return		;
F24 & .::SwitchPunctuationMode() ;* CapsLock+. 中英标点
F24 & /::Func_F24_Slash()		;

F24 & a::CopyTextAndSearch("Baidu")
F24 & b::CopyTextAndSearch("Bing")	;F24+C 复制当前选中文本并网上搜索, 如果选中的是链接则打开链接
F24 & c::Send, ^{c} ;* 复制
F24 & d::Run, D:\
F24 & e::return	;
F24 & f::return	;
F24 & g::CopyTextAndSearch("Google")
F24 & h::return	;
F24 & i::SendDirectionKey_detectKey("up")	;		;
F24 & j::SendDirectionKey_detectKey("left")	;
F24 & k::SendDirectionKey_detectKey("down")	;
F24 & l::SendDirectionKey_detectKey("right")
F24 & m::return	;
F24 & n::return	;
F24 & o::return	;		;
F24 & p::return	; 
F24 & q::ForceMoveWindowToCenter_detectShiftKey()	;
F24 & r::return	;
F24 & s::Run, C:\
F24 & t::SetWindowOnTopOrTransparency_detectKey("Toggle") ;窗口置顶切换或窗口透明度重置
F24 & u::Func_F24_U()	;* 大小写切换
F24 & v::Func_F24_V()	;* 粘贴
F24 & w::ShowCurrentWindowInformation()	;*查看窗口信息
F24 & x::Send, ^{x}	;* 剪切
F24 & y::ShiftCaseForSelectedText(2)	;*首字母大写		;
F24 & z::return	;	


;*===== Caps+"-" 交换减号和下划线, 仅在 rAlt 模式为 1 时有效
#If flag_remapMinusToUnderline == 1 && rAltMode == 1
	-::SendBypassIME("_")
	+-::SendBypassIME("-")
#If

;* ================ RAlt+鼠标滚轮 横向滚动, 加 Shift 更快速

F23 & WheelDown::	;* Right
	if (GetKeyState("Shift")){
		MouseWheelScroll("right", g_MouseQuickScrollUnit, 1)
	}else{
		MouseWheelScroll("right", 1, 1)
	}
return


F23 & WheelUp::		;* Left
	if (GetKeyState("Shift")){
		MouseWheelScroll("left", g_MouseQuickScrollUnit, 1)
	}else{
		MouseWheelScroll("left", 1, 1)
	}
return



;* ================ Caps+鼠标滚轮  加速纵向滚动, 加 Shift 更快速
F24 & WheelDown::
	if (GetKeyState("Shift")){
		MouseWheelScroll("down", g_MouseSuperScrollUnit, 1)
	}else{
		MouseWheelScroll("down", g_MouseQuickScrollUnit, 1)
	}
return
F24 & WheelUp::
	if (GetKeyState("Shift")){
		MouseWheelScroll("up", g_MouseSuperScrollUnit, 1)
	}else{
		MouseWheelScroll("up", g_MouseQuickScrollUnit, 1)
	}
return





;*==========


Func_F24_U() ;* 选中文本大小写切换
{
	if (GetKeyState("Shift")){
		ShiftCaseForSelectedText(1)
	}else{
		ShiftCaseForSelectedText(0)
	}	
}



Func_F24_V() ;* 高级粘贴
{
	if (GetKeyState("Shift")){
		AdvancedPaste()	; 参见说明, 粘贴时去换行, 解引号, 如果是网址则提取域名粘贴
	}else{
		PasteWithoutFormat() ; 去格式粘贴
	}
}


Func_F24_9()
{
	if (GetKeyState("Shift")){
		QuoteSelectedString("(**)")
	}else{
		QuoteSelectedString("()")
	}	
}

Func_F24_LeftSquare()
{
	if (GetKeyState("Shift")){
		QuoteSelectedString("{}")
	}else{
		QuoteSelectedString("[]")
	}	
}

Func_F24_Slash()
{
	if (GetKeyState("Shift")){
		QuoteSelectedString("/**/")
	}else{
		CommentSingleLine()
	}	
}

Func_F24_5()
{
	if (GetKeyState("Shift")){
		
	}else{
		QuoteSelectedString("%%")
	}		
}

Func_F24_8()
{
	if (GetKeyState("Shift")){
		QuoteSelectedString("****")
	}else{
		QuoteSelectedString("**")
	}		
}

#If ;GSB_IsInMainScript == 1


