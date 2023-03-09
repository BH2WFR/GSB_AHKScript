; encoding: UTF-8 with BOM


;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

#If GSB_IsInMainScript == 1

;*   =========================== 1 编程(C++代码块)模式 =================================
#If rAltMode == 1
	
	F23 & Space::SendSymbolByCase("_", "　")
	;F23 & Enter::return
	;F23 & BackSpace::return
	
	F23 & Tab::SendTabs_detectShiftKey()
	
	F23 & `::SendSymbolByCase("``", "~")
	F23 & 1::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("!")
		}
	return
	F23 & 2::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("@")
		}
	return
	F23 & 3::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("#")
		}
	return
	F23 & 4::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("$")
		}
	return
	F23 & 5::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("%")
		}
	return	
	F23 & 6::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("^")
		}
	return
	F23 & 7::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("&")
		}
	return
	F23 & 8::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("*")
		}
	return
	F23 & 9::SendPairedSymbles_detectShiftKeys("()", "()")
	F23 & 0::return
	
	F23 & -::SendSymbolByCase("->", "_")
	F23 & =::SendSymbolByCase(":=", "")
	
	F23 & [::SendPairedSymbles_detectShiftKeys("[]", "{}")
	F23 & ]::SendIntendedBraces_detectShiftKey()
	F23 & \::SendSymbolByCase("\", "|")	
	F23 & `;::SendSymbolByCase(";", ":")
	F23 & '::SendPairedSymbles_detectShiftKeys("''", """""")
	F23 & ,::SendSymbolByCase(",", "<")
	F23 & .::SendSymbolByCase(".", ">")
	F23 & /::SendSymbolByCase("/", "?")
	
	F23 & a::return
	F23 & b::return
	F23 & c::return
	F23 & d::return
	F23 & e::SendSymbolByCase("...", "…")
	F23 & f::return
	F23 & g::return
	F23 & h::SendCppSourceTemplate_detectShiftKey()
	F23 & i::SendDirectionKey_detectKey("Up")
	F23 & j::SendDirectionKey_detectKey("Left")
	F23 & k::SendDirectionKey_detectKey("Down")
	F23 & l::SendDirectionKey_detectKey("Right")
	F23 & m::return
	F23 & n::return
	F23 & o::return
	F23 & p::return
	F23 & q::SendPairedSymbles_detectShiftKeys("‹›", "«»")
	F23 & r::return
	F23 & s::return
	F23 & t::return
	F23 & u::return
	F23 & v::return
	F23 & w::return
	F23 & x::return
	F23 & y::return
	F23 & z::return
	
	F23 & Right::MoveMouse_detectKey()
	F23 & Left::MoveMouse_detectKey()
	F23 & Up::MoveMouse_detectKey()
	F23 & Down::MoveMouse_detectKey()
	
	
#If




SendIntendedBraces_detectShiftKey()
{
	if (GetKeyState("Shift")){
		SendCodeBlock("{}")
	}else{
		SendCodeBlock("[]")
	}	
}

SendTabs_detectShiftKey()
{
	if (GetKeyState("Shift")){		
		SendByClipboard("	")
	}else{
		Send, {Space 4}
	}	
}

SendRawTabs_detectShiftKey()
{
	if (GetKeyState("Shift")){		
		
	}else{
		IndentSelectedString()
	}	
}

SendCppSourceTemplate_detectShiftKey()
{
	if (GetKeyState("Shift")){
		SendCppSourceTemplate()
	}else{
		SendCppHeaderTemplate()
	}		
}

#If ;GSB_IsInMainScript == 1

