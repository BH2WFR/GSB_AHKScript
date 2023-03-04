; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}


;*   ============================= 3 花体字母输入模式 ===============================
#If rAltMode == 3

	
	F23 & Space::return
	;F23 & Enter::return
	;F23 & BackSpace::return
	
	F23 & Tab::SendTabs_detectShiftKey()
	
	F23 & `::SendSymbolByCaseAndCaps("", "")
	
	F23 & 1::SendSymbolByCaseAndCaps("", "")
	F23 & 2::SendSymbolByCaseAndCaps("", "")
	F23 & 3::SendSymbolByCaseAndCaps("", "")
	F23 & 4::SendSymbolByCaseAndCaps("", "")
	F23 & 5::SendSymbolByCaseAndCaps("", "")	
	F23 & 6::SendSymbolByCaseAndCaps("", "")
	F23 & 7::SendSymbolByCaseAndCaps("", "")
	F23 & 8::SendSymbolByCaseAndCaps("", "")
	F23 & 9::SendSymbolByCaseAndCaps("", "")
	F23 & 0::SendSymbolByCaseAndCaps("", "")
	
	F23 & -::SendSymbolByCaseAndCaps("", "")
	F23 & =::SendSymbolByCaseAndCaps("", "")
	
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
	
	F23 & Right::SendSymbolByCase("→", "⇒")
	F23 & Left::SendSymbolByCase("←", "⇐")
	F23 & Up::SendSymbolByCase("↑", "⇑")
	F23 & Down::SendSymbolByCase("↓", "⇓")
	
; ;*=================  模板 误删 ================
; ; *===   "=" + 字母  
; 	$- Up::Send, {-}
; 	+-::Send, {_}
; 	^-::Send, ^{-}
; 	^+-::Send, ^+{-}
	; - & 1::SendSymbolByCaseAndCaps("", "")
	; - & 2::SendSymbolByCaseAndCaps("", "")
	; - & 3::SendSymbolByCaseAndCaps("", "")
	; - & 4::SendSymbolByCaseAndCaps("", "")
	; - & 5::SendSymbolByCaseAndCaps("", "")	
	; - & 6::SendSymbolByCaseAndCaps("", "")
	; - & 7::SendSymbolByCaseAndCaps("", "")
	; - & 8::SendSymbolByCaseAndCaps("", "")
	; - & 9::SendSymbolByCaseAndCaps("", "")
	; - & 0::SendSymbolByCaseAndCaps("", "")
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
	
; ; *===   "=" + 字母  
	$. Up::Send, {.}
	+.::Send, {>}
	^.::Send, ^{.}
	^+.::Send, ^+{.}
	. & Space::SendSymbolByCaseAndCaps("", "")
	. & 1::SendSymbolByCaseAndCaps("₁", "¹")
	. & 2::SendSymbolByCaseAndCaps("₂", "²")
	. & 3::SendSymbolByCaseAndCaps("₃", "³")
	. & 4::SendSymbolByCaseAndCaps("₄", "⁴")
	. & 5::SendSymbolByCaseAndCaps("₅", "⁵")	
	. & 6::SendSymbolByCaseAndCaps("₆", "⁶")
	. & 7::SendSymbolByCaseAndCaps("₇", "⁷")
	. & 8::SendSymbolByCaseAndCaps("₈", "⁸")
	. & 9::SendSymbolByCaseAndCaps("₉", "⁹")
	. & 0::SendSymbolByCaseAndCaps("₀", "⁰")
	. & -::SendSymbolByCaseAndCaps("₋", "⁻")
	. & +::SendSymbolByCaseAndCaps("₊", "⁺")
	. & \::SendSymbolByCaseAndCaps("₌", "⁼")
	. & `::SendSymbolByCaseAndCaps("‸", "˜")
	. & [::SendSymbolByCaseAndCaps("₍", "⁽")
	. & ]::SendSymbolByCaseAndCaps("₎", "⁾")
	. & a::SendSymbolByCaseAndCaps("ₐ", "ᵃ")
	. & b::SendSymbolByCaseAndCaps("ʙ ", "ᵇ")
	. & c::SendSymbolByCaseAndCaps("", "")
	. & d::SendSymbolByCaseAndCaps("", "")
	. & e::SendSymbolByCaseAndCaps("", "")
	. & f::SendSymbolByCaseAndCaps("", "")
	. & g::SendSymbolByCaseAndCaps("", "")
	. & h::SendSymbolByCaseAndCaps("", "")
	. & i::SendSymbolByCaseAndCaps("", "")
	. & j::SendSymbolByCaseAndCaps("", "")
	. & k::SendSymbolByCaseAndCaps("", "")
	. & l::SendSymbolByCaseAndCaps("", "")
	. & m::SendSymbolByCaseAndCaps("", "")
	. & n::SendSymbolByCaseAndCaps("", "")
	. & o::SendSymbolByCaseAndCaps("°", "ʘ")
	. & p::SendSymbolByCaseAndCaps("", "")
	. & q::SendSymbolByCaseAndCaps("", "")
	. & r::SendSymbolByCaseAndCaps("", "")
	. & s::SendSymbolByCaseAndCaps("ₛ", "ˢ")
	. & t::SendSymbolByCaseAndCaps("", "")
	. & u::SendSymbolByCaseAndCaps("", "")
	. & v::SendSymbolByCaseAndCaps("", "")
	. & w::SendSymbolByCaseAndCaps("", "")
	. & x::SendSymbolByCaseAndCaps("", "")
	. & y::SendSymbolByCaseAndCaps("", "")
	. & z::SendSymbolByCaseAndCaps("", "")

; ; *===   "=" + 字母  
; 	$- Up::Send, {-}
; 	+-::Send, {_}
; 	^-::Send, ^{-}
; 	^+-::Send, ^+{-}
	; - & Space::SendSymbolByCaseAndCaps("", "")
	; - & 1::SendSymbolByCaseAndCaps("₁", "")
	; - & 2::SendSymbolByCaseAndCaps("", "")
	; - & 3::SendSymbolByCaseAndCaps("", "")
	; - & 4::SendSymbolByCaseAndCaps("", "")
	; - & 5::SendSymbolByCaseAndCaps("", "")	
	; - & 6::SendSymbolByCaseAndCaps("", "")
	; - & 7::SendSymbolByCaseAndCaps("", "")
	; - & 8::SendSymbolByCaseAndCaps("", "")
	; - & 9::SendSymbolByCaseAndCaps("", "")
	; - & 0::SendSymbolByCaseAndCaps("₀", "")
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
	
	

#If

