; encoding: UTF-8 with BOM

/*
^ ====================================== GSB_AKHScript ==================================
^ |   	版本：v0.2.6.dev1      作者：BH2WFR, GSB Electronic   	更新时间：26 Feb 2023 	 |
------------------------------------------------------------------------------------
*     				 AHK 版本： v1.1.x, 		操作系统支持版本 >= Vista(NT6.0)                     
	----------------------------------------------------------------	
*  			代码仓库 git 地址：	 https://github.com/BH2WFR/GSB_AHKScript.git
*			网页：				https://github.com/BH2WFR/GSB_AHKScript
* 			开源协议：  
*
*-----------------------------------------------------------------------------------
*/

/* 
^ ==================================== 使用说明和注意事项：=================================        
*  -- 1. 要先使用 PowerToys 等工具物理映射下列按键：
;*			右Alt 或 分号键	 ->	F23(之前为F13), 需要更改全局变量"use_SemiColonAsRAlt"来选择
;*			CapsLock 		->	F24(之前为F14)

* -- 2. 中文 小狼毫输入法中，如下更改快捷键：
*				功能	|				默认映射			|			更改后映射			|    
			弹出菜单	|			F4 或 Ctrl+{`}			|		F20 或 Ctrl+Shift+{`(grave)}
			中英切换	|	Ctrl+Shift+2 或 Shift 或 Caps	|		Ctrl+F20
			全角/半角	|		Ctrl+Shift+3 				|		Ctrl+Shift+F20
			繁简切换	|		Ctrl+Shift+4 或 F4,1,4		|		Control+Shift+F21
			增广字集			Ctrl+Shift+5				|		Shift+F21
			中英标点	|		F4,1,5						|		Ctrl+F21	
 			输入法切换	|     .next  Ctrl+Shift+1			|		Shift+F20
			---------------------------------------------------------------------
*		更改方法：在程序目录的 key_bindings.yaml 中，找到对应配置代码，更改或 patch 为：
    - { when: always, accept: Shift+F20, select: .next }
    - { when: always, accept: Control+F20, toggle: ascii_mode }
    - { when: always, accept: Control+Shift+F20, toggle: full_shape }
    - { when: always, accept: Control+Shift+F21, toggle: simplification }
    - { when: always, accept: Shift+F21, toggle: extended_charset }
    - { when: always, accept: Ctrl+F21, toggle: ascii_punct }


;* -- 3. 朝鲜语输入法中 需要将键盘布局设置为：Keyboard layout: Korean keyboard (101 key) Type 1，
		即把韩文切换键和汉字键映射到专用按键上, 否则会默认按照 RAlt 韩英，RCtrl 汉字作为切换快捷键，
		输入法快捷键为系统级别快捷键，会干扰 PowerToys 的 将 RAlt 映射到 F23 的功能
; 			注释：Hangul Key:{vk15sc1F2}     Hanja Key:sc1F1



;---------------------------------------------------------------------------------
*/

/* 
TODO ============================== 未来将完成的功能 =================================

*	暂时不要push，或者只能force push，用 git commit --amend 的形式完成 v0.2.5.dev6 的制作
	
	功能完善后版本跳到 v0.2.6 正式版，然后开始改成  v0.2.6.devX 完善具体快捷键功能
	程序大体框架已经完成，接下来主要专注于 Caps 和 RAlt 组合键的具体功能，完善后版本号将跳到 v1.0.0
	
*/


;^ ============================== 运行前检查兼容性并获取管理员权限 ===============================
;*=================== 检查系统版本 ===============
;osv := A_OSVersion
;osv := ((r := DllCall("GetVersion") & 0xFFFF) & 0xFF) "." (r >> 8)
If(A_OSVersion == "WIN_2000" || A_OSVersion == "WIN_XP" || A_OSVersion == "WIN_2003"){
	Msgbox, 0x10, 不支持的操作系统, 你的 Windows 操作系统版本 %A_OSVersion% 太低了捏！`n  请使用至少 Windows Vista (NT 6.0) 以上的系统！
	ExitApp
}

;*================== 检查 AutoHotkey 版本============
If (VerCompare(A_AhkVersion, "<= 1.1")){
	Msgbox, 0x10, 不支持的 AutoHotkey 解释器版本, 您的 AutoHotkey 解释器版本 v%A_AhkVersion% 太低 `n  请使用 AutoHotkey v1.1.x 的版本（也不能使用 v2 及以上版本）运行！
	ExitApp
}else if (VerCompare(A_AhkVersion, ">= 2")){
	Msgbox, 0x10, 不支持的 AutoHotkey 解释器版本, 这是一个基于 AutoHotkey v1.1.x 的脚本，`n  不可以使用 v2 及以上版本运行，因为 AutoHotkey v1 和 v2 互不兼容！
	ExitApp
}else{
	
}


;*==================  申请管理员权限 ==================
; if (! A_IsAdmin){ ;http://ahkscript.org/docs/Variables.htm#IsAdmin
; 	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
; 	ExitApp
; }
full_command_line := DllCall("GetCommandLine", "str")

if (!(A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)")))
{
    try
    {
        if (A_IsCompiled)
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

  sb := "http://www.bai-du.com:8086/w的w/ww.html"
;  sd := RegExMatch(sb, "\/\/([\w\.\d-]+)", sc)

;  MsgBox, sb:%sb% `n sc:%sc% `n sd:%sd%

;  if(ReGexMatch(sb, "^['""](.*)['""]$") != 0){
; 	sb_len := StrLen(sb)
; 		sb := SubStr(sb, 2, sb_len - 2)
;  	MsgBox, %sb%
	
;  }
;   if(InStr(sb, "`n")){
; 	MsgBox, n
;   }
; 	sb := StrReplace(sb, "`n")
; 	sb := StrReplace(sb, "`r")
	
;   MsgBox, %sb%
;   if(InStr(sb, "`n")){
; 	MsgBox, n
;   }

; sblen := StrLen(sb)
; se := SubStr(sb, 2, sblen)
;   MsgBox, %se%, %sblen%
  
  
  	; if(RegExMatch(sb, "^file:\/\/(.+)")){
	; 	sb_len := StrLen(sb)
	; 	sb := SubStr(sb, 8, sb_len)
		
	; }
	
	; if(ReGexMatch(sb, "^(http|https|ftp):\/\/(.+)") != 0){
	; 	sbi := RegExMatch(sb, "\/\/([\w\.\d-]+)", sbdomain)
	; 	sblen := StrLen(sbdomain)
	; 	sbdomain := SubStr(sbdomain, 3, sblen)
	; }
	
	; MsgBox, %sb% `n%sbi% `n%sbdomain%
	
;^==================================  全局变量 ================================
;全局变量
; 注意： 使用时要在函数头部中声明一次这个变量, 否则无法使用, 格式: global isTestMode

isTestMode := 1		; 是否处于测试模式
rAltMode := 1		; 默认 RAlt 特殊模式，0 为关闭状态
rAltModeList := {0:"OFF", 1:"Programming Mode", 2:"Galian Script", 3:"Esp Script", 4:"Colemak Input"}
MouseQuickMoveUnitPixels := 30  ;F23+Shift+方向键 快速移动鼠标速度（每次移动的像素点个数) 


;* 系统安装的输入法语言代码：
installedKeyboardLayout := {134481924:"Chinese,Simplicated", 68289554:"Korean", 67699721:"English,US,QWERTY"}
;Layout_ChineseSimp_Code := 134481924
;Layout_Korean_Code := 68289554

;IMEmodeChangeKey := 1   ; ==0:Shift切换，1:F24(Caps)切换, 2:Ctrl+Space 切换 3: Ctrl切换

use_SemiColonAsRAlt := 0  ; 使用分号代替RAlt,（适用于一些 RAlt 不方便按到的键盘, 要提前映射到 F23）

rime_KeymapChanged := 1	; 小狼毫 快捷键是否非默认状态
installed_Korean := 1
installed_English_US := 1
use_test_getIMEcode := 1 ; F16键弹出对话框显示当前输入法代号


;* 是否启用模块功能
use_RimeInput := 1
use_Anki := 1
use_AutoCAD := 1
use_Explorer_CopyFullPath := 1 



;^===================================  全局热键   ====================================
; 全局热键
;* F23 释放时触发正常的 F23 功能，如果在韩文输入法下则输出汉字切换键
#If use_SemiColonAsRAlt == 0
;$F23 Up::
$F23::
	
	If(1 == IsInKoreanLayout()){	;* 如果处于韩文输入法下
		SendHanjaKey()	; 汉字切换
	}else{
		Send {F23} ; 释放正常 RAlt 点击
	}
	
return

;* 对于 RAlt 不方便按下的键盘, 用分号键替代 F23 功能键
#If use_SemiColonAsRAlt == 1
F24 & F23::
$RAlt::
	
	If(1 == IsInKoreanLayout()){	;* 如果处于韩文输入法下
		SendHanjaKey()	; 汉字切换
	}else{
		
	}
return

Shift & F23::	;* 输出正常的分号和冒号
	Send, :
return	
$F23::
	Send, `;
return

#If

;*=============== F23：全局切换 RAlt 模式 ========
F24 & Backspace::	;^ 映射 F24+Bksp
F23 & Backspace::	;* 删除二字词的第一个字，暂同时支持 Caps+Bksp 和 RAlt+Bksp 触发
	Send, {Left}{Backspace}{Right}
return
F23 & Esc::   ;* 查看当前 RAlt 模式
	if (GetKeyState("Shift")){
		AltModeTestToolTip(1)
	}else{
		AltModeTestToolTip()
	}
return
F23 & F1::SetRAltMode(1)	; 设置 RAlt 模式
F23 & F2::SetRAltMode(2)
F23 & F3::return
F23 & F4::return
F23 & F5::return
F23 & F6::return
F23 & F7::return
F23 & F8::return
F23 & F9::return
F23 & F10::return
F23 & F11::return
F23 & F12::return
F23 & PrintScreen::return
F23 & ScrollLock::return
F23 & Home::return
F23 & End::return
F23 & PgUp::return
F23 & PgDn::return
F23 & Delete::SetRAltMode(0)	;关闭RAlt模式



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
F24 & Tab::return		;
;F24 & CapsLock::return	;无效组合
;F24 & Space::return	;输入法占用
F24 & Enter::return		;
;F24 & BackSpace::return	; 重映射到 F23+Backspace，代码在前面，去除二字汉字词的第一个字
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
F24 & -::return	;
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
F24 & i::return	;		;
F24 & j::return	;
F24 & k::return	;
F24 & l::Run, D:\Downloads
F24 & m::return	;
F24 & n::return	;
F24 & o::return	;		;
;F24 & p::return	; 后面的复制路径程序
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

F24 & Esc::return
F24 & F1::return	; 设置 RAlt 模式
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
F24 & Delete::return	;关闭RAlt模式



;^====================== 特定程序中的自定义特殊热键 （根据需求随时更改） ===================
; 程序热键
;*================ Excel 中： F23+Enter 直接输出原本的 Alt+Enter
; EXCEL, wps, libreoffice 中
#If WinActive("ahk_exe EXCEL.EXE") || WinActive("ahk_exe wps.exe") || WinActive("ahk_exe soffice.exe") 
F23 & Enter::
	;If (WinActive("ahk_exe EXCEL.EXE") || WinActive("ahk_exe wps.exe") || WinActive("ahk_exe soffice.exe")){	
		Send, !{Enter}
	;}
return
#If

;*============== Anki： 鼠标特殊键触发文本加粗和标红
#If use_Anki == 1
	#If WinActive("ahk_exe anki.exe") && (WinActive("Add") || WinActive("Edit Current") || WinActive("Browse")) ; 编辑窗口中
		XButton1::	;鼠标 后退键 触发 文本加粗
			Send, ^b
		return
		
		XButton2::	;鼠标 前进键 触发 文本标红
			Send, {F7}
		return
		
		WheelLeft::	; 鼠标 向左滚动 触发 
			
		return
		
		WheelRight:: ; 鼠标 向右滚动 触发
			
		return
	#If  ;WinActive

	#If WinActive("ahk_exe anki.exe")  && !(WinActive("Add") || WinActive("Edit Current")) ; 背诵窗口中
		;TODO 功能预留
		
	#If  ;WinActive
#If

;*============== AutoCAD  鼠标特殊按键映射到快捷键
#If use_AutoCAD == 1
	#If WinActive("ahk_exe acad.exe")
		XButton1::	;鼠标 后退键 触发 
			Send, {Esc}
		return
		
		XButton2::	;鼠标 前进键 触发 
			Send, {Enter}
		return
		
		;WheelLeft::	; 鼠标 向左滚动 触发 
			
		;return
		
		;WheelRight:: ; 鼠标 向右滚动 触发
			
		;return	
	#If
#If

; Onenote F20触发鼠标位置显示
#IfWinActive ahk_exe ONENOTE.EXE
	
#IfWinActive

; MDK中：
#IfWinActive ahk_exe UV4.exe
	;快捷输入主函数


#IfWinActive

;*============   Explorer 中，按 F23+C 复制选中文本的完整地址到剪贴板
#If use_Explorer_CopyFullPath == 1
	F23 & P:: ; Select the shot folders in Explorer, then hit WIN + P , after a few moments the file path of the first EXR in each shot will be added 
	
	return

#If






;^===================================  系统特殊功能：=====================================
;系统功能
;*========== RAlt+方向键 以像素为单位移动鼠标指针, 加上 Shift 后快速移动鼠标
#If 1

F23 & Right::
F23 & Left::
F23 & Up::
F23 & Down::
	if (GetKeyState("Shift")){
		increment := MouseQuickMoveUnitPixels
	}else{
		increment := 1
	}
	
	if (InStr(A_ThisHotkey, "Left")){
		MoveMouse("Left", increment)
	}else if (InStr(A_ThisHotkey, "Right")){
		MoveMouse("Right", increment)
	}else if (InStr(A_ThisHotkey, "Up")){
		MoveMouse("Up", increment)
	}else if (InStr(A_ThisHotkey, "Down")){
		MoveMouse("Down", increment)
	}
	;MsgBox, haha , %A_ThisHotkey%
return


F23 & RWin::
	Send, {LButton}
return
F23 & AppsKey::
	Send, {RButton}
return


#If

;$Insert Up:: Send {Insert} ; 确保 Insert 按钮功能仍然有用

;*=============== 任务栏上：任务栏上滚动鼠标滚轮以调节音量（更新：副屏的任务栏也可以了）
#if MouseIsOver("ahk_class Shell_TrayWnd") || MouseIsOver("ahk_class Shell_SecondaryTrayWnd")
	WheelUp::Send {Volume_Up}
	WheelDown::Send {Volume_Down}
	Mbutton::Send {Volume_Mute}

	MouseIsOver(WinTitle) {
		MouseGetPos,,, Win
		return WinExist(WinTitle . " ahk_id " . Win)
	}
#If


;*===============窗口上： LWin+鼠标滚轮：窗口置顶/取消置顶， LWin+Shift+鼠标滚轮：调节窗口透明度
~LWin & WheelUp::
#F1::
; 透明度调整，增加。
	BlockInput, On	;* 新增：阻塞键盘鼠标输入（不含触控板）
	if (GetKeyState("Shift")){
		WinGet, Transparent, Transparent,A
		If (Transparent="")
			Transparent=255
		Transparent_New := Transparent + 20    ;◆透明度增加速度。
		If (Transparent_New > 254)
			Transparent_New =255
		WinSet,Transparent,%Transparent_New%,A
		tooltip now: ▲%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
		;sleep 1500
		SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
	}else{
		WinSet AlwaysOnTop,On,A
		tooltip, AlwaysOnTop ON
		SetTimer, RemoveToolTip, -1000
	}
	BlockInput, Off
return
 
~LWin & WheelDown::
#F2::
;透明度调整，减少。
	BlockInput, On
	if (GetKeyState("Shift")){
		WinGet, Transparent, Transparent,A
		If (Transparent="")
			Transparent=255
		Transparent_New := Transparent - 20  ;◆透明度减少速度。
		If (Transparent_New < 35)    ;◆最小透明度限制。
			Transparent_New = 35
		WinSet,Transparent,%Transparent_New%,A
		tooltip now: ▼%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
		;sleep 1500
		SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
	}else{
		WinSet AlwaysOnTop,Off,A
		tooltip, AlwaysOnTop OFF
		SetTimer, RemoveToolTip, -1000
	}
	BlockInput, Off
return
 
;设置Lwin &Mbutton直接恢复透明度到255。
~LWin & Mbutton:: 
	WinGet, Transparent, Transparent,A
	WinSet,Transparent,255,A 
	tooltip ▲Restored ;查看当前透明度（操作之后的）。
	;sleep 1500
	SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
return
 
 
removetooltip_transparent_Lwin__2016.09.20:     ;LABEL
	tooltip
	SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, Off
return

;* ================ Win+鼠标左右滚动 切换桌面
~LWin & WheelLeft::Send, ^#{Left}
~LWin & WheelRight::Send, ^#{Right}


;* ================ RAlt+鼠标滚轮 横向滚动, 加 Shift 更快速
F23 & WheelDown::	;* Right
	if (GetKeyState("Shift")){
		WheelScroll("right", 3)
	}else{
		WheelScroll("right", 1)
	}
return
F23 & WheelUp::		;* Left
	if (GetKeyState("Shift")){
		WheelScroll("left", 3)
	}else{
		WheelScroll("left", 1)
	}
return



;* ================ Caps+鼠标滚轮  加速纵向滚动, 加 Shift 更快速
F24 & WheelDown::
	if (GetKeyState("Shift")){
		WheelScroll("down", 6)
	}else{
		WheelScroll("down", 3)
	}
return
F24 & WheelUp::
	if (GetKeyState("Shift")){
		WheelScroll("up", 6)
	}else{
		WheelScroll("up", 3)
	}
return

;TODO 浏览器触控板缩放
#If ! WinActive("ahk_exe msedge.exe") || WinActive("ahk_exe chrome.exe")
	; ^WheelUp::
	
	; return
	
	; ^WheelDown::
	
	; return
	
#If

;^==================================== 测试代码和临时函数 ==================================
;* ============ 测试代码：当前键盘布局和输入法
#If use_test_getIMEcode == 1
	F16:: 
		InputLocaleID := GetCurrentKeyboardLayoutCode()
		;MsgBox, 0x40, 输入法%InputLocaleID%
		InputName := GetCurrentKeyboardLayoutName()
		MsgBox,  0x40, 当前输入法检测, ID:   %InputLocaleID% `nName: %InputName%
	return
#If
 
 
 
;^======================================= 函数区 ==========================================
; 函数
;* ===设置 RAlt 模式并弹出工具条提示
SetRAltMode(mode)
{
	global rAltMode
	global rAltModeList
	rAltMode := mode
	ShowToolTip("切换到 rAlt 模式：" rAltMode ": " rAltModeList[rAltMode])
}

;*==== 工具提示条显示当前模式
AltModeTestToolTip(ifPressedShift := 0){
	global rAltMode
	global rAltModeList
	If(ifPressedShift == 1){
		ShowToolTip("测试:当前 rAlt 模式为： " rAltMode ": " rAltModeList[rAltMode] " (Shift 键已按下)")
	}else{
		ShowToolTip("测试:当前 rAlt 模式为： " rAltMode ": " rAltModeList[rAltMode])
	}
}

;*==== 工具提示条显示 **一秒钟**
ShowToolTip(str){
	ToolTip, %str%
	SetTimer, RemoveToolTip, -1000
}
RemoveToolTip:   ; 禁止删除，前面要用到，用于超时关闭工具提示
	ToolTip
return

;*=== 绕过输入法直接输入字符（无法绕过 IDE 智能感知）
SendBypassIME(str){
	SendInput, {Text}%str%
}

;*=== 使用剪贴板强制输入指定文本
SendByClipboard(str){
	lastClipboardString = Clipboard
	Clipboard = str
	Send, ^v
	Clipboard = lastClipboardString
}

;*=== 输入对称的括号
SendSymmetricSymbles(str){
	if (StrLen(str) == 2){	;文本长度必须为 2
		;支持输入单侧花括号后自动补全另一侧的 智能 IDE
		If (WinActive("ahk_exe vscode.exe") || WinActive("ahk_exe devenv.exe") || WinActive("ahk_exe qtcreator.exe") ){
			SendBypassIME(SubStr(str, 1, 1))
		;不支持输入单侧花括号自动补全另一侧的 智障 IDE
		}Else{
			SendBypassIME(str)
			Send, {Left}			
		}
	}else{
		Msgbox, Length of String should to be 2 in function Calling "SendSymmetricSymbles"
	}
}

;*=== 插入代码块并设置好缩进
SendCodeBlock(str){
	if (StrLen(str) == 2){	;文本长度必须为 2
		;支持输入单侧花括号后按下回车就可以创建代码块的智能 IDE
		If (WinActive("ahk_exe vscode.exe") || WinActive("ahk_exe devenv.exe") || WinActive("ahk_exe qtcreator.exe") ){
			SendBypassIME(SubStr(str, 1, 1))
			Send, {Enter}
		;支持输入双侧花括号，并控制光标后按下回车就可以创建代码块的 半智能 IDE
		}Else If (WinActive("ahk_exe UV4.exe")){
			SendSymmetricSymbles(str)
			Send, {Enter}
		;智障 IDE
		}Else{
			SendSymmetricSymbles(str)
			Send, {Enter 2}	{BackSpace}{Up} {Space 3}
		}		
	}else{
		Msgbox, Length of String should to be 2 in function Calling "SendCodeBlock"
	}	
}

;*移动鼠标，Dir=1左，2右，3上，4下； Increment 为每次移动像素点
MoveMouse(Dir, Increment)
{
	CoordMode,Mouse,Screen	;必须加入，适应多屏幕情况，否则会抽风
	MouseGetPos,x_pos,y_pos	;获取鼠标位置
	;MsgBox,  X:%x_pos% Y:%y_pos%, incr:%Increment%, Dir:%Dir%
	Switch Dir{	;加入方向增量
	case "Left":
		x_pos -= Increment
	case "Right":
		x_pos += Increment
	case "Up":
		y_pos -= Increment
	case "Down":
		y_pos += Increment
	default:
		MsgBox, 0x10, 错误, 移动鼠标：方向参数错误调用！
		return
	}
	;MsgBox,  X:%x_pos% Y:%y_pos%
	DllCall("SetCursorPos", "int", x_pos, "int", y_pos)	;移动鼠标指针到指定位置
	;MsgBox,  X:%x_pos% Y:%y_pos%
}

;* 打开网址, 要先确认打开的网址是合乎格式的
OpenURL(URL)
{
	run, %URL%
}

;*上网搜索东西
InternetSearch(text, searchEngine)
{

	

	
	; 检测输入的是一个网址还是一个搜索关键词
	; http://www.baidu.com
	; shttp://www.baidu.com
	;  https://www.baidu.com
	if((InStr(text, "https://") == 1) || InStr(text, "http://") == 1){ ; 如果输入的是一个网址
		OpenURL(text) ; 直接打开网址
		
	}else{ ; 输入一个搜索词
		Switch searchEngine{	; 根据搜索引擎选择搜索链接头
		case "Baidu":
			searchURL := "https://www.baidu.com/s?wd=dd"
		case "Bing":
			searchURL := "https://www.bing.com/search?q="
		case "Google":
			searchURL := "https://www.google.com/search?q="
		case "Yandex":
			searchURL := "https://yandex.com/search/?text="
		case "DuckDuckGo":
			searchURL := "https://duckduckgo.com/?q="
		case "Wechat":
			
		case "":
			MsgBox, 未指定搜索引擎
		Default:
			MsgBox, 0x10, 错误, 不知道这是什么搜索引擎捏
		}
		
		searchURL := searchURL . text ; 拼接文本
		OpenURL(searchURL) ; 打开链接
	}
}

;* 复制文本并搜索, 如果选中的是网址则打开网址
CopyTextAndSearch(searchEngine)
{
	lastClip := clipboard	; 将当前剪贴板内容备份一下, 执行本函数后还原回去
	send, ^c				; 复制文本到剪贴板
	Sleep, 20				; 暂停一段时间等它复制完
	Clip := clipboard		; 拷贝剪贴板
	
	Clip := Trim(Clip)				; 删掉网址或搜索词的前后空格
	;Msgbox, "%Clip%"
	;return
	InternetSearch(Clip, searchEngine) ; 搜索或打开网址
	
	clipboard := lastClip	; 恢复剪贴板为之前的状态	
	
}
;   asdf asdf asdf       http://www.baidu.com      1
;    asdf asdf 			asdf asdf 	asdf 		

;* 获取当前使用的输入法/键盘布局名字，输出文本依照全局变量
GetCurrentKeyboardLayoutName(InputLocaleID:=0)
{
	global installedKeyboardLayout  ; 声明全局变量
	getLayout := 0
	layoutName := ""
	
	if(InputLocaleID == 0){
		InputLocaleID := GetCurrentKeyboardLayoutCode()
	}
	
	for ID, nm in installedKeyboardLayout{
		if(InputLocaleID == ID){
			getLayout := 1
			layoutName = %nm%
			;MsgBox, Found
			break
		}
	}
	
	if(getLayout == 0){
		MsgBox, 0x10, 未识别到你的输入法, 程序还没录入当前的输入法，不认识捏
	}
	
	;MsgBox, layoutName: %layoutName%
	
	Return layoutName
}

GetCurrentKeyboardLayoutCode()
{
	WinGet, WinID,, A
	ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
	InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
	;DllCall("GetKeyboardLayout","int",0,UInt)
	
	If(InputLocaleID == 0){
		WinActivate, ahk_class WorkerW
		WinGet, WinID2,, ahk_class WorkerW
		ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID2, "UInt", 0)
		WinActivate, ahk_id %WinID%
		InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
	}	
	return InputLocaleID
}

;* 切换输入法中英/韩英问状态，适用于
ChangeIMEmode()
{
	layout := GetCurrentKeyboardLayoutCode() ; 获取当前的输入法
	switch (layout){
		case 134481924:	; Chinese_Simp
			If(rime_KeymapChanged == 0){	;切换汉英
				Send, ^+{F4}
			}else{
				Send, ^{F20} 
			}
			
		case 68289554:	; Korean	要求：设置中关闭 RAlt 映射到韩英切换键，改为专用的 韩文切换键
			SendHangulKey()  ;切换韩英
			
	}
}

;* 判断是否处于韩文输入法下, 输出 0 或者 1
IsInKoreanLayout()
{
	layout := GetCurrentKeyboardLayoutCode()
	
	If(layout == 68289554){	;* 如果处于韩文输入法下
		return 1
	}else{
		return 0
	}
}

SendHanjaKey()
{
	Send, {vk19}	; 汉字切换
}

SendHangulKey()
{
	Send, {vk15sc1F2}	;* 韩文键盘专有的「hangul」键
}

;* 发送鼠标滚动操作
WheelScroll(dir, steps:= 1, sleepTime := 15, isBlockInput := 1)
{
;   SetTitleMatchMode, 2
; 	IfWinActive, Microsoft Excel -
; 	{
; 	    ;SetScrollLockState, on
; 	    ComObjActive("Excel.Application").ActiveWindow.SmallScroll(0,0,2,0)
; 	    ;SetScrollLockState, off
; 	}
; 	else IfWinActive, PowerPoint
; 	    ComObjActive("PowerPoint.Application").ActiveWindow.SmallScroll(0,0,3,0)
; 	else IfWinActive, Adobe Acrobat Professional -
; 	{
; 	    send,+{right}
; 	}
; 	else IfWinActive, - Mozilla Firefox
; 	{
; 	    Loop 4
; 	        send,{right}
; 	}
; 	else
; 	{
; 	    ControlGetFocus, FocusedControl, A
; 	    Loop 10
; 	        SendMessage, 0x114, 1, 0, %FocusedControl%, A  ; 0x114 is WM_HSCROLL ; 1 vs. 0 causes SB_LINEDOWN vs. UP
; 	}	
	
	;%A_Index%
	
	If(isBlockInput == 1){ ;* 屏蔽外界输入
		;Msgbox, block
		BlockInput, On
	}
	;If WinActive(ahk_exe vscode.exe){  ;^ 保留备用
	
 	;* 直接发送鼠标横向滚动键
	Switch dir{
		case "up":
		;Msgbox, scrool up
			Send, {WheelUp %steps%}
			; Loop %steps%{
			; 	Send, {WheelUp}
			; 	Sleep, %sleepTime%
			; 	;Msgbox, scrool up
			; }
		case "down":
			Send, {WheelDown %steps%}		
		case "left":
			Send, {WheelLeft %steps%}	
		case "right":
			Send, {WheelRight %steps%}	
		Default:
			MsgBox, 0x10, 方向指令无效, 方向指令无效，请输入小写字母的"up""down""left""right"
			;return
	}
	
	If(isBlockInput == 1){ ;* 恢复外界输入
		BlockInput, Off
		;Msgbox, block
	}
}

;* 无格式粘贴文本, 同时会清除复制内容的左右空格或制表符
PasteWithoutFormat()
{
	cb := Clipboard
	cb := Trim(cb)
	Send ^v
}


;* 高级粘贴文本功能
AdvancedPaste()
{
	cb := Clipboard
	cb_original := cb
	
	; 清除字符串左右两侧空白符
	cb := Trim(cb)
	
	; 清除字符串的所有换行符
	cb := StrReplace(cb, "`n")
	cb := StrReplace(cb, "`r")
	
	
	; 如果字符串被一对半角双引号或单引号引用, 则解引用
	; 注: AHK中, 字符串中的引号要打两次, 而不是通过通配符来实现
	; SubStr函数第二个参数为开始位置,
	;	1为第一个字符,0为最后一个字符,-1为倒数第二个字符, 
	;   第三个参数为字符长度
	;if((SubStr(cb, 1, 1) == """") && (SubStr(cb, 0, 1) == """")){
	if(ReGexMatch(cb, "^['""](.*)['""]$") != 0){
		cb_len := StrLen(cb)
		cb := SubStr(cb, 2, cb_len - 2)
		
	}
	
	; 如果字符串是个 url, 则取其域名
	if(ReGexMatch(cb, "^(http|https|ftp):\/\/(.+)") != 0){
		RegExMatch(cb, "\/\/([\w\.\d-]+)", cb_domain)
		cb_len := StrLen(cb_domain)
		cb := SubStr(cb_domain, 3, cb_len)
	}
	
	; 如果字符串是个 file://开头的 Windows 格式的文件路径, 则去除头部的 "File://" 字符
	if(RegExMatch(cb, "^file:\/\/(.+)")){
		cb_len := StrLen(cb)
		cb := SubStr(cb, 8, cb_len)
	}
	
	; 粘贴文本
	Clipboard := cb
	Send ^v
	
	;剪贴板恢复原状
	Clipboard := cb_original
	
}

;* 对字符串去除左右两侧的双引号
UnquoteString(str)
{
	str := Trim(str)
	
}

ClearHttpsInString(str)
{
	str := Trim(str)
	
}

;* 清除字符串所有换行符
ClearLineBreakInString(str)
{
	
}


;^================================= RAlt 模式具体方案列表：==================================
; RAlt
;*   ========================== 0 OFF 模式，关闭所有热键 =============================
#If rAltMode == 0
	F23 & Tab::return
	F23 & CapsLock::return
	F23 & Space::return
	;F23 & Enter::return
	;F23 & BackSpace::return
	F23 & `::return
	F23 & 1::return
	F23 & 2::return
	F23 & 3::return
	F23 & 4::return
	F23 & 5::return	
	F23 & 6::return
	F23 & 7::return
	F23 & 8::return
	F23 & 9::return
	F23 & 0::return
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
#If




;*   =========================== 1 编程模式 =================================
#If rAltMode == 1
	F23 & CapsLock::return
	F23 & Space::return
	;F23 & Enter::return
	;F23 & BackSpace::return
	F23 & `::return
	
	F23 & Tab::
		if (GetKeyState("Shift")){		
			Send, `t
		}else{
			Send, {Space 4}
		}		
	return
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
	F23 & 9::
		if (GetKeyState("Shift")){
			
		}else{
			SendSymmetricSymbles("()")
		}
	return
	F23 & 0::
		if (GetKeyState("Shift")){
			
		}else{
			;Send, {Left}{BackSpace}{Right}
		}
	return
	F23 & -::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("_")
		}
	return
	F23 & =::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & [::
		if (GetKeyState("Shift")){
			SendSymmetricSymbles("{}")
		}else{
			SendSymmetricSymbles("[]")
		}
	return
	F23 & ]::
		if (GetKeyState("Shift")){
			SendCodeBlock("{}")
		}else{
			SendCodeBlock("[]")
		}
	return
	F23 & \::
		if (GetKeyState("Shift")){
			SendBypassIME("|")
		}else{
			SendBypassIME("\")
		}
	return	
	F23 & `;::
		if (GetKeyState("Shift")){
			SendBypassIME(":")
		}else{
			SendBypassIME(";")
		}
	return
	F23 & '::
		if (GetKeyState("Shift")){
			SendSymmetricSymbles("""""")
			
		}else{
			SendSymmetricSymbles("''")
			
		}
	return
	F23 & ,::
		if (GetKeyState("Shift")){
			
		}else{
			SendInput, {Text},
		}
	return
	F23 & .::
		if (GetKeyState("Shift")){
			SendBypassIME("->")
		}else{
			SendBypassIME(".")
		}
	return
	F23 & /::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & a::
		if (GetKeyState("Shift")){
			
		}else{
			Send, +{Left}
		}
	return
	F23 & b::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F23 & c::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F23 & d::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Down}
		}
	return
	F23 & e::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Up}
		}
	return
	F23 & f::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Right}
		}
	return
	F23 & g::
		if (GetKeyState("Shift")){
			
		}else{
			Send, +{Right}
		}
	return
	F23 & h::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & i::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F23 & j::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & k::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & l::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & m::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & n::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & o::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F23 & p::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & q::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^+{Left}
		}
	return
	F23 & r::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^{Right}
		}
	return
	F23 & s::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Left}
		}
	return
	F23 & t::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^+{Right}
		}
	return
	F23 & u::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & v::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & w::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^{Left}
		}
	return
	F23 & x::
		if (GetKeyState("Shift")){
				
		}else{
			
		}
	return
	F23 & y::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F23 & z::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
#If



;*   ============================= 2 统一字母输入模式 ===============================
#If rAltMode == 2

	F23 & Tab::return
	F23 & CapsLock::return
	F23 & Space::return
	;F23 & Enter::return
	;F23 & BackSpace::return
	F23 & `::return
	
	F23 & 1::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & 2::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & 3::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & 4::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & 5::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F23 & 6::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & 7::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & 8::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & 9::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & 0::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & -::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & =::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & [::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & ]::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & \::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F23 & `;::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & '::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & ,::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & .::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & /::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F23 & a::
		if (GetKeyState("Shift")){
			SendRaw, Ä
		}else{
			SendRaw, ä
		}
	return
	F23 & b::
		if (GetKeyState("Shift")){
			SendRaw, Ḉ
		}else{
			SendRaw, ḉ
		}
	return	
	F23 & c::
		if (GetKeyState("Shift")){
			SendRaw, Ć
		}else{
			SendRaw, ć
		}
	return	
	F23 & d::
		if (GetKeyState("Shift")){
			SendRaw, Ɖ
		}else{
			SendRaw, đ
		}
	return
	F23 & e::
		if(GetKeyState("Shift")) 
			SendRaw, Ĕ
		else 
			SendRaw, ĕ 
		return
	F23 & f::
		if (GetKeyState("Shift")){
			SendRaw, Ğ
		}else{
			SendRaw, ğ
		}
	return
	F23 & g::
		if (GetKeyState("Shift")){
			SendRaw, Ǵ
		}else{
			SendRaw, ǵ
		}
	return
	F23 & h::
		if (GetKeyState("Shift")){
			SendRaw, Ħ
		}else{
			SendRaw, ħ
		}
	return
	F23 & i::
		if (GetKeyState("Shift")){
			SendRaw, Ï
		}else{
			SendRaw, ï
		}
	return	
	F23 & j::
		if (GetKeyState("Shift")){
			SendRaw, Ë
		}else{
			SendRaw, ë
		}
	return
	F23 & k::
		if (GetKeyState("Shift")){
			SendRaw, Ꝁ
		}else{
			SendRaw, ꝁ
		}
	return
	F23 & l::
		if (GetKeyState("Shift")){
			SendRaw, Ł
		}else{
			SendRaw, ł
		}
	return
	F23 & m::
		if (GetKeyState("Shift")){
			SendRaw, Ñ
		}else{
			SendRaw, ñ
		}
	return
	F23 & n::
		if (GetKeyState("Shift")){
			SendRaw, Ń
		}else{
			SendRaw, ń
		}
	return
	F23 & o::
		if (GetKeyState("Shift")){
			SendRaw, Ö
		}else{
			SendRaw, ö
		}
	return	
	F23 & p::
		if (GetKeyState("Shift")){
			SendRaw, Ᵽ
		}else{
			SendRaw, ᵽ
		}
	return
	F23 & q::
		if (GetKeyState("Shift")){
			SendRaw, Ꝗ
		}else{
			SendRaw, ꝗ
		}
	return
	F23 & r::
		if (GetKeyState("Shift")){
			SendRaw, Ŕ
		}else{
			SendRaw, ŕ
		}
	return
	F23 & s::
		if (GetKeyState("Shift")){
			SendRaw, Ś
		}else{
			SendRaw, ś
		}
	return
	F23 & t::
		if (GetKeyState("Shift")){
			SendRaw, Ŧ
		}else{
			SendRaw, ŧ
		}
	return
	F23 & u::
		if (GetKeyState("Shift")){
			SendRaw, Ü
		}else{
			SendRaw, ü
		}
	return
	F23 & v::
		if (GetKeyState("Shift")){
			SendRaw, Ç
		}else{
			SendRaw, ç
		}
	return
	F23 & w::
		if (GetKeyState("Shift")){
			SendRaw, Ẅ
		}else{
			SendRaw, ẅ
		}
	return
	F23 & x::
		if (GetKeyState("Shift")){
			SendRaw, Ẍ
		}else{
			SendRaw, ẍ
		}
	return
	F23 & y::
		if (GetKeyState("Shift")){
			SendRaw, Ÿ
		}else{
			SendRaw, ÿ
		}
	return	
	F23 & z::
		if (GetKeyState("Shift")){
			SendRaw, Ź
		}else{
			SendRaw, ź
		}
	return
#If






;*  ============================= 3 ____ 模式 =============================






