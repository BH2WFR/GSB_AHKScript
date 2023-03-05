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
	
	F23 & `::SendSymbolByCaseAndCaps("∽", "≈")
	
	F23 & 1::SendSymbolByCaseAndCaps("", "")
	F23 & 2::SendSymbolByCaseAndCaps("", "")
	F23 & 3::SendSymbolByCaseAndCaps("", "")
	F23 & 4::SendSymbolByCaseAndCaps("", "")
	F23 & 5::SendSymbolByCaseAndCaps("‰", "‱")	
	F23 & 6::SendSymbolByCaseAndCaps("", "")
	F23 & 7::SendSymbolByCaseAndCaps("", "")
	F23 & 8::SendSymbolByCaseAndCaps("·", "∞") ;middle dot
	F23 & 9::SendSymbolByCaseAndCaps("", "")
	F23 & 0::SendSymbolByCaseAndCaps("", "")
	
	F23 & -::SendSymbolByCaseAndCaps("−", "≡") ;long dash
	F23 & =::SendSymbolByCaseAndCaps("≠", "±")
	
	F23 & [::return
	F23 & ]::return
	F23 & \::return
	F23 & `;::return
	F23 & '::SendPairedSymbles_detectShiftKeys("‹›", "«»")
	F23 & ,::SendSymbolByCaseAndCaps("≤", "≮")
	F23 & .::SendSymbolByCaseAndCaps("≥", "≯")
	F23 & /::SendSymbolByCaseAndCaps("√", "")
	
	F23 & a::SendSymbolByCaseAndCaps("∠", "Ɐ")
	F23 & b::SendSymbolByCaseAndCaps("∵", "∴")
	F23 & c::return
	F23 & d::SendSymbolByCaseAndCaps("∂", "≝")
	F23 & e::SendSymbolByCaseAndCaps("∈", "∉")
	F23 & f::return
	F23 & g::return
	F23 & h::return
	F23 & i::return
	F23 & j::return
	F23 & k::return
	F23 & l::return
	F23 & m::SendSymbolByCaseAndCaps("∑", "∏")
	F23 & n::SendSymbolByCaseAndCaps("¬", "")
	F23 & o::SendSymbolByCaseAndCaps("°", "⊙")
	F23 & p::return
	F23 & q::return
	F23 & r::return
	F23 & s::SendSymbolByCaseAndCaps("∫", "∮")
	F23 & t::SendSymbolByCaseAndCaps("⊥", "")
	F23 & u::return
	F23 & v::SendSymbolByCaseAndCaps("∨", "∧")
	F23 & w::return
	F23 & x::SendSymbolByCaseAndCaps("⊕", "⊕")
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
	. & =::SendSymbolByCaseAndCaps("↔", "⇔")
	. & \::SendSymbolByCaseAndCaps("₌", "⁼")
	. & `::SendSymbolByCaseAndCaps("‸", "˜")
	. & [::SendSymbolByCaseAndCaps("₍", "⁽")
	. & ]::SendSymbolByCaseAndCaps("₎", "⁾")
	. & a::SendSymbolByCaseAndCaps("ₐ", "ᵃ")
	. & b::SendSymbolByCaseAndCaps("ʙ ", "ᵇ")
	. & c::SendSymbolByCaseAndCaps("", "ᶜ")
	. & d::SendSymbolByCaseAndCaps("ᴰ", "ᵈ")
	. & e::SendSymbolByCaseAndCaps("ₑ", "ᵉ")
	. & f::SendSymbolByCaseAndCaps("", "ᶠ")
	. & g::SendSymbolByCaseAndCaps("", "ᵍ")
	. & h::SendSymbolByCaseAndCaps("", "")
	. & i::SendSymbolByCaseAndCaps("", "ᶤ")
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
	
	. & Right::SendSymbolByCase("⇉", "⇆")
	. & Left::SendSymbolByCase("⇇", "↺")
	. & Up::SendSymbolByCase("⇈", "⇅")
	. & Down::SendSymbolByCase("⇊", "↻")


; ; *===   "；" + 字母  
	$`; Up::Send, {`;}
	+`;::Send, {:}
	^`;::Send, ^{`;}
	^+`;::Send, ^+{`;}
	`; & `::SendSymbolByCaseAndCaps("", "")
	`; & 1::SendSymbolByCaseAndCaps("一", "壹")
	`; & 2::SendSymbolByCaseAndCaps("二", "貳")
	`; & 3::SendSymbolByCaseAndCaps("三", "叄")
	`; & 4::SendSymbolByCaseAndCaps("四", "肆")
	`; & 5::SendSymbolByCaseAndCaps("五", "伍")	
	`; & 6::SendSymbolByCaseAndCaps("六", "陸")
	`; & 7::SendSymbolByCaseAndCaps("七", "柒")
	`; & 8::SendSymbolByCaseAndCaps("八", "捌")
	`; & 9::SendSymbolByCaseAndCaps("九", "玖")
	`; & 0::SendSymbolByCaseAndCaps("〇", "零")
	`; & -::SendSymbolByCaseAndCaps("十", "拾")
	`; & =::SendSymbolByCaseAndCaps("百", "佰")

; ; *===   "'" + 字母  
	$' Up::Send, {'}
	+'::Send, {"}
	^'::Send, ^{'}
	^+'::Send, ^+{'}
	' & `::SendSymbolByCaseAndCaps("", "")
	; ' & 1::SendSymbolByCaseAndCaps("壹", "")
	; ' & 2::SendSymbolByCaseAndCaps("贰", "")
	; ' & 3::SendSymbolByCaseAndCaps("叁", "")
	; ' & 4::SendSymbolByCaseAndCaps("肆", "")
	; ' & 5::SendSymbolByCaseAndCaps("伍", "")	
	; ' & 6::SendSymbolByCaseAndCaps("陆", "")
	; ' & 7::SendSymbolByCaseAndCaps("柒", "")
	; ' & 8::SendSymbolByCaseAndCaps("捌", "")
	; ' & 9::SendSymbolByCaseAndCaps("玖", "")
	; ' & 0::SendSymbolByCaseAndCaps("零", "")
	; ' & -::SendSymbolByCaseAndCaps("拾", "")
	; ' & =::SendSymbolByCaseAndCaps("佰", "")
	' & 1::SendSymbolByCaseAndCaps("壹", "Ⅰ")
	' & 2::SendSymbolByCaseAndCaps("贰", "Ⅱ")
	' & 3::SendSymbolByCaseAndCaps("叁", "Ⅲ")
	' & 4::SendSymbolByCaseAndCaps("肆", "Ⅳ")
	' & 5::SendSymbolByCaseAndCaps("伍", "Ⅴ")	
	' & 6::SendSymbolByCaseAndCaps("陆", "Ⅵ")
	' & 7::SendSymbolByCaseAndCaps("柒", "Ⅶ")
	' & 8::SendSymbolByCaseAndCaps("捌", "Ⅷ")
	' & 9::SendSymbolByCaseAndCaps("玖", "Ⅸ")
	' & 0::SendSymbolByCaseAndCaps("零", "")
	' & -::SendSymbolByCaseAndCaps("拾", "Ⅹ")
	' & =::SendSymbolByCaseAndCaps("佰", "")
	
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

