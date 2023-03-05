; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

;*内容：
/*
	1.各式箭头
	2.汉字数字和大写汉字数字（含简体和繁体）
	3.各种数学符号
	4.排版专用常用符号
	5.各种几何符号
	6.希腊字母
*/
;*   ============================= 3 花体字母输入模式 ===============================
#If rAltMode == 3

	
	F23 & Space::SendSymbolByCaseAndCaps("　", "　")
	;F23 & Enter::return
	;F23 & BackSpace::return
	
	F23 & Tab::SendTabs_detectShiftKey()
	
	F23 & `::SendSymbolByCase("∽", "≈")
	
	F23 & 1::SendSymbolByCase("", "")
	F23 & 2::SendSymbolByCase("", "")
	F23 & 3::SendSymbolByCase("", "")
	F23 & 4::SendSymbolByCase("", "")
	F23 & 5::SendSymbolByCase("‰", "‱")	
	F23 & 6::SendSymbolByCase("...", "…")
	F23 & 7::SendSymbolByCase("", "")
	F23 & 8::SendSymbolByCase("·", "∞") ;middle dot
	F23 & 9::SendSymbolByCase("", "")
	F23 & 0::SendSymbolByCase("", "")
	
	F23 & -::SendSymbolByCase("−", "≡") ;long dash
	F23 & =::SendSymbolByCase("≠", "±")
	
	F23 & [::return
	F23 & ]::return
	F23 & \::return
	F23 & `;::return
	F23 & '::SendPairedSymbles_detectShiftKeys("‹›", "«»")
	F23 & ,::SendSymbolByCase("≤", "≮")
	F23 & .::SendSymbolByCase("≥", "≯")
	F23 & /::SendSymbolByCase("√", "")
	
	F23 & a::SendSymbolByCase("∠", "Ɐ")
	F23 & b::SendSymbolByCase("∵", "∴")
	F23 & c::return
	F23 & d::SendSymbolByCase("∂", "≝")
	F23 & e::SendSymbolByCase("∈", "∉")
	F23 & f::return
	F23 & g::return
	F23 & h::return
	F23 & i::return
	F23 & j::return
	F23 & k::return
	F23 & l::return
	F23 & m::SendSymbolByCase("∑", "∏")
	F23 & n::SendSymbolByCase("¬", "")
	F23 & o::SendSymbolByCase("°", "⊙")
	F23 & p::return
	F23 & q::return
	F23 & r::return
	F23 & s::SendSymbolByCase("∫", "∮")
	F23 & t::SendSymbolByCase("⊥", "")
	F23 & u::return
	F23 & v::SendSymbolByCase("∨", "∧")
	F23 & w::return
	F23 & x::SendSymbolByCase("⊕", "⊕")
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
	. & Space::SendSymbolByCase("", "")
	. & 1::SendSymbolByCase("₁", "¹")
	. & 2::SendSymbolByCase("₂", "²")
	. & 3::SendSymbolByCase("₃", "³")
	. & 4::SendSymbolByCase("₄", "⁴")
	. & 5::SendSymbolByCase("₅", "⁵")	
	. & 6::SendSymbolByCase("₆", "⁶")
	. & 7::SendSymbolByCase("₇", "⁷")
	. & 8::SendSymbolByCase("₈", "⁸")
	. & 9::SendSymbolByCase("₉", "⁹")
	. & 0::SendSymbolByCase("₀", "⁰")
	. & -::SendSymbolByCase("₋", "⁻")
	. & =::SendSymbolByCase("↔", "⇔")
	. & \::SendSymbolByCase("₌", "⁼")
	. & `::SendSymbolByCase("‸", "˜")
	. & [::SendSymbolByCase("₍", "⁽")
	. & ]::SendSymbolByCase("₎", "⁾")
	. & a::SendSymbolByCase("ₐ", "ᵃ")
	. & b::SendSymbolByCase("ʙ ", "ᵇ")
	. & c::SendSymbolByCase("", "ᶜ")
	. & d::SendSymbolByCase("ᴰ", "ᵈ")
	. & e::SendSymbolByCase("ₑ", "ᵉ")
	. & f::SendSymbolByCase("", "ᶠ")
	. & g::SendSymbolByCase("", "ᵍ")
	. & h::SendSymbolByCase("", "")
	. & i::SendSymbolByCase("", "ᶤ")
	. & j::SendSymbolByCase("", "")
	. & k::SendSymbolByCase("", "")
	. & l::SendSymbolByCase("", "")
	. & m::SendSymbolByCase("", "")
	. & n::SendSymbolByCase("", "")
	. & o::SendSymbolByCase("°", "ʘ")
	. & p::SendSymbolByCase("", "")
	. & q::SendSymbolByCase("", "")
	. & r::SendSymbolByCase("", "")
	. & s::SendSymbolByCase("ₛ", "ˢ")
	. & t::SendSymbolByCase("", "")
	. & u::SendSymbolByCase("", "")
	. & v::SendSymbolByCase("", "")
	. & w::SendSymbolByCase("", "")
	. & x::SendSymbolByCase("", "")
	. & y::SendSymbolByCase("", "")
	. & z::SendSymbolByCase("", "")
	
	. & Right::SendSymbolByCase("⇉", "⇆")
	. & Left::SendSymbolByCase("⇇", "↺")
	. & Up::SendSymbolByCase("⇈", "⇅")
	. & Down::SendSymbolByCase("⇊", "↻")


; ; *===   "；" + 字母  
	$`; Up::Send, {`;}
	+`;::Send, {:}
	^`;::Send, ^{`;}
	^+`;::Send, ^+{`;}
	`; & `::SendSymbolByCase("", "")
	`; & 1::SendSymbolByCase("一", "壹")
	`; & 2::SendSymbolByCase("二", "貳")
	`; & 3::SendSymbolByCase("三", "叄")
	`; & 4::SendSymbolByCase("四", "肆")
	`; & 5::SendSymbolByCase("五", "伍")	
	`; & 6::SendSymbolByCase("六", "陸")
	`; & 7::SendSymbolByCase("七", "柒")
	`; & 8::SendSymbolByCase("八", "捌")
	`; & 9::SendSymbolByCase("九", "玖")
	`; & 0::SendSymbolByCase("〇", "零")
	`; & -::SendSymbolByCase("十", "拾")
	`; & =::SendSymbolByCase("百", "佰")

; ; *===   "'" + 字母  
	$' Up::Send, {'}
	+'::Send, {"}
	^'::Send, ^{'}
	^+'::Send, ^+{'}
	' & `::SendSymbolByCase("", "")
	; ' & 1::SendSymbolByCase("壹", "")
	; ' & 2::SendSymbolByCase("贰", "")
	; ' & 3::SendSymbolByCase("叁", "")
	; ' & 4::SendSymbolByCase("肆", "")
	; ' & 5::SendSymbolByCase("伍", "")	
	; ' & 6::SendSymbolByCase("陆", "")
	; ' & 7::SendSymbolByCase("柒", "")
	; ' & 8::SendSymbolByCase("捌", "")
	; ' & 9::SendSymbolByCase("玖", "")
	; ' & 0::SendSymbolByCase("零", "")
	; ' & -::SendSymbolByCase("拾", "")
	; ' & =::SendSymbolByCase("佰", "")
	' & 1::SendSymbolByCase("壹", "Ⅰ")
	' & 2::SendSymbolByCase("贰", "Ⅱ")
	' & 3::SendSymbolByCase("叁", "Ⅲ")
	' & 4::SendSymbolByCase("肆", "Ⅳ")
	' & 5::SendSymbolByCase("伍", "Ⅴ")	
	' & 6::SendSymbolByCase("陆", "Ⅵ")
	' & 7::SendSymbolByCase("柒", "Ⅶ")
	' & 8::SendSymbolByCase("捌", "Ⅷ")
	' & 9::SendSymbolByCase("玖", "Ⅸ")
	' & 0::SendSymbolByCase("零", "")
	' & -::SendSymbolByCase("拾", "Ⅹ")
	' & =::SendSymbolByCase("佰", "")
	
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

