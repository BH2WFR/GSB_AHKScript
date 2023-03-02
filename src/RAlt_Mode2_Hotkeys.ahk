; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}


;*   ============================= 2 统一字母输入模式 ===============================
#If rAltMode == 2

	
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
	
	
; ;*=================  模板 误删 ================
; ; *===   "=" + 字母  
; 	$- Up::Send, {-}
; 	+-::Send, {_}
; 	^-::Send, ^{-}
; 	^+-::Send, ^+{-}
	; - & Space::SendSymbolByCaseAndCaps("", "")
	; - & a::SendSymbolByCaseAndCaps("", "")
	; - & b::SendSymbolByCaseAndCaps("", "")
	; - & c::SendSymbolByCaseAndCaps("", "")
	; - & d::SendSymbolByCaseAndCaps("", "")
	; - & e::SendSymbolByCaseAndCaps("", "")
	; - & f::SendSymbolByCaseAndCaps("", "")
	; - & g::SendSymbolByCaseAndCaps("", "")
	; - & h::SendSymbolByCaseAndCaps("", "")
	; - & i::SendSymbolByCaseAndCaps("", "")
	; - & j::SendSymbolByCaseAndCaps("", "")
	; - & k::SendSymbolByCaseAndCaps("", "")
	; - & l::SendSymbolByCaseAndCaps("", "")
	; - & m::SendSymbolByCaseAndCaps("", "")
	; - & n::SendSymbolByCaseAndCaps("", "")
	; - & o::SendSymbolByCaseAndCaps("", "")
	; - & p::SendSymbolByCaseAndCaps("", "")
	; - & q::SendSymbolByCaseAndCaps("", "")
	; - & r::SendSymbolByCaseAndCaps("", "")
	; - & s::SendSymbolByCaseAndCaps("", "")
	; - & t::SendSymbolByCaseAndCaps("", "")
	; - & u::SendSymbolByCaseAndCaps("", "")
	; - & v::SendSymbolByCaseAndCaps("", "")
	; - & w::SendSymbolByCaseAndCaps("", "")
	; - & x::SendSymbolByCaseAndCaps("", "")
	; - & y::SendSymbolByCaseAndCaps("", "")
	; - & z::SendSymbolByCaseAndCaps("", "")
	
;*===============  使用：-/\~.^'
; *===   ";" + 字母  
	$`; Up::Send, {`;}
	+`;::Send, {:}
	^`;::Send, ^{`;}
	^+`;::Send, ^+{`;}
	`; & Space::SendSymbolByCaseAndCaps("̈", "")  ; 已添加 ä 
	`; & a::SendSymbolByCaseAndCaps("ä", "Ä")
	`; & b::SendSymbolByCaseAndCaps("", "")
	`; & c::SendSymbolByCaseAndCaps("", "")
	`; & d::SendSymbolByCaseAndCaps("", "")
	`; & e::SendSymbolByCaseAndCaps("ë", "Ë")
	`; & f::SendSymbolByCaseAndCaps("", "")
	`; & g::SendSymbolByCaseAndCaps("", "")
	`; & h::SendSymbolByCaseAndCaps("", "")
	`; & i::SendSymbolByCaseAndCaps("ï", "Ï")
	`; & j::SendSymbolByCaseAndCaps("", "")
	`; & k::SendSymbolByCaseAndCaps("", "")
	`; & l::SendSymbolByCaseAndCaps("", "")
	`; & m::SendSymbolByCaseAndCaps("", "")
	`; & n::SendSymbolByCaseAndCaps("", "")
	`; & o::SendSymbolByCaseAndCaps("ö", "Ö")
	`; & p::SendSymbolByCaseAndCaps("", "")
	`; & q::SendSymbolByCaseAndCaps("", "")
	`; & r::SendSymbolByCaseAndCaps("", "")
	`; & s::SendSymbolByCaseAndCaps("ß", "ẞ")
	`; & t::SendSymbolByCaseAndCaps("", "")
	`; & u::SendSymbolByCaseAndCaps("ü", "Ü")
	`; & v::SendSymbolByCaseAndCaps("", "")
	`; & w::SendSymbolByCaseAndCaps("ẅ", "Ẅ")
	`; & x::SendSymbolByCaseAndCaps("ẍ", "Ẍ")
	`; & y::SendSymbolByCaseAndCaps("ÿ", "Ÿ")
	`; & z::SendSymbolByCaseAndCaps("", "")
	
		
;*===   "-" + 字母  ā a̅
	$- Up::SendBypassIME("-")
	^-::Send, ^{-}
	^+-::Send, ^+{-}
	- & Space::SendSymbolByCaseAndCaps("̄", "")
	- & a::SendSymbolByCaseAndCaps("ā", "Ā")
	- & b::SendSymbolByCaseAndCaps("", "")
	- & c::SendSymbolByCaseAndCaps("ꞓ", "Ꞓ")
	- & d::SendSymbolByCaseAndCaps("đ", "Ɖ")
	- & e::SendSymbolByCaseAndCaps("ē", "Ē")
	- & f::SendSymbolByCaseAndCaps("", "")
	- & g::SendSymbolByCaseAndCaps("", "")
	- & h::SendSymbolByCaseAndCaps("ħ", "Ħ")
	- & i::SendSymbolByCaseAndCaps("ī", "Ī")
	- & j::SendSymbolByCaseAndCaps("ɉ", "Ɉ")
	- & k::SendSymbolByCaseAndCaps("ꝁ", "Ꝁ")
	- & l::SendSymbolByCaseAndCaps("", "")
	- & m::SendSymbolByCaseAndCaps("", "")
	- & n::SendSymbolByCaseAndCaps("", "")
	- & o::SendSymbolByCaseAndCaps("ō", "Ō")
	- & p::SendSymbolByCaseAndCaps("ꝑ", "Ꝑ")
	- & q::SendSymbolByCaseAndCaps("", "")
	- & r::SendSymbolByCaseAndCaps("", "")
	- & s::SendSymbolByCaseAndCaps("", "")
	- & t::SendSymbolByCaseAndCaps("ŧ", "Ŧ")
	- & u::SendSymbolByCaseAndCaps("ū", "Ū")
	- & v::SendSymbolByCaseAndCaps("ǖ", "Ǖ")
	- & w::SendSymbolByCaseAndCaps("ɵ", "Ɵ")
	- & x::SendSymbolByCaseAndCaps("", "")
	- & y::SendSymbolByCaseAndCaps("ʉ", "Ʉ")
	- & z::SendSymbolByCaseAndCaps("ƶ", "Ƶ")

	
	
;*===   "/" + 字母  
	$/ Up::Send, {/}
	+/::Send, {?}
	^/::Send, ^{/}
	^+/::Send, ^+{/}
	/ & Space::SendSymbolByCaseAndCaps("́", "")
	/ & a::SendSymbolByCaseAndCaps("á", "Á")
	/ & b::SendSymbolByCaseAndCaps("", "")
	/ & c::SendSymbolByCaseAndCaps("ć", "Ć")
	/ & d::SendSymbolByCaseAndCaps("", "")
	/ & e::SendSymbolByCaseAndCaps("é", "É")
	/ & f::SendSymbolByCaseAndCaps("", "")
	/ & g::SendSymbolByCaseAndCaps("ǵ", "Ǵ")
	/ & h::SendSymbolByCaseAndCaps("", "")
	/ & i::SendSymbolByCaseAndCaps("í", "Í")
	/ & j::SendSymbolByCaseAndCaps("", "")
	/ & k::SendSymbolByCaseAndCaps("", "")
	/ & l::SendSymbolByCaseAndCaps("", "")
	/ & m::SendSymbolByCaseAndCaps("", "")
	/ & n::SendSymbolByCaseAndCaps("ń", "Ń")
	/ & o::SendSymbolByCaseAndCaps("ó", "Ó")
	/ & p::SendSymbolByCaseAndCaps("", "")
	/ & q::SendSymbolByCaseAndCaps("", "")
	/ & r::SendSymbolByCaseAndCaps("ŕ", "Ŕ")
	/ & s::SendSymbolByCaseAndCaps("ś", "Ś")
	/ & t::SendSymbolByCaseAndCaps("", "")
	/ & u::SendSymbolByCaseAndCaps("ú", "Ú")
	/ & v::SendSymbolByCaseAndCaps("ǘ", "Ǘ")
	/ & w::SendSymbolByCaseAndCaps("ẃ", "Ẃ")
	/ & x::SendSymbolByCaseAndCaps("", "")
	/ & y::SendSymbolByCaseAndCaps("ý", "Ý")
	/ & z::SendSymbolByCaseAndCaps("ź", "Ź")



;*===   "`(~)" + 字母  
	$` Up::Send, ``
	+`::Send, {~}
	^`::Send, ^{`}
	^+`::Send, ^+{`}
	` & Space::SendSymbolByCaseAndCaps("̃", "")
	` & a::SendSymbolByCaseAndCaps("ã", "Ấ")
	` & b::SendSymbolByCaseAndCaps("", "")
	` & c::SendSymbolByCaseAndCaps("", "")
	` & d::SendSymbolByCaseAndCaps("", "")
	` & e::SendSymbolByCaseAndCaps("ẽ", "Ẽ")
	` & f::SendSymbolByCaseAndCaps("", "")
	` & g::SendSymbolByCaseAndCaps("", "")
	` & h::SendSymbolByCaseAndCaps("", "")
	` & i::SendSymbolByCaseAndCaps("ĩ", "Ĩ")
	` & j::SendSymbolByCaseAndCaps("", "")
	` & k::SendSymbolByCaseAndCaps("", "")
	` & l::SendSymbolByCaseAndCaps("", "")
	` & m::SendSymbolByCaseAndCaps("", "")
	` & n::SendSymbolByCaseAndCaps("ñ", "Ñ")
	` & o::SendSymbolByCaseAndCaps("õ", "Õ")
	` & p::SendSymbolByCaseAndCaps("", "")
	` & q::SendSymbolByCaseAndCaps("", "")
	` & r::SendSymbolByCaseAndCaps("", "")
	` & s::SendSymbolByCaseAndCaps("", "")
	` & t::SendSymbolByCaseAndCaps("", "")
	` & u::SendSymbolByCaseAndCaps("ũ", "Ũ")
	` & v::SendSymbolByCaseAndCaps("ṽ", "Ṽ")
	` & w::SendSymbolByCaseAndCaps("", "")
	` & x::SendSymbolByCaseAndCaps("", "")
	` & y::SendSymbolByCaseAndCaps("ỹ", "Ỹ")
	` & z::SendSymbolByCaseAndCaps("", "")

	
;*===   "=" + 字母  
	$= Up::Send, {=}
	+=::Send, {+}
	^=::Send, ^{=}
	^+=::Send, ^+{=}
	= & Space::SendSymbolByCaseAndCaps("̄̈", "")
	= & a::SendSymbolByCaseAndCaps("ǟ", "Ǟ")
	= & b::SendSymbolByCaseAndCaps("ɓ", "Ɓ")
	= & c::SendSymbolByCaseAndCaps("", "")
	= & d::SendSymbolByCaseAndCaps("ð", "Ð")
	= & e::SendSymbolByCaseAndCaps("ǣ", "Ǣ")
	= & f::SendSymbolByCaseAndCaps("ƒ", "")
	= & g::SendSymbolByCaseAndCaps("", "")
	= & h::SendSymbolByCaseAndCaps("", "")
	= & i::SendSymbolByCaseAndCaps("ı", "İ")
	= & j::SendSymbolByCaseAndCaps("ȷ", "")
	= & k::SendSymbolByCaseAndCaps("", "")
	= & l::SendSymbolByCaseAndCaps("", "")
	= & m::SendSymbolByCaseAndCaps("", "")
	= & n::SendSymbolByCaseAndCaps("ŋ", "Ŋ")
	= & o::SendSymbolByCaseAndCaps("ȫ", "Ȫ")
	= & p::SendSymbolByCaseAndCaps("", "")
	= & q::SendSymbolByCaseAndCaps("", "")
	= & r::SendSymbolByCaseAndCaps("", "")
	= & s::SendSymbolByCaseAndCaps("ſ", "Ʃ")
	= & t::SendSymbolByCaseAndCaps("þ", "Þ")
	= & u::SendSymbolByCaseAndCaps("ʊ", "Ʊ")
	= & v::SendSymbolByCaseAndCaps("", "")
	= & w::SendSymbolByCaseAndCaps("œ", "Œ")
	= & x::SendSymbolByCaseAndCaps("", "")
	= & y::SendSymbolByCaseAndCaps("", "")
	= & z::SendSymbolByCaseAndCaps("ʒ", "Ʒ")

	
;*===   "\" + 字母  
	$\ Up::Send, {\}
	+\::Send, {|}
	^\::Send, ^{\}
	^+\::Send, ^+{\}
	\ & Space::SendSymbolByCaseAndCaps("̀", "")
	\ & a::SendSymbolByCaseAndCaps("à", "À")
	\ & b::SendSymbolByCaseAndCaps("", "")
	\ & c::SendSymbolByCaseAndCaps("", "")
	\ & d::SendSymbolByCaseAndCaps("", "")
	\ & e::SendSymbolByCaseAndCaps("è", "È")
	\ & f::SendSymbolByCaseAndCaps("", "")
	\ & g::SendSymbolByCaseAndCaps("", "")
	\ & h::SendSymbolByCaseAndCaps("", "")
	\ & i::SendSymbolByCaseAndCaps("ì", "Ì")
	\ & j::SendSymbolByCaseAndCaps("", "")
	\ & k::SendSymbolByCaseAndCaps("", "")
	\ & l::SendSymbolByCaseAndCaps("", "")
	\ & m::SendSymbolByCaseAndCaps("", "")
	\ & n::SendSymbolByCaseAndCaps("ǹ", "Ǹ")
	\ & o::SendSymbolByCaseAndCaps("ò", "Ò")
	\ & p::SendSymbolByCaseAndCaps("", "")
	\ & q::SendSymbolByCaseAndCaps("", "")
	\ & r::SendSymbolByCaseAndCaps("", "")
	\ & s::SendSymbolByCaseAndCaps("", "")
	\ & t::SendSymbolByCaseAndCaps("", "")
	\ & u::SendSymbolByCaseAndCaps("ù", "Ù")
	\ & v::SendSymbolByCaseAndCaps("ǜ", "Ǜ")
	\ & w::SendSymbolByCaseAndCaps("ẁ", "Ẁ")
	\ & x::SendSymbolByCaseAndCaps("", "")
	\ & y::SendSymbolByCaseAndCaps("ỳ", "Ỳ")
	\ & z::SendSymbolByCaseAndCaps("", "")

	
;*===   "6(^)" + 字母  
	$6 Up::Send, {6}
	+6::Send, {^}	
	^6::Send, ^{6}
	^+6::Send, ^+{6}
	6 & Space::SendSymbolByCaseAndCaps("̂", "")
	6 & a::SendSymbolByCaseAndCaps("â", "Â")
	6 & b::SendSymbolByCaseAndCaps("", "")
	6 & c::SendSymbolByCaseAndCaps("ĉ", "Ĉ")
	6 & d::SendSymbolByCaseAndCaps("", "")
	6 & e::SendSymbolByCaseAndCaps("ê", "Ê")
	6 & f::SendSymbolByCaseAndCaps("", "")
	6 & g::SendSymbolByCaseAndCaps("ĝ", "Ĝ")
	6 & h::SendSymbolByCaseAndCaps("ĥ", "Ĥ")
	6 & i::SendSymbolByCaseAndCaps("î", "Î")
	6 & j::SendSymbolByCaseAndCaps("ĵ", "Ĵ")
	6 & k::SendSymbolByCaseAndCaps("", "")
	6 & l::SendSymbolByCaseAndCaps("", "")
	6 & m::SendSymbolByCaseAndCaps("", "")
	6 & n::SendSymbolByCaseAndCaps("", "")
	6 & o::SendSymbolByCaseAndCaps("ô", "Ô")
	6 & p::SendSymbolByCaseAndCaps("", "")
	6 & q::SendSymbolByCaseAndCaps("", "")
	6 & r::SendSymbolByCaseAndCaps("", "")
	6 & s::SendSymbolByCaseAndCaps("ŝ", "Ŝ")
	6 & t::SendSymbolByCaseAndCaps("", "")
	6 & u::SendSymbolByCaseAndCaps("û", "Û")
	6 & v::SendSymbolByCaseAndCaps("", "")
	6 & w::SendSymbolByCaseAndCaps("ŵ", "Ŵ")
	6 & x::SendSymbolByCaseAndCaps("", "")
	6 & y::SendSymbolByCaseAndCaps("ŷ", "Ŷ")
	6 & z::SendSymbolByCaseAndCaps("ẑ", "Ẑ")
	
	
	
;*===   "," + 字母  
	$, Up::Send, {,}
	+,::Send, {<}	
	^,::Send, ^{,}
	^+,::Send, ^+{,}
	, & Space::SendSymbolByCaseAndCaps("̧", "")
	, & a::SendSymbolByCaseAndCaps("ą", "Ą")
	, & b::SendSymbolByCaseAndCaps("", "")
	, & c::SendSymbolByCaseAndCaps("ç", "Ç")
	, & d::SendSymbolByCaseAndCaps("", "")
	, & e::SendSymbolByCaseAndCaps("ȩ", "Ȩ")
	, & f::SendSymbolByCaseAndCaps("ę", "Ę")
	, & g::SendSymbolByCaseAndCaps("", "")
	, & h::SendSymbolByCaseAndCaps("", "")
	, & i::SendSymbolByCaseAndCaps("į", "Į")
	, & j::SendSymbolByCaseAndCaps("", "")
	, & k::SendSymbolByCaseAndCaps("", "")
	, & l::SendSymbolByCaseAndCaps("", "")
	, & m::SendSymbolByCaseAndCaps("", "")
	, & n::SendSymbolByCaseAndCaps("", "")
	, & o::SendSymbolByCaseAndCaps("ǫ", "Ǫ")
	, & p::SendSymbolByCaseAndCaps("", "")
	, & q::SendSymbolByCaseAndCaps("", "")
	, & r::SendSymbolByCaseAndCaps("", "")
	, & s::SendSymbolByCaseAndCaps("ş", "Ş")	
	, & t::SendSymbolByCaseAndCaps("ţ", "Ţ")
	, & u::SendSymbolByCaseAndCaps("ų", "Ų")
	, & v::SendSymbolByCaseAndCaps("", "")
	, & w::SendSymbolByCaseAndCaps("", "")
	, & x::SendSymbolByCaseAndCaps("", "")
	, & y::SendSymbolByCaseAndCaps("", "")
	, & z::SendSymbolByCaseAndCaps("", "")


; *===   "8" + 字母  
	$8 Up::Send, {8}
	+8::Send, {*}
	^8::Send, ^{8}
	^+8::Send, ^+{8}
	8 & Space::SendSymbolByCaseAndCaps("̣", "")
	8 & a::SendSymbolByCaseAndCaps("ạ", "Ạ")
	8 & c::SendSymbolByCaseAndCaps("ḅ", "")
	8 & b::SendSymbolByCaseAndCaps("", "Ḅ")
	8 & d::SendSymbolByCaseAndCaps("ḍ", "Ḍ")
	8 & e::SendSymbolByCaseAndCaps("ẹ", "Ẹ")
	8 & f::SendSymbolByCaseAndCaps("", "")
	8 & g::SendSymbolByCaseAndCaps("", "")
	8 & h::SendSymbolByCaseAndCaps("ḥ", "Ḥ")
	8 & i::SendSymbolByCaseAndCaps("ị", "Ị")
	8 & j::SendSymbolByCaseAndCaps("", "")
	8 & k::SendSymbolByCaseAndCaps("ḳ", "Ḳ")
	8 & l::SendSymbolByCaseAndCaps("ḷ", "Ḷ")
	8 & m::SendSymbolByCaseAndCaps("ṃ", "Ṃ")
	8 & n::SendSymbolByCaseAndCaps("ṇ", "Ṇ")
	8 & o::SendSymbolByCaseAndCaps("ọ", "Ọ")
	8 & p::SendSymbolByCaseAndCaps("", "")
	8 & q::SendSymbolByCaseAndCaps("", "")
	8 & r::SendSymbolByCaseAndCaps("ṛ", "Ṛ")
	8 & s::SendSymbolByCaseAndCaps("ṣ", "Ṣ")
	8 & t::SendSymbolByCaseAndCaps("ṭ", "Ṭ")
	8 & u::SendSymbolByCaseAndCaps("ụ", "Ụ")
	8 & v::SendSymbolByCaseAndCaps("ṿ", "Ṿ")
	8 & w::SendSymbolByCaseAndCaps("ẉ", "Ẉ")
	8 & x::SendSymbolByCaseAndCaps("", "")
	8 & y::SendSymbolByCaseAndCaps("ỵ", "Ỵ")
	8 & z::SendSymbolByCaseAndCaps("ẓ", "Ẓ")



; *===   "7" + 字母  
	$7 Up::Send, {7}
	+7::Send, {&}
	^7::Send, ^{7}
	^+7::Send, ^+{7}
	7 & Space::SendSymbolByCaseAndCaps("͘", "")
	7 & a::SendSymbolByCaseAndCaps("ȧ", "Ȧ")
	7 & b::SendSymbolByCaseAndCaps("ḃ", "Ḃ")
	7 & c::SendSymbolByCaseAndCaps("ċ", "Ċ")
	7 & d::SendSymbolByCaseAndCaps("ḋ", "Ḋ")
	7 & e::SendSymbolByCaseAndCaps("ė", "Ė")
	7 & f::SendSymbolByCaseAndCaps("ḟ", "Ḟ")
	7 & g::SendSymbolByCaseAndCaps("ġ", "Ġ")
	7 & h::SendSymbolByCaseAndCaps("ḣ", "Ḣ")
	7 & i::SendSymbolByCaseAndCaps("ı", "İ")
	7 & j::SendSymbolByCaseAndCaps("ȷ", "")
	7 & k::SendSymbolByCaseAndCaps("", "")
	7 & l::SendSymbolByCaseAndCaps("ŀ", "Ŀ")
	7 & m::SendSymbolByCaseAndCaps("ṁ", "Ṁ")
	7 & n::SendSymbolByCaseAndCaps("ṅ", "Ṅ")
	7 & o::SendSymbolByCaseAndCaps("ȯ", "Ȯ")
	7 & p::SendSymbolByCaseAndCaps("ṗ", "Ṗ")
	7 & q::SendSymbolByCaseAndCaps("", "")
	7 & r::SendSymbolByCaseAndCaps("ṙ", "Ṙ")
	7 & s::SendSymbolByCaseAndCaps("ṡ", "Ṡ")
	7 & t::SendSymbolByCaseAndCaps("ṫ", "Ṫ")
	7 & u::SendSymbolByCaseAndCaps("", "")
	7 & v::SendSymbolByCaseAndCaps("", "")
	7 & w::SendSymbolByCaseAndCaps("ẇ", "Ẇ")
	7 & x::SendSymbolByCaseAndCaps("ẋ", "Ẋ")
	7 & y::SendSymbolByCaseAndCaps("ẏ", "Ẏ")
	7 & z::SendSymbolByCaseAndCaps("ż", "Ż")

; *===   "." + 字母  
	$. Up::Send, {.}
	+.::Send, {>}
	^.::Send, ^{.}
	^+.::Send, ^+{.}
	. & Space::SendSymbolByCaseAndCaps("̦", "")
	. & a::SendSymbolByCaseAndCaps("ɐ", "Ɐ")
	. & b::SendSymbolByCaseAndCaps("", "")
	. & c::SendSymbolByCaseAndCaps("ɔ", "Ɔ")
	. & d::SendSymbolByCaseAndCaps("ʇ", "Ʇ")
	. & e::SendSymbolByCaseAndCaps("ǝ", "Ə")
	. & f::SendSymbolByCaseAndCaps("ɟ", "")
	. & g::SendSymbolByCaseAndCaps("ģ", "Ģ")
	. & h::SendSymbolByCaseAndCaps("ɥ", "")
	. & i::SendSymbolByCaseAndCaps("", "")
	. & j::SendSymbolByCaseAndCaps("", "")
	. & k::SendSymbolByCaseAndCaps("ķ", "Ķ")
	. & l::SendSymbolByCaseAndCaps("ļ", "Ļ")
	. & m::SendSymbolByCaseAndCaps("ɯ", "Ɯ")
	. & n::SendSymbolByCaseAndCaps("ņ", "Ņ")
	. & o::SendSymbolByCaseAndCaps("", "")
	. & p::SendSymbolByCaseAndCaps("", "")
	. & q::SendSymbolByCaseAndCaps("", "")
	. & r::SendSymbolByCaseAndCaps("ŗ", "Ŗ")
	. & s::SendSymbolByCaseAndCaps("ș", "Ș")
	. & t::SendSymbolByCaseAndCaps("ț", "Ț")
	. & u::SendSymbolByCaseAndCaps("", "")
	. & v::SendSymbolByCaseAndCaps("", "")
	. & w::SendSymbolByCaseAndCaps("", "")
	. & x::SendSymbolByCaseAndCaps("", "")
	. & y::SendSymbolByCaseAndCaps("", "")
	. & z::SendSymbolByCaseAndCaps("ƨ", "Ƨ")

; *===   "'" + 字母  
	$' Up::Send, {'}
	+'::Send, {"}
	^'::Send, ^{'}
	^+'::Send, ^+{'}
	' & Space::SendSymbolByCaseAndCaps("̆", "")
	' & a::SendSymbolByCaseAndCaps("ă", "Ă")
	' & b::SendSymbolByCaseAndCaps("", "")
	' & c::SendSymbolByCaseAndCaps("", "")
	' & d::SendSymbolByCaseAndCaps("", "")
	' & e::SendSymbolByCaseAndCaps("ĕ", "Ĕ")
	' & f::SendSymbolByCaseAndCaps("", "")
	' & g::SendSymbolByCaseAndCaps("ğ", "Ğ")
	' & h::SendSymbolByCaseAndCaps("", "")
	' & i::SendSymbolByCaseAndCaps("ĭ", "Ĭ")
	' & j::SendSymbolByCaseAndCaps("", "")
	' & k::SendSymbolByCaseAndCaps("", "")
	' & l::SendSymbolByCaseAndCaps("", "")
	' & m::SendSymbolByCaseAndCaps("", "")
	' & n::SendSymbolByCaseAndCaps("", "")
	' & o::SendSymbolByCaseAndCaps("ŏ", "Ŏ")
	' & p::SendSymbolByCaseAndCaps("", "")
	' & q::SendSymbolByCaseAndCaps("", "")
	' & r::SendSymbolByCaseAndCaps("", "")
	' & s::SendSymbolByCaseAndCaps("", "")
	' & t::SendSymbolByCaseAndCaps("", "")
	' & u::SendSymbolByCaseAndCaps("ŭ", "Ŭ")
	' & v::SendSymbolByCaseAndCaps("", "")
	' & w::SendSymbolByCaseAndCaps("", "")
	' & x::SendSymbolByCaseAndCaps("", "")
	' & y::SendSymbolByCaseAndCaps("", "")
	' & z::SendSymbolByCaseAndCaps("", "")

; *===   "[" + 字母  
	$[ Up::Send, {[}
	+[::Send, {{}
	^[::Send, ^{[}
	^+[::Send, ^+{[}
	[ & Space::SendSymbolByCaseAndCaps("̌", "")
	[ & a::SendSymbolByCaseAndCaps("ǎ", "Ǎ")
	[ & b::SendSymbolByCaseAndCaps("", "")
	[ & c::SendSymbolByCaseAndCaps("č", "Č")
	[ & d::SendSymbolByCaseAndCaps("ď", "Ď")
	[ & e::SendSymbolByCaseAndCaps("ě", "Ě")
	[ & f::SendSymbolByCaseAndCaps("", "")
	[ & g::SendSymbolByCaseAndCaps("ǧ", "Ǧ")
	[ & h::SendSymbolByCaseAndCaps("ȟ", "Ȟ")
	[ & i::SendSymbolByCaseAndCaps("ǐ", "Ǐ")
	[ & j::SendSymbolByCaseAndCaps("ǰ", "")
	[ & k::SendSymbolByCaseAndCaps("ǩ", "Ǩ")
	[ & l::SendSymbolByCaseAndCaps("", "")
	[ & m::SendSymbolByCaseAndCaps("", "")
	[ & n::SendSymbolByCaseAndCaps("ň", "Ň")
	[ & o::SendSymbolByCaseAndCaps("ǒ", "Ǒ")
	[ & p::SendSymbolByCaseAndCaps("", "")
	[ & q::SendSymbolByCaseAndCaps("", "")
	[ & r::SendSymbolByCaseAndCaps("ř", "Ř")
	[ & s::SendSymbolByCaseAndCaps("š", "Š")
	[ & t::SendSymbolByCaseAndCaps("ť", "Ť")
	[ & u::SendSymbolByCaseAndCaps("ǔ", "Ǔ")
	[ & v::SendSymbolByCaseAndCaps("ǚ", "Ǚ")
	[ & w::SendSymbolByCaseAndCaps("", "")
	[ & x::SendSymbolByCaseAndCaps("", "")
	[ & y::SendSymbolByCaseAndCaps("ǯ", "Ǯ")
	[ & z::SendSymbolByCaseAndCaps("ž", "Ž")




#If

