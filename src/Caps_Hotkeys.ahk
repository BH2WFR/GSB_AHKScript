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
F24 & 2::
	;MsgBox, shabi
	ChangeIMEmode()
return

;* Ctrl+CapsLock 切换大小写锁定
^F24::
	if(GetKeyState("CapsLock", "T") = 1){
		SetCapsLockState, Off
	}else{
		SetCapsLockState, On
	}
return
		
		
#If use_RimeInput == 1	; 仅适用于魔改快捷键的小狼毫输入法
	#If rime_KeymapChanged == 0
		; CapsLock+Space 调出小狼毫菜单
		F24 & Space::
		F24 & `::
			Send, ^``	;注意通配符, grave 是 两个``
		return
		; CapsLock+3 全角/半角
		F24 & 3::
			Send, ^+{3}
		return
		; CapsLock+4 简繁体转换
		F24 & 4::
			Send, ^+{4}
		return
		; CapsLock+5 增廣字集
		F24 & 5::
			Send, ^+{5}
		return		
		; CapsLock+. 中英标点
		F24 & .::
			
		return
	#If rime_KeymapChanged == 1	;* 魔改快捷键后
		; CapsLock+Space 调出小狼毫菜单
		F24 & Space::
		F24 & `::
			Send, {F20}	;注意通配符, grave 是 两个``
		return
		F24 & 1::
			Send, +{F20}
		return
		; CapsLock+3 全角/半角
		F24 & 3::
			Send, ^+{F20}
		return
		; CapsLock+4 简繁体转换
		F24 & 4::
			Send, ^+{F21}
		return
		; CapsLock+5 增廣字集
		F24 & 5::
			Send, +{F21}
		return		
		; CapsLock+. 中英标点
		F24 & .::
			Send, ^{F21}
		return		
	#If
#If

;* 高级粘贴
F24 & v::
	if (GetKeyState("Shift")){
		AdvancedPaste()	; 参见说明, 粘贴时去换行, 解引号, 如果是网址则提取域名粘贴
	}else{
		PasteWithoutFormat() ; 去格式粘贴
	}
return

;*================== 其余 F24（CapsLock）组合快捷键, 用掉一个注释一个 =============

F24 & Esc::ReleaseShiftCtrlAltKeys() ; 释放 Shift，Ctrl，和 Alt 按键
F24 & F1::return	
F24 & F2::return
F24 & F3::return
F24 & F4::return
F24 & F5::return
F24 & F6::return
F24 & F7::return
F24 & F8::return
F24 & F9::return
F24 & F10::return
F24 & F11::return
F24 & F12::return
F24 & PrintScreen::return
F24 & ScrollLock::return
F24 & Home::return
F24 & End::return
F24 & PgUp::return
F24 & PgDn::return
F24 & Delete::return	

F24 & Tab::return		;
;F24 & CapsLock::return	;无效组合
;F24 & Space::return	;输入法占用
F24 & Enter::return		;
F24 & Backspace::Send, {Left}{Backspace}{Right}	;* 删除二字词的第一个字


;F24 & `::return		;
F24 & 1::return			;
;F24 & 2::return		;输入法占用
;F24 & 3::return		;输入法占用
;F24 & 4::return		;输入法占用
;F24 & 5::return		;输入法占用
F24 & 6::return			;
F24 & 7::return			;
F24 & 8::return	;
F24 & 9::return	;
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
F24 & /::return		;

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
F24 & t::Run, TaskMgr.exe	; 打开任务管理器
F24 & u::return	;
;F24 & v::Send, ^{v}	;* 粘贴
F24 & w::return	;
F24 & x::Send, ^{x}	;* 剪切
F24 & y::return	;		;
F24 & z::return	;	

;*===== Caps+"-" 交换减号和下划线
#If flag_remapMinusToUnderline == 1
	-::SendBypassIME("_")
	+-::SendBypassIME("-")
#If
