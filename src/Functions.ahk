; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}
; 函数

;* RAltMode 工具提示，加入对具体模式专用功能开关状态的提示
AttachRAltModeTooltipString(mode, ByRef str)
{
	global flag_remapMinusToUnderline	
	global rAltMode
	
	str := str . "`n  "
	
	switch mode{
		case 0:
			str := str . "RAlt特殊功能已关闭！"
		case 1:
			
			if(flag_remapMinusToUnderline == 1){
				str := str . "已开启 减号_下划线交换功能"
			}else{
				str := str . "已关闭 减号_下划线交换功能"
			}
		case 2:
			str := str . "已适配 2023 年 2 月新版试验性字母"
		Default:
			MsgBox, 0x10, "切换 RAlt 模式：不支持的值", "无效的 RAlt 值"
	}	
	
	
}

;* ===设置 RAlt 模式并弹出工具条提示
SetRAltMode(mode)
{
	global rAltMode
	global rAltModeList
	global flag_remapMinusToUnderline
	rAltMode := mode
	
	str := "切换到 rAlt 模式：" rAltMode ": " rAltModeList[rAltMode]
	
	; if(mode != 1){
	; 	lag_remapMinusToUnderline == 0
	; }
	
	AttachRAltModeTooltipString(mode, str)
	
	ReleaseShiftCtrlAltKeys()
	SetCapsLockState, 0		; 关闭大写锁定，防止抽风
	
	ShowToolTip(str)
	
}

;*==== 工具提示条显示当前模式
AltModeTestToolTip(ifPressedShift := 0){
	global rAltMode
	global rAltModeList
	str := " 当前状态:`n当前 rAlt 模式为： " rAltMode ": " rAltModeList[rAltMode]
	
	If(ifPressedShift == 1){
		str :=  str . " `n (Shift 键已按下)"
	}else{
		
	}
	
	AttachRAltModeTooltipString(rAltMode, str)
	
	ShowToolTip(str)
}

;*==== 工具提示条显示 **一秒钟**
ShowToolTip(ByRef str, time:=1000){
	ToolTip, %str%
	time := -time
	SetTimer, RemoveToolTip, %time%
}
RemoveToolTip:   ; 禁止删除，前面要用到，用于超时关闭工具提示
	ToolTip
return


;*检测当前文本输入器或IDE是什么类型返回类型如下表: VS/VSCode/QtCreator:1, VC6.0/Keil uv:2/notepad++:2, Notepad等无代码写作功能文本框:0
GetNotebookType(){
	;支持输入单侧花括号后按下回车就可以创建代码块的智能 IDE
	If (WinActive("ahk_exe vscode.exe") || WinActive("ahk_exe devenv.exe") || WinActive("ahk_exe qtcreator.exe") ){
		return 1
		
	;支持输入双侧花括号，并控制光标后按下回车就可以创建代码块的 半智能 IDE
	}Else If (WinActive("ahk_exe UV4.exe")){
		return 2
		
	;智障 IDE
	}Else{
		return 0
	}		
}



;*移动鼠标，Dir=1左，2右，3上，4下； Increment 为每次移动像素点
MoveMouse(ByRef Dir, Increment)
{
	CoordMode,Mouse,Screen	;必须加入，适应多屏幕情况，否则会抽风
	MouseGetPos,x_pos,y_pos	;获取鼠标位置
	;MsgBox,  X:%x_pos% Y:%y_pos%, incr:%Increment%, Dir:%Dir%
	Switch Dir{	;加入方向增量
		case "Left", "left", "L", "l", "←":
			x_pos -= Increment
		case "Right", "right","R", "r", "→":
			x_pos += Increment
		case "Up", "up", "U", "u", "↑":
			y_pos -= Increment
		case "Down", "down", "D", "d", "↓":
			y_pos += Increment
		default:
			MsgBox, 0x10, 移动鼠标：方向参数错误调用, 方向指令无效，请输入小写字母的"up""down""left""right"
			return
	}
	;MsgBox,  X:%x_pos% Y:%y_pos%
	DllCall("SetCursorPos", "int", x_pos, "int", y_pos)	;移动鼠标指针到指定位置
	;MsgBox,  X:%x_pos% Y:%y_pos%
}


;* 发送鼠标滚动操作
WheelScroll(ByRef dir, steps:= 1, isBlockInput := 1)
{	
	If(isBlockInput == 1){ ;* 屏蔽外界输入
		BlockInput, On
	}

 	;* 直接发送鼠标横向滚动键
	Switch dir{
		case "Up", "up", "U", "u", "↑":
			Send, {WheelUp %steps%}
		case "Down", "down", "D", "d", "↓":
			Send, {WheelDown %steps%}		
		case "Left", "left", "L", "l", "←":
			Send, {WheelLeft %steps%}	
		case "Right", "right","R", "r", "→":
			Send, {WheelRight %steps%}	
		Default:
			MsgBox, 0x10, 滚动鼠标：方向指令无效, 方向指令无效，请输入小写字母的"up""down""left""right"
			;return
	}
	
	If(isBlockInput == 1){ ;* 恢复外界输入
		BlockInput, Off
	}
}

;* 发送方向键
SendDirectionKey(ByRef dir, steps:= 1, isBlockInput := 1)
{	
	If(isBlockInput == 1){ ;* 屏蔽外界输入
		BlockInput, On
	}
	
 	;* 直接发送鼠标横向滚动键
	Switch dir{
		case "Up", "up", "U", "u", "↑":
			Send, {Up %steps%}
		case "Down", "down", "D", "d", "↓":
			Send, {Down %steps%}		
		case "Left", "left", "L", "l", "←":
			Send, {Left %steps%}	
		case "Right", "right","R", "r", "→":
			Send, {Right %steps%}	
		Default:
			MsgBox, 0x10, 发送方向键：方向指令无效, 方向指令无效，请输入小写字母的"up""down""left""right"

	}
	
	If(isBlockInput == 1){ ;* 恢复外界输入
		BlockInput, Off
	}
}



;* 用浏览器打开网址, 要先确认打开的网址是合乎格式的
OpenUrlInBrowser(ByRef URL)
{
	run, %URL%
}

OpenUrlInFtp(ByRef URL)
{
	
}

OpenUrlInFile(ByRef URL)
{
	run, %URL%
}

OpenUrlInTorrent(ByRef URL)
{
	
}


;*上网搜索东西, text要trim就不要byref了
InternetSearch(text, ByRef searchEngine)
{

	
	text := Trim(text)	; 去除前后空格
	
	; 检测输入的是一个网址还是一个搜索关键词
	; http://www.baidu.com
	; shttp://www.baidu.com
	;  https://www.baidu.com ReGexMatch(text, "^(https|http):\/\/") != 0
	if(ReGexMatch(text, "^(https|http):\/\/") != 0){ ; 如果输入的是一个http/https网址
		OpenUrlInBrowser(text) ; 直接打开网址
	}else if(ReGexMatch(text, "^(ftp):\/\/") != 0){ ; ftp链接
		
	}else if(ReGexMatch(text, "^magnet:\?") != 0){  ; 磁力链接
		
	}else if(ReGexMatch(text, "^thunder:\/\/") != 0){	; 迅雷链接
	
	}else if(ReGexMatch(text, "^ed2k:\/\/") != 0){	; 电驴链接	
	
	}else if(ReGexMatch(text, "^[A-Za-z]:\\(.*)") != 0){	; 本地目录
		OpenUrlInFile(text)
	}else if(ReGexMatch(text, "^file:\/\/[A-Za-z]:\\(.*)") != 0){	; file://开头的本地目录
		text_len := StrLen(text)
		text := SubStr(text, 8, text_len)
		OpenUrlInFile(text)
		
	}else{ ;* 输入一个搜索词
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
		OpenUrlInBrowser(searchURL) ; 打开链接
	}
}

;* 复制文本并搜索, 如果选中的是网址则打开网址
CopyTextAndSearch(ByRef searchEngine)
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
	
	ReleaseShiftCtrlAltKeys()
	SetCapsLockState, 0		; 关闭大写锁定，防止抽风
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

ReleaseShiftCtrlAltKeys()
{
	Send, {Ctrl Up}{Alt Up}{Shift Up}
}

SwitchRemapMinusToUnderline()
{
	global flag_remapMinusToUnderline
	global rAltMode
	;MsgBox, %flag_remapMinusToUnderline%
	
	if(rAltMode == 1){
		if(flag_remapMinusToUnderline == 1){
			flag_remapMinusToUnderline := 0
			ShowToolTip("已关闭 减号_下划线交换功能！")
			;MsgBox, %flag_remapMinusToUnderline%
		}else{  ; flag_remapMinusToUnderline==0
			flag_remapMinusToUnderline := 1
			ShowToolTip("已开启 减号_下划线交换功能！")
			;MsgBox, %flag_remapMinusToUnderline%
			
		}		
	}else{
		flag_remapMinusToUnderline := 0
		ShowToolTip("非 Mode 1 模式下无法使用 减号_下划线交换功能！")
	}

}

;* 普通粘贴文本
;*=== 使用剪贴板强制输入指定长文本
SendByClipboard(ByRef str, sleepTime := 50)
{
	lastClip := Clipboard
	ClipBoard := ""
	;ClipWait, 1
	Clipboard := str
	ClipWait, 1
	
	Send ^v
	Sleep, %sleepTime%
	
	ReleaseShiftCtrlAltKeys()
		
	Clipboard := lastClip
	ClipWait, 1
}

PasteString(ByRef str, sleepTime := 50)
{
	Clipboard := str
	ClipWait, 1
	Send ^v
	Sleep, %sleepTime%
	ReleaseShiftCtrlAltKeys()
		
}

Paste()
{
	Send ^v
	Sleep, 50
	ReleaseShiftCtrlAltKeys()		
}

;* 无格式粘贴文本, 同时会清除复制内容的左右空格或制表符
PasteWithoutFormat()
{
	cb := Clipboard
	cb := Trim(cb)
	Clipboard := cb
	ClipWait, 1
	Paste()
}


;* 高级粘贴文本功能
AdvancedPaste()
{
	cb := Clipboard
	cb_original := cb
	
	;* 清除字符串左右两侧空白符
	cb := Trim(cb)
	
	

	
	;* 字符串没有换行的话
	if(InStr(cb, "`n") == 0 && InStr(cb, "`r") == 0){
	
		; 如果字符串被一对半角双引号或单引号引用, 则解引用
		; 注: AHK中, 字符串中的引号要打两次, 而不是通过通配符来实现
		; SubStr函数第二个参数为开始位置,
		;	1为第一个字符,0为最后一个字符,-1为倒数第二个字符, 
		;   第三个参数为字符长度
		;if((SubStr(cb, 1, 1) == """") && (SubStr(cb, 0, 1) == """")){
		if(ReGexMatch(cb, "^['""](.+)['""]$") != 0){
			cb_len := StrLen(cb)
			cb := SubStr(cb, 2, cb_len - 2)
			
		}	
		
		; 如果字符串是个 url, 则取其域名
		if((ReGexMatch(cb, "^(http|https|ftp):\/\/(.+)") != 0)){
			RegExMatch(cb, "\/\/([\w\.\d-]+)", cb_domain)
			cb_len := StrLen(cb_domain)
			cb := SubStr(cb_domain, 3, cb_len)
		}
		
		; 如果字符串是个 file://开头的 Windows 格式的文件路径, 则去除头部的 "File://" 字符
		if(RegExMatch(cb, "^file:\/\/[A-Za-z]:\\(.*)")){
			cb_len := StrLen(cb)
			cb := SubStr(cb, 8, cb_len)
			ReplaceSlashInPath(cb)
		}
		
		if(RegExMatch(cb, "[A-Za-z]:\\(.*)")){
			;MsgBox, 1 %cb%
			ReplaceSlashInPath(cb)
			;MsgBox, 2 %cb%
		}
		;MsgBox, 3 %cb%
	;* 字符串有换行则清除所有换行符
	}else{
		; 清除字符串的所有换行符
		cb := StrReplace(cb, "`n")
		cb := StrReplace(cb, "`r")		
	}

	
	PasteString(cb) ;粘贴文本
	
	;剪贴板恢复原状
	Clipboard := cb_original
	ReleaseShiftCtrlAltKeys()
}

;* 对于目录文本, 弹对话框让用户选择把所有反斜杠转换成 "\\(json)" 还是 "/(一些IDE中)"
ReplaceSlashInPath(ByRef str)
{
	replaceMode := "0"
	
InputToSelectSlashMode:
	InputBox, replaceMode, 高级粘贴功能: 反斜杠替换, 检测到您复制了一个 Windows 文件路径!`n    您要如何处理这个文件路径中的反斜杠 "`\" 符号`? `n`n  输入"0"或不输入:`t不替换`, 原样粘贴`n  输入"1" 或 输入"`/":`t将反斜杠"`\"替换为斜杠 "`/"`n  输入"2"或输入"`\":`t将反斜杠"`\"替换为双反斜杠"`\`\", , 450, 250
	
	replaceMode := trim(replaceMode)

	switch replaceMode{
		case "0", 0, "０", "":	;不改变
			
		case "1", 1, "１", "/":	;反斜杠转换成 "/"
			;MsgBox, %replaceMode%`n%str%
			str := StrReplace(str, "\", "/")
			;MsgBox, %replaceMode%`n%str%
		case "2", 2, "２", "\", "\\":	;反斜杠转换成 "\\"
			str := StrReplace(str, "\", "\\")
		Default:
			MsgBox, 0x10, 高级粘贴功能: 反斜杠替换, 无效的输入`, 请输入合法字符!
			goto InputToSelectSlashMode
		
	}
}





