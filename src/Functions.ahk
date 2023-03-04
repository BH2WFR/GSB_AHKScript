; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}
; 函数

;* RAltMode 工具提示，加入对具体模式专用功能开关状态的提示
SetRAltMode_AttachRAltModeTooltipString(mode, ByRef str, isSetRAltMode := 0)
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
		case 3:
			str := str . "尚未开发完，敬请等待..."
		Default:
			ShowMsgBoxParameterError("切换 RAlt 模式：不支持的值", A_ThisFunc, "无效的 RAlt 值")
			return
	}	
	
	if(isSetRAltMode == 1){
		rAltMode := mode
	}
	
}

;* ===设置 RAlt 模式并弹出工具条提示
SetRAltMode(mode)
{
	global rAltMode
	global rAltModeList
	global flag_remapMinusToUnderline
	
	
	str := "已切换到 RAlt 模式  " mode "`t " rAltModeList[mode]
	
	; if(mode != 1){
	; 	lag_remapMinusToUnderline == 0
	; }
	
	SetRAltMode_AttachRAltModeTooltipString(mode, str, 1)
	
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
	
	SetRAltMode_AttachRAltModeTooltipString(rAltMode, str)
	
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


;*========== 函数参数错误提示，调用方式：ShowMsgBoxParameterError("代码块输入功能: C++ 头文件", A_ThisFunc, "无效的输入, 不能为空!")
ShowMsgBoxParameterError(ByRef title, ByRef functionName, ByRef description := "")
{
	MsgBox, 0x1010, %title%：错误, 错误：函数 %functionName%(#)`n`t输入了一个不支持的参数！`n`n 说明：%description%
}


ShowMsgBoxError(ByRef title, ByRef description, ByRef functionName:="")
{
	if(functionName == ""){
		; 使用 0x40010 省略任务栏图标窗口置顶
		MsgBox, 0x1010, %title%, %description%
	}else{
		MsgBox, 0x1010, %title%, 函数 %functionName%`n`t 中发生一个错误：`n`n 说明: %description%
	}
}



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
			ShowMsgBoxParameterError("搜索或打开选中文本或链接功能", A_ThisFunc, "不知道这是个什么搜索引擎或超链接？")
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


SwitchRemapMinusToUnderline()
{
	global flag_remapMinusToUnderline
	global rAltMode
	;MsgBox, %flag_remapMinusToUnderline%
	
	if(rAltMode == 1){
		if(flag_remapMinusToUnderline == 1){
			flag_remapMinusToUnderline := 0
			ShowToolTip("已关闭 减号_下划线交换功能！", 800)
			;MsgBox, %flag_remapMinusToUnderline%
		}else{  ; flag_remapMinusToUnderline==0
			flag_remapMinusToUnderline := 1
			ShowToolTip("已开启 减号_下划线交换功能！", 800)
			;MsgBox, %flag_remapMinusToUnderline%
			
		}		
	}else{
		flag_remapMinusToUnderline := 0
		ShowToolTip("非 Mode 1 模式下无法使用 减号_下划线交换功能！", 800)
	}

}

;* 普通粘贴文本
;*=== 使用剪贴板强制输入指定长文本
SendByClipboard(ByRef str, sleepTime := 500)
{
	
	lastClip := Clipboard
	ClipBoard := ""
	;ClipWait, 1
	
	BlockInput, On	;阻塞用户输入增强稳定性
	
	Clipboard := str
	ClipWait, 1
	
	Send ^v
	
	Sleep, %sleepTime%
	
	Clipboard := lastClip
	ClipWait, 1
	
	BlockInput, Off
	ReleaseShiftCtrlAltKeys()
}

PasteString(ByRef str, sleepTime := 50)
{
	Clipboard := str
	BlockInput, On	;阻塞用户输入增强稳定性
	
	ClipWait, 1
	Send ^v
	
	Sleep, %sleepTime%
	
	BlockInput, Off
	ReleaseShiftCtrlAltKeys()
	
		
}

Paste(ifReleaseShiftCtrlAltKeys := 1, isTurnOffCaps := 0)
{
	BlockInput, On	;阻塞用户输入增强稳定性
	Send ^v
	Sleep, 50
	BlockInput, Off
	
	if(ifReleaseShiftCtrlAltKeys){
		ReleaseShiftCtrlAltKeys(isTurnOffCaps)		
	}
}

;* 无格式粘贴文本, 同时会清除复制内容的左右空格或制表符
PasteWithoutFormat()
{
	cb := Clipboard
	cb := Trim(cb)
	Clipboard := cb
	ClipWait, 1
	Paste(0, 1)
	
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

	
	PasteString(cb) ;粘贴文本内含输入阻塞
	
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
			ShowMsgBoxError("高级粘贴功能: 反斜杠替换", "无效的输入, 请输入合法字符!", A_ThisFunc)
			goto InputToSelectSlashMode
		
	}
}





