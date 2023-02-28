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
	
	F23 & a::SendSymbolByCaseAndCaps("ä", "Ä")
	F23 & b::SendSymbolByCaseAndCaps("", "")
	F23 & c::SendSymbolByCaseAndCaps("ĉ", "Ĉ")
	F23 & d::SendSymbolByCaseAndCaps("đ", "Đ")
	F23 & e::SendSymbolByCaseAndCaps("ĕ", "Ĕ")
	F23 & f::SendSymbolByCaseAndCaps("", "")
	F23 & g::SendSymbolByCaseAndCaps("ĝ", "Ĝ")
	F23 & h::SendSymbolByCaseAndCaps("ğ", "Ğ")
	F23 & i::SendSymbolByCaseAndCaps("ï", "Ï")
	F23 & j::SendSymbolByCaseAndCaps("ĵ", "Ĵ")
	F23 & k::SendSymbolByCaseAndCaps("", "")
	F23 & l::SendSymbolByCaseAndCaps("ł", "Ł")
	F23 & m::SendSymbolByCaseAndCaps("ñ", "Ñ")
	F23 & n::SendSymbolByCaseAndCaps("ņ", "Ņ")
	F23 & o::SendSymbolByCaseAndCaps("ö", "Ö")
	F23 & p::SendSymbolByCaseAndCaps("", "")
	F23 & q::SendSymbolByCaseAndCaps("", "")
	F23 & r::SendSymbolByCaseAndCaps("", "")
	F23 & s::SendSymbolByCaseAndCaps("ŝ", "Ŝ")
	F23 & t::SendSymbolByCaseAndCaps("", "")
	F23 & u::SendSymbolByCaseAndCaps("ü", "Ü")
	F23 & v::SendSymbolByCaseAndCaps("ŭ", "Ŭ")
	F23 & w::SendSymbolByCaseAndCaps("ẅ", "Ẅ")
	F23 & x::SendSymbolByCaseAndCaps("ẍ", "Ẍ")
	F23 & y::SendSymbolByCaseAndCaps("", "")
	F23 & z::SendSymbolByCaseAndCaps("ẑ", "Ẑ")
	
	
	
	

	$- Up::SendBypassIME("-")
	^-::Send, ^{-}
	^+-::Send, ^+{-}
	; - & a::SendSymbolByCaseAndCaps("ä", "Ä")
	; - & b::SendSymbolByCaseAndCaps("", "")
	; - & c::SendSymbolByCaseAndCaps("ĉ", "Ĉ")
	; - & d::SendSymbolByCaseAndCaps("đ", "Đ")
	; - & e::SendSymbolByCaseAndCaps("ĕ", "Ĕ")
	; - & f::SendSymbolByCaseAndCaps("", "")
	; - & g::SendSymbolByCaseAndCaps("ĝ", "Ĝ")
	; - & h::SendSymbolByCaseAndCaps("ğ", "Ğ")
	; - & i::SendSymbolByCaseAndCaps("ï", "Ï")
	; - & j::SendSymbolByCaseAndCaps("ĵ", "Ĵ")
	; - & k::SendSymbolByCaseAndCaps("", "")
	; - & l::SendSymbolByCaseAndCaps("ł", "Ł")
	; - & m::SendSymbolByCaseAndCaps("ñ", "Ñ")
	; - & n::SendSymbolByCaseAndCaps("ņ", "Ņ")
	; - & o::SendSymbolByCaseAndCaps("ö", "Ö")
	; - & p::SendSymbolByCaseAndCaps("", "")
	; - & q::SendSymbolByCaseAndCaps("", "")
	; - & r::SendSymbolByCaseAndCaps("", "")
	; - & s::SendSymbolByCaseAndCaps("ŝ", "Ŝ")
	; - & t::SendSymbolByCaseAndCaps("", "")
	; - & u::SendSymbolByCaseAndCaps("ü", "Ü")
	; - & v::SendSymbolByCaseAndCaps("ŭ", "Ŭ")
	; - & w::SendSymbolByCaseAndCaps("ẅ", "Ẅ")
	; - & x::SendSymbolByCaseAndCaps("ẍ", "Ẍ")
	; - & y::SendSymbolByCaseAndCaps("", "")
	; - & z::SendSymbolByCaseAndCaps("ẑ", "Ẑ")
	
	- & a::SendSymbolByCaseAndCaps("ā", "Ā")
	- & e::SendSymbolByCaseAndCaps("ē", "Ē")	
	- & i::SendSymbolByCaseAndCaps("ī", "Ī")	
	- & o::SendSymbolByCaseAndCaps("ō", "Ō")	
	- & u::SendSymbolByCaseAndCaps("ū", "Ū")	
	- & y::SendSymbolByCaseAndCaps("ȳ", "Ȳ")
	- & v::SendSymbolByCaseAndCaps("ʉ", "Ʉ")
	- & w::SendSymbolByCaseAndCaps("ɵ", "Ɵ")
	- & s::SendSymbolByCaseAndCaps("ß", "ẞ")
	- & c::SendSymbolByCaseAndCaps("ħ", "Ħ")
	- & h::SendSymbolByCaseAndCaps("ꞓ", "Ꞓ")	
	- & d::SendSymbolByCaseAndCaps("đ", "Ɖ")
	- & j::SendSymbolByCaseAndCaps("ɉ", "Ɉ")
	- & z::SendSymbolByCaseAndCaps("ƶ", "Ƶ")
	- & p::SendSymbolByCaseAndCaps("ꝑ", "Ꝑ")
	- & t::SendSymbolByCaseAndCaps("ŧ", "Ŧ")
	- & k::SendSymbolByCaseAndCaps("ꝁ", "Ꝁ")
	
	$/ Up::Send, {/}
	+/::Send, {?}
	^/::Send, ^{/}
	^+/::Send, ^+{/}
	/ & a::SendSymbolByCaseAndCaps("á", "Á")
	/ & e::SendSymbolByCaseAndCaps("é", "É")	
	/ & i::SendSymbolByCaseAndCaps("í", "Í")	
	/ & o::SendSymbolByCaseAndCaps("ó", "Ó")	
	/ & u::SendSymbolByCaseAndCaps("ú", "Ú")	
	/ & y::SendSymbolByCaseAndCaps("ý", "Ý")	
	/ & c::SendSymbolByCaseAndCaps("ć", "Ć")	
	/ & g::SendSymbolByCaseAndCaps("ǵ", "Ǵ")	
	/ & n::SendSymbolByCaseAndCaps("ń", "Ń")	
	/ & r::SendSymbolByCaseAndCaps("ŕ", "Ŕ")	
	/ & s::SendSymbolByCaseAndCaps("ś", "Ś")	
	/ & w::SendSymbolByCaseAndCaps("ẃ", "Ẃ")	
	/ & z::SendSymbolByCaseAndCaps("ź", "Ź")	

	$` Up::Send, ``
	+`::Send, {~}
	^`::Send, ^{`}
	^+`::Send, ^+{`}
	` & a::SendSymbolByCaseAndCaps("ã", "Ấ")
	` & e::SendSymbolByCaseAndCaps("ẽ", "Ẽ")
	` & i::SendSymbolByCaseAndCaps("ĩ", "Ĩ")
	` & o::SendSymbolByCaseAndCaps("õ", "Õ")
	` & u::SendSymbolByCaseAndCaps("ũ", "Ũ")
	` & y::SendSymbolByCaseAndCaps("ỹ", "Ỹ")
	` & n::SendSymbolByCaseAndCaps("ñ", "Ñ")
	` & v::SendSymbolByCaseAndCaps("ṽ", "Ṽ")
	
	$= Up::Send, {=}
	+=::Send, {+}
	^=::Send, ^{=}
	^+=::Send, ^+{=}
	= & a::SendSymbolByCaseAndCaps("ǟ", "Ǟ")	
	= & o::SendSymbolByCaseAndCaps("ȫ", "Ȫ")
	= & u::SendSymbolByCaseAndCaps("ǖ", "Ǖ")
	= & e::SendSymbolByCaseAndCaps("ǣ", "Ǣ")
	= & i::SendSymbolByCaseAndCaps("ı", "İ")
	= & w::SendSymbolByCaseAndCaps("œ", "Œ")
	= & j::SendSymbolByCaseAndCaps("ȷ", "")
	= & b::SendSymbolByCaseAndCaps("ɓ", "Ɓ")
	= & d::SendSymbolByCaseAndCaps("ð", "Ð")
	= & t::SendSymbolByCaseAndCaps("þ", "Þ")
	= & f::SendSymbolByCaseAndCaps("ƒ", "")
	= & z::SendSymbolByCaseAndCaps("ʒ", "Ʒ")
	= & s::SendSymbolByCaseAndCaps("ſ", "Ʃ")
	= & n::SendSymbolByCaseAndCaps("ŋ", "Ŋ")
	
	$\ Up::Send, {\}
	+\::Send, {|}
	^\::Send, ^{\}
	^+\::Send, ^+{\}
	\ & a::	SendSymbolByCaseAndCaps("à", "À")
	\ & e::	SendSymbolByCaseAndCaps("è", "È")
	\ & i::	SendSymbolByCaseAndCaps("ì", "Ì")
	\ & o::	SendSymbolByCaseAndCaps("ò", "Ò")
	\ & u::	SendSymbolByCaseAndCaps("ù", "Ù")
	\ & y::	SendSymbolByCaseAndCaps("ỳ", "Ỳ")
	\ & n::	SendSymbolByCaseAndCaps("ǹ", "Ǹ")
	\ & w::	SendSymbolByCaseAndCaps("ẁ", "Ẁ")
	
	$6 Up::Send, {6}
	+6::Send, {^}	
	^+6::Send, ^+{6}
	6 & a::SendSymbolByCaseAndCaps("â", "Â")
	
	$. Up::Send, {.}
	+.::Send, {<}	
	^.::Send, ^{.}
	^+.::Send, ^+{.}
	. & c::SendSymbolByCaseAndCaps("ç", "Ç")
	. & e::SendSymbolByCaseAndCaps("ȩ", "Ȩ")
	. & s::SendSymbolByCaseAndCaps("ş", "Ş")	
#If

