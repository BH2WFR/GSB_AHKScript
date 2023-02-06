﻿
;** ====================== GSB_AKHScript ======================
;|       版本：v0.2.5_dev3(alpha)             作者：GSB Electronic       |
;|      AHK 最低支持版本：                      
;**|      提示：需要管理员权限，请以管理员权限启动！
;|  代码仓库：https://github.com/BH2WFR/GSB_AHKScript.git
;| 汉字提交 
;============================================================

;! ======================= 使用说明和注意事项：=====================
/** 要先使用 PowerToys 等工具物理映射下列按键：
;*			右Alt		->	F13
;*			CapsLock 	->	F14
;* 朝鲜语输入法设置中需要将键盘布局设置为：Keyboard layout: Korean keyboard (101 key) Type 1，把韩文切换键和汉字键映射到专用按键上
; 			Hangul Key:{vk15sc1F2}     Hanja Key:sc1F1
;
;				功能	|				默认映射			|		更改后映射		|    
;			弹出菜单	|			F4 或 Ctrl+{`}					F20 或 Ctrl+Shift+{`(grave)}
;			中英切换	|	Ctrl+Shift+2 或 Shift 或 Caps			Ctrl+F20
;			全角/半角	|		Ctrl+Shift+3 						Ctrl+Shift+F20
;			繁简切换	|		Ctrl+Shift+4 或 F4,1,4				Control+Shift+F21
;			增广字集			Ctrl+Shift+5						Shift+F21
;			中英标点	|		F4,1,5								Ctrl+F21	
; 			输入法切换	|     .next  Ctrl+Shift+1					Shift+F20
;*=========== key_bindings.yaml 中，改成：
;    - { when: always, accept: Shift+F20, select: .next }
 ;   - { when: always, accept: Control+F20, toggle: ascii_mode }
;    - { when: always, accept: Control+Shift+F20, toggle: full_shape }
;    - { when: always, accept: Control+Shift+F21, toggle: simplification }
;    - { when: always, accept: Shift+F21, toggle: extended_charset }
;    - { when: always, accept: Ctrl+F21, toggle: ascii_punct }
;---------------------------------------------------------------------------------
*/


;TODO =================== 未来完成的功能 ============================

; 小狼毫 把各种全局快捷键全部改掉，利用各种物理键盘不存在的键
; 识别当前输入法，中文/韩文输出键不同



;*================  启动时申请管理员权限 =================
; if (! A_IsAdmin){ ;http://ahkscript.org/docs/Variables.htm#IsAdmin
; 	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
; 	ExitApp
; }
#If 0
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
#If


;*===========================  全局变量 ========================
; 使用时要在函数头部中声明一次这个变量, 否则无法使用, 格式: global isTestMode
isTestMode := 1		; 是否处于测试模式
rAltMode := 1		; 默认 RAlt 特殊模式，0 为关闭状态
rAltModeList := {0:"OFF", 1:"Programming Mode", 2:"Galian Script", 3:"Esp Script", 4:"Colemak Input"}
MouseQuickMoveUnitPixels := 30  ;F13+Shift+方向键 快速移动鼠标速度（每次移动的像素点个数) 


verticalScroll_inverseDir := 0  ; 横向滚动是否相反方向


;^ 系统安装的输入法语言代码：
installedKeyboardLayout := {134481924:"Chinese,Simplicated", 68289554:"Korean", 67699721:"English,US,QWERTY"}
;Layout_ChineseSimp_Code := 134481924
;Layout_Korean_Code := 68289554

;IMEmodeChangeKey := 1   ; ==0:Shift切换，1:F14(Caps)切换, 2:Ctrl+Space 切换 3: Ctrl切换
rime_KeymapChanged := 1	; 小狼毫 快捷键是否非默认状态
installed_Korean := 1
installed_English_US := 1
use_test_getIMEcode := 1 ; F16键弹出对话框显示当前输入法代号

;^ 是否启用模块功能
use_RimeInput := 1
use_Anki := 1
use_AutoCAD := 1
use_Explorer_CopyFullPath := 1 


;*=========================  全局热键   ============================

;* F13 释放时触发正常的 F13 功能
$F13 Up::
	layout := GetCurrentKeyboardLayoutCode()
	
	If(layout == 68289554){	; 如果处于韩文输入法下
		Send, {vk19}	; 汉字切换
	}else{
		Send {F13} ; 释放正常 RAlt 点击
	}
	
return


;*================ Excel 中： F13+Enter 直接输出原本的 Alt+Enter
; EXCEL, wps, libreoffice 中
#If WinActive("ahk_exe EXCEL.EXE") || WinActive("ahk_exe wps.exe") || WinActive("ahk_exe soffice.exe") 
F13 & Enter::
	;If (WinActive("ahk_exe EXCEL.EXE") || WinActive("ahk_exe wps.exe") || WinActive("ahk_exe soffice.exe")){	
		Send, !{Enter}
	;}
return
#If


;*=============== 全局：F13
F14 & Backspace::
F13 & Backspace::	;* 删除二字词的第一个字
	Send, {Left}{Backspace}{Right}
return
F13 & Esc::   ;* 查看当前 RAlt 模式
	if (GetKeyState("Shift")){
		AltModeTestToolTip(1)
	}else{
		AltModeTestToolTip()
	}
return
F13 & F1::SetRAltMode(1)	; 设置 RAlt 模式
F13 & F2::SetRAltMode(2)
F13 & F3::return
F13 & F4::return
F13 & F5::return
F13 & F6::return
F13 & F7::return
F13 & F8::return
F13 & F9::return
F13 & F10::return
F13 & F11::return
F13 & F12::return
F13 & PrintScreen::return
F13 & ScrollLock::return
F13 & Home::return
F13 & End::return
F13 & PgUp::return
F13 & PgDn::return
F13 & Delete::SetRAltMode(0)	;关闭RAlt模式



;*======================  输入法 特殊热键, 注意: 要先使用其他软件将 CapsLock 映射为 F14
;GetKeyState("CapsLock", "T") = 1
;SetCapsLockState, on

;* CapsLock 或 CapsLock+2 切换中英文
F14 Up::
F14 & 2::
	ChangeIMEmode()
return

;* Ctrl+CapsLock 切换大小写锁定
^F14::
	if(GetKeyState("CapsLock", "T") = 1){
		SetCapsLockState, Off
	}else{
		SetCapsLockState, On
	}
return
		
		
#If use_RimeInput == 1	; 仅适用于魔改快捷键的小狼毫输入法
	#If rime_KeymapChanged == 0
		; TODO: CapsLock+Space 调出小狼毫菜单
		F14 & Space::
		F14 & `::
			Send, ^``	;注意通配符, grave 是 两个``
		return
		;TODO: CapsLock+3 全角/半角
		F14 & 3::
			Send, ^+{3}
		return
		;TODO: CapsLock+4 简繁体转换
		F14 & 4::
			Send, ^+{4}
		return
		;TODO: CapsLock+5 增廣字集
		F14 & 5::
			Send, ^+{5}
		return		
		;TODO: CapsLock+. 中英标点
		F14 & .::
			
		return
	#If rime_KeymapChanged == 1	;* 魔改快捷键后
		; TODO: CapsLock+Space 调出小狼毫菜单
		F14 & Space::
		F14 & `::
			Send, {F20}	;注意通配符, grave 是 两个``
		return
		F14 & 1::
			Send, +{F20}
		return
		;TODO: CapsLock+3 全角/半角
		F14 & 3::
			Send, ^+{F20}
		return
		;TODO: CapsLock+4 简繁体转换
		F14 & 4::
			Send, ^+{F21}
		return
		;TODO: CapsLock+5 增廣字集
		F14 & 5::
			Send, +{F21}
		return		
		;TODO: CapsLock+. 中英标点
		F14 & .::
			Send, ^{F21}
		return		
	#If
#If

;*== 其余 CapsLock 快捷键, 用掉一个注释一个
F14 & Tab::return		;
;F14 & CapsLock::return	;无效组合
;F14 & Space::return	;输入法占用
F14 & Enter::return		;
;F14 & BackSpace::return	; 重映射到 F13+Backspace，代码在前面，去除二字汉字词的第一个字
;F14 & `::return		;
F14 & 1::return			;
;F14 & 2::return		;输入法占用
;F14 & 3::return		;输入法占用
;F14 & 4::return		;输入法占用
;F14 & 5::return		;输入法占用
F14 & 6::return			;
F14 & 7::return			;
F14 & 8::return	;
F14 & 9::return	;
F14 & 0::return	;
F14 & -::return	;
F14 & =::return	;
F14 & [::return	;        "	""	"
F14 & ]::return	;
F14 & \::return	;		;
F14 & `;::return		;
F14 & '::return	;
F14 & ,::return		;
F14 & .::return		;
F14 & /::return		;
F14 & a::CopyTextAndSearch("Baidu")
F14 & b::CopyTextAndSearch("Bing")	;F14+C 复制当前选中文本并网上搜索, 如果选中的是链接则打开链接
F14 & c::Send, ^{c} ;* 复制
F14 & d::Run, D:\
F14 & e::return	;
F14 & f::return	;
F14 & g::CopyTextAndSearch("Google")
F14 & h::return	;
F14 & i::return	;		;
F14 & j::return	;
F14 & k::return	;
F14 & l::Run, D:\Downloads
F14 & m::return	;
F14 & n::return	;
F14 & o::return	;		;
;F14 & p::return	; 后面的复制路径程序
F14 & q::return	;
F14 & r::return	;
F14 & s::Run, C:\
F14 & t::Run, TaskMgr.exe	; 打开任务管理器
F14 & u::return	;
F14 & v::Send, ^{v}	;* 粘贴
F14 & w::return	;
F14 & x::Send, ^{x}	;* 剪切
F14 & y::return	;		;
F14 & z::return	;	

;*======================== 程序特殊热键   ========================


;* Anki： 鼠标特殊键触发文本加粗和标红
#If use_Anki == 1
	#If WinActive("ahk_exe anki.exe") && (WinActive("Add") || WinActive("Edit Current")) ; 编辑窗口中
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

;* AutoCAD 快捷键映射
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
	F20::
		Send {CtrlDown}{CtrlUp}
	return
#IfWinActive

; MDK中：
#IfWinActive ahk_exe UV4.exe
	;快捷输入主函数


#IfWinActive

;*======   Explorer 中，按 F13+C 复制选中文本的完整地址到剪贴板
#If use_Explorer_CopyFullPath == 1
	F13 & P:: ; Select the shot folders in Explorer, then hit WIN + P , after a few moments the file path of the first EXR in each shot will be added 
	
	return

#If

;TODO ============ 测试代码：当前键盘布局和输入法
#If use_test_getIMEcode == 1
	F16:: 
		InputLocaleID := GetCurrentKeyboardLayoutCode()
		;MsgBox, 0x40, 输入法%InputLocaleID%
		InputName := GetCurrentKeyboardLayoutName()
		MsgBox,  0x40, 当前输入法检测, ID:   %InputLocaleID% `nName: %InputName%
	return
#If
;========================  系统级别特殊功能：=====================



;*========== RAlt+方向键 以像素为单位移动鼠标指针, 加上 Shift 后快速移动鼠标
#If 1

F13 & Right::
F13 & Left::
F13 & Up::
F13 & Down::
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


F13 & RWin::
	Send, {LButton}
return
F13 & AppsKey::
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
return
 
~LWin & WheelDown::
#F2::
;透明度调整，减少。
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
#If (verticalScroll_inverseDir == 1)
	F13 & WheelDown::
		if (GetKeyState("Shift")){
			Send, {WheelLeft 3} 
		}else{
			Send, {WheelLeft}
		}
	return
	F13 & WheelUp::
		if (GetKeyState("Shift")){
			Send, {WheelRight 3}
		}else{
			Send, {WheelRight}
		}
	return
#If (verticalScroll_inverseDir == 0)
	F13 & WheelDown::
		if (GetKeyState("Shift")){
			Send, {WheelRight 3} 
		}else{
			Send, {WheelRight}
		}
	return
	F13 & WheelUp::
		if (GetKeyState("Shift")){
			Send, {WheelLeft 3}
		}else{
			Send, {WheelLeft}
		}
	return
#If


;* ================ Caps+鼠标滚轮  纵向滚动, 加 Shift 更快速
F14 & WheelDown::
	if (GetKeyState("Shift")){
		;Send, {WheelDown 6}
	}else{
		Send, {WheelDown 4}
	}
return
F14 & WheelUp::
	if (GetKeyState("Shift")){
		;Send, {WheelDown 6}
	}else{
		Send, {WheelUp 4}
	}
return




 
;*===================================== 自制函数 =======================================
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

;移动鼠标，Dir=1左，2右，3上，4下； Increment 为每次移动像素点
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
		MsgBox, 移动鼠标：方向参数错误调用！
		return
	}
	;MsgBox,  X:%x_pos% Y:%y_pos%
	DllCall("SetCursorPos", "int", x_pos, "int", y_pos)	;移动鼠标指针到指定位置
	;MsgBox,  X:%x_pos% Y:%y_pos%
}

; 打开网址, 要先确认打开的网址是合乎格式的
OpenURL(URL)
{
	run, %URL%
}

;上网搜索东西
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
			MsgBox, 不知道这是什么搜索引擎捏
		}
		
		searchURL := searchURL . text ; 拼接文本
		OpenURL(searchURL) ; 打开链接
	}
}

; 复制文本并搜索, 如果选中的是网址则打开网址
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
	layout := GetCurrentKeyboardLayoutCode()
	switch (layout){
		case 134481924:	; Chinese_Simp
			If(rime_KeymapChanged == 0){
				Send, ^+{F4}
			}else{
				Send, ^{F20} 
			}
			
		case 68289554:	; Korean	要求：设置中关闭 RAlt 映射到韩英切换键，改为专用的 韩文切换键
			Send, {vk15sc1F2}
			
	}
}



;*=============================== RAlt 特殊方案列表：================================
;*    ========= 0 OFF 模式，关闭所有热键 ===============
#If rAltMode == 0
	F13 & Tab::return
	F13 & CapsLock::return
	F13 & Space::return
	;F13 & Enter::return
	;F13 & BackSpace::return
	F13 & `::return
	F13 & 1::return
	F13 & 2::return
	F13 & 3::return
	F13 & 4::return
	F13 & 5::return	
	F13 & 6::return
	F13 & 7::return
	F13 & 8::return
	F13 & 9::return
	F13 & 0::return
	F13 & -::return
	F13 & =::return
	F13 & [::return
	F13 & ]::return
	F13 & \::return	
	F13 & `;::return
	F13 & '::return
	F13 & ,::return
	F13 & .::return
	F13 & /::return
	F13 & a::return
	F13 & b::return	
	F13 & c::return	
	F13 & d::return
	F13 & e::return
	F13 & f::return
	F13 & g::return
	F13 & h::return
	F13 & i::return	
	F13 & j::return
	F13 & k::return
	F13 & l::return
	F13 & m::return
	F13 & n::return
	F13 & o::return	
	F13 & p::return
	F13 & q::return
	F13 & r::return
	F13 & s::return
	F13 & t::return
	F13 & u::return
	F13 & v::return
	F13 & w::return
	F13 & x::return
	F13 & y::return	
	F13 & z::return	
#If




;*   =========== 1 编程模式 =================
#If rAltMode == 1
	F13 & CapsLock::return
	F13 & Space::return
	;F13 & Enter::return
	;F13 & BackSpace::return
	F13 & `::return
	
	F13 & Tab::
		if (GetKeyState("Shift")){		
			Send, `t
		}else{
			Send, {Space 4}
		}		
	return
	F13 & 1::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("!")
		}
	return
	F13 & 2::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("@")
		}
	return
	F13 & 3::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("#")
		}
	return
	F13 & 4::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("$")
		}
	return
	F13 & 5::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("%")
		}
	return	
	F13 & 6::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("^")
		}
	return
	F13 & 7::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("&")
		}
	return
	F13 & 8::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("*")
		}
	return
	F13 & 9::
		if (GetKeyState("Shift")){
			
		}else{
			SendSymmetricSymbles("()")
		}
	return
	F13 & 0::
		if (GetKeyState("Shift")){
			
		}else{
			;Send, {Left}{BackSpace}{Right}
		}
	return
	F13 & -::
		if (GetKeyState("Shift")){
			
		}else{
			SendBypassIME("_")
		}
	return
	F13 & =::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & [::
		if (GetKeyState("Shift")){
			SendSymmetricSymbles("{}")
		}else{
			SendSymmetricSymbles("[]")
		}
	return
	F13 & ]::
		if (GetKeyState("Shift")){
			SendCodeBlock("{}")
		}else{
			SendCodeBlock("[]")
		}
	return
	F13 & \::
		if (GetKeyState("Shift")){
			SendBypassIME("|")
		}else{
			SendBypassIME("\")
		}
	return	
	F13 & `;::
		if (GetKeyState("Shift")){
			SendBypassIME(":")
		}else{
			SendBypassIME(";")
		}
	return
	F13 & '::
		if (GetKeyState("Shift")){
			SendSymmetricSymbles("""""")
			
		}else{
			SendSymmetricSymbles("''")
			
		}
	return
	F13 & ,::
		if (GetKeyState("Shift")){
			
		}else{
			SendInput, {Text},
		}
	return
	F13 & .::
		if (GetKeyState("Shift")){
			SendBypassIME("->")
		}else{
			SendBypassIME(".")
		}
	return
	F13 & /::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & a::
		if (GetKeyState("Shift")){
			
		}else{
			Send, +{Left}
		}
	return
	F13 & b::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & c::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & d::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Down}
		}
	return
	F13 & e::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Up}
		}
	return
	F13 & f::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Right}
		}
	return
	F13 & g::
		if (GetKeyState("Shift")){
			
		}else{
			Send, +{Right}
		}
	return
	F13 & h::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & i::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & j::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & k::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & l::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & m::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & n::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & o::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & p::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & q::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^+{Left}
		}
	return
	F13 & r::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^{Right}
		}
	return
	F13 & s::
		if (GetKeyState("Shift")){
			
		}else{
			Send, {Left}
		}
	return
	F13 & t::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^+{Right}
		}
	return
	F13 & u::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & v::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & w::
		if (GetKeyState("Shift")){
			
		}else{
			Send, ^{Left}
		}
	return
	F13 & x::
		if (GetKeyState("Shift")){
				
		}else{
			
		}
	return
	F13 & y::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & z::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
#If



;   ========== 2 Galia输入法模式 ============
#If rAltMode == 2

	F13 & Tab::return
	F13 & CapsLock::return
	F13 & Space::return
	;F13 & Enter::return
	;F13 & BackSpace::return
	F13 & `::return
	
	F13 & 1::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 2::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 3::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 4::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 5::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & 6::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 7::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 8::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 9::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & 0::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & -::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & =::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & [::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & ]::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & \::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return	
	F13 & `;::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & '::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & ,::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & .::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & /::
		if (GetKeyState("Shift")){
			
		}else{
			
		}
	return
	F13 & a::
		if (GetKeyState("Shift")){
			SendRaw, Ä
		}else{
			SendRaw, ä
		}
	return
	F13 & b::
		if (GetKeyState("Shift")){
			SendRaw, Ḉ
		}else{
			SendRaw, ḉ
		}
	return	
	F13 & c::
		if (GetKeyState("Shift")){
			SendRaw, Ć
		}else{
			SendRaw, ć
		}
	return	
	F13 & d::
		if (GetKeyState("Shift")){
			SendRaw, Ɖ
		}else{
			SendRaw, đ
		}
	return
	F13 & e::
		if(GetKeyState("Shift")) 
			SendRaw, Ĕ
		else 
			SendRaw, ĕ 
		return
	F13 & f::
		if (GetKeyState("Shift")){
			SendRaw, Ğ
		}else{
			SendRaw, ğ
		}
	return
	F13 & g::
		if (GetKeyState("Shift")){
			SendRaw, Ǵ
		}else{
			SendRaw, ǵ
		}
	return
	F13 & h::
		if (GetKeyState("Shift")){
			SendRaw, Ħ
		}else{
			SendRaw, ħ
		}
	return
	F13 & i::
		if (GetKeyState("Shift")){
			SendRaw, Ï
		}else{
			SendRaw, ï
		}
	return	
	F13 & j::
		if (GetKeyState("Shift")){
			SendRaw, Ë
		}else{
			SendRaw, ë
		}
	return
	F13 & k::
		if (GetKeyState("Shift")){
			SendRaw, Ꝁ
		}else{
			SendRaw, ꝁ
		}
	return
	F13 & l::
		if (GetKeyState("Shift")){
			SendRaw, Ł
		}else{
			SendRaw, ł
		}
	return
	F13 & m::
		if (GetKeyState("Shift")){
			SendRaw, Ñ
		}else{
			SendRaw, ñ
		}
	return
	F13 & n::
		if (GetKeyState("Shift")){
			SendRaw, Ń
		}else{
			SendRaw, ń
		}
	return
	F13 & o::
		if (GetKeyState("Shift")){
			SendRaw, Ö
		}else{
			SendRaw, ö
		}
	return	
	F13 & p::
		if (GetKeyState("Shift")){
			SendRaw, Ᵽ
		}else{
			SendRaw, ᵽ
		}
	return
	F13 & q::
		if (GetKeyState("Shift")){
			SendRaw, Ꝗ
		}else{
			SendRaw, ꝗ
		}
	return
	F13 & r::
		if (GetKeyState("Shift")){
			SendRaw, Ŕ
		}else{
			SendRaw, ŕ
		}
	return
	F13 & s::
		if (GetKeyState("Shift")){
			SendRaw, Ś
		}else{
			SendRaw, ś
		}
	return
	F13 & t::
		if (GetKeyState("Shift")){
			SendRaw, Ŧ
		}else{
			SendRaw, ŧ
		}
	return
	F13 & u::
		if (GetKeyState("Shift")){
			SendRaw, Ü
		}else{
			SendRaw, ü
		}
	return
	F13 & v::
		if (GetKeyState("Shift")){
			SendRaw, Ç
		}else{
			SendRaw, ç
		}
	return
	F13 & w::
		if (GetKeyState("Shift")){
			SendRaw, Ẅ
		}else{
			SendRaw, ẅ
		}
	return
	F13 & x::
		if (GetKeyState("Shift")){
			SendRaw, Ẍ
		}else{
			SendRaw, ẍ
		}
	return
	F13 & y::
		if (GetKeyState("Shift")){
			SendRaw, Ÿ
		}else{
			SendRaw, ÿ
		}
	return	
	F13 & z::
		if (GetKeyState("Shift")){
			SendRaw, Ź
		}else{
			SendRaw, ź
		}
	return
#If






;    ========= 3 Esp 模式 ================


