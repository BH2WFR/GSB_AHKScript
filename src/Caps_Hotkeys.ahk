; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}



;*======================  输入法 特殊热键, 注意: 要先使用其他软件将 CapsLock 映射为 F24
;GetKeyState("CapsLock", "T") = 1
;SetCapsLockState, on

;* CapsLock 或 CapsLock+2 切换中英文
;F24 Up::
F24::
F24 & F2::
	;MsgBox, shabi
	SwitchIMEmode()
return

;* Shift+CapsLock 切换大小写锁定
+F24::
	SwitchCapsLockStatus(,1)
return

;* Ctrl+CapsLock 释放 Shift Ctrl Alt 并关闭大写锁定
^F24::ReleaseShiftCtrlAltKeys(1,1)

		
#If use_RimeInput == 1	; 仅适用于魔改快捷键的小狼毫输入法
	#If rime_KeymapChanged == 0
		; CapsLock+Space 调出小狼毫菜单
		F24 & Space::
		F24 & `::
			Send, ^``	;注意通配符, grave 是 两个``
		return
		; CapsLock+3 全角/半角
		F24 & F1::return	
		;F24 & F2::return
		
		F24 & F3::SwitchFullHalfShapeMode()

		; CapsLock+4 简繁体转换
		F24 & F4::SwitchChineseSimplicatedMode()
		
		; CapsLock+5 增廣字集
		F24 & F5::
			Send, ^+{5}
		return		
		; CapsLock+. 中英标点
		F24 & .::
			SwitchPunctuationMode()
		return
	#If rime_KeymapChanged == 1	;* 魔改快捷键后
		; CapsLock+Space 调出小狼毫菜单
		F24 & Space::
		F24 & `::
			Send, {F20}	;注意通配符, grave 是 两个``
		return
		F24 & F1::
			Send, +{F20}
		return
		;F24 & F2::return
		
		; CapsLock+3 全角/半角
		F24 & F3::SwitchFullHalfShapeMode()
		
		; CapsLock+4 简繁体转换
		F24 & F4::SwitchChineseSimplicatedMode()
		
		; CapsLock+5 增廣字集
		F24 & F5::
			Send, +{F21}
		return		
		; CapsLock+. 中英标点
		F24 & .::
			SwitchPunctuationMode()
		return		
	#If
#If



;*================== 其余 F24（CapsLock）组合快捷键, 用掉一个注释一个 =============

F24 & Esc::ShowSettingsGUI() ; 设置
;F24 & F1::return	;输入法占用
;F24 & F2::return	;输入法占用
;F24 & F3::return	;输入法占用
;F24 & F4::return	;输入法占用
;F24 & F5::return	;输入法占用
F24 & F6::return
F24 & F7::return
F24 & F8::return
F24 & F9::return
F24 & F10::return
F24 & F11::return
F24 & F12::return
F24 & PrintScreen::return
F24 & ScrollLock::return
F24 & Home::DeleteAndroidEvents()
F24 & End::return
F24 & PgUp::return
F24 & PgDn::return
F24 & Delete::DeleteComputerPersonalData()

F24 & Tab::SendRawTabs_detectShiftKey()		;
;F24 & CapsLock::return	;无效组合
;F24 & Space::return	;输入法占用
F24 & Enter::return		;
F24 & Backspace::Send, {Left}{Backspace}{Right}	;* 删除二字词的第一个字


;F24 & `::return		;
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
F24 & .::return		;
F24 & /::Func_F24_Slash()		;

F24 & a::CopyTextAndSearch("Baidu")
F24 & b::CopyTextAndSearch("Bing")	;F24+C 复制当前选中文本并网上搜索, 如果选中的是链接则打开链接
F24 & c::Send, ^{c} ;* 复制
F24 & d::Run, D:\
F24 & e::return	;
F24 & f::return	;
F24 & g::CopyTextAndSearch("Google")
F24 & h::return	;
F24 & i::SendDirectionKey_getShiftStatus("up")	;		;
F24 & j::SendDirectionKey_getShiftStatus("left")	;
F24 & k::SendDirectionKey_getShiftStatus("down")	;
F24 & l::SendDirectionKey_getShiftStatus("right")
F24 & m::return	;
F24 & n::return	;
F24 & o::return	;		;
F24 & p::return	; 
F24 & q::return	;
F24 & r::return	;
F24 & s::Run, C:\
F24 & t::return
F24 & u::return	;
F24 & v::Func_F24_V()	;* 粘贴
F24 & w::return	;
F24 & x::Send, ^{x}	;* 剪切
F24 & y::return	;		;
F24 & z::return	;	


;*===== Caps+"-" 交换减号和下划线, 仅在 rAlt 模式为 1 时有效
#If flag_remapMinusToUnderline == 1 && rAltMode == 1
	-::SendBypassIME("_")
	+-::SendBypassIME("-")
#If


;*==========


SendDirectionKey_getShiftStatus(ByRef dir, quickSteps := 5)
{
	if (GetKeyState("Shift")){
		SendDirectionKey(dir, quickSteps)
	}else{
		SendDirectionKey(dir, 1)
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