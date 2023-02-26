; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}


;*   ============================= 2 统一字母输入模式 ===============================
#If rAltMode == 2

	F23 & CapsLock::return
	F23 & Space::return
	;F23 & Enter::return
	;F23 & BackSpace::return
	
	F23 & Tab::SendTabs_detectShiftKey()
	
	F23 & `::return
	
	F23 & 1::SendSymbolByCase("", "")
	F23 & 2::SendSymbolByCase("", "")
	F23 & 3::SendSymbolByCase("", "")
	F23 & 4::SendSymbolByCase("", "")
	F23 & 5::SendSymbolByCase("", "")	
	F23 & 6::SendSymbolByCase("", "")
	F23 & 7::SendSymbolByCase("", "")
	F23 & 8::SendSymbolByCase("", "")
	F23 & 9::SendSymbolByCase("", "")
	F23 & 0::SendSymbolByCase("", "")
	
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
	
	F23 & a::SendSymbolByCase("ä", "Ä")
	F23 & b::SendSymbolByCase("", "")
	F23 & c::SendSymbolByCase("ĉ", "Ĉ")
	F23 & d::SendSymbolByCase("đ", "Đ")
	F23 & e::SendSymbolByCase("ĕ", "Ĕ")
	F23 & f::SendSymbolByCase("", "")
	F23 & g::SendSymbolByCase("ĝ", "Ĝ")
	F23 & h::SendSymbolByCase("ğ", "Ğ")
	F23 & i::SendSymbolByCase("ï", "Ï")
	F23 & j::SendSymbolByCase("ĵ", "Ĵ")
	F23 & k::SendSymbolByCase("", "")
	F23 & l::SendSymbolByCase("ł", "Ł")
	F23 & m::SendSymbolByCase("", "")
	F23 & n::SendSymbolByCase("ņ", "Ņ")
	F23 & o::SendSymbolByCase("ö", "Ö")
	F23 & p::SendSymbolByCase("", "")
	F23 & q::SendSymbolByCase("", "")
	F23 & r::SendSymbolByCase("", "")
	F23 & s::SendSymbolByCase("ŝ", "Ŝ")
	F23 & t::SendSymbolByCase("", "")
	F23 & u::SendSymbolByCase("ü", "Ü")
	F23 & v::SendSymbolByCase("ŭ", "Ŭ")
	F23 & w::SendSymbolByCase("ẅ", "Ẅ")
	F23 & x::SendSymbolByCase("ẍ", "Ẍ")
	F23 & y::SendSymbolByCase("", "")
	F23 & z::SendSymbolByCase("ẑ", "Ẑ")
	
#If

