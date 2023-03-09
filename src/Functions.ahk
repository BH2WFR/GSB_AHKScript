; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}
; 函数

#If GSB_IsInMainScript == 1

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
	
	SaveSettings(0) ;* 保存设置到配置文件里面
	
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
			
		}else{  ; flag_remapMinusToUnderline==0
			flag_remapMinusToUnderline := 1
			ShowToolTip("已开启 减号_下划线交换功能！", 800)
			
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
	InputBox, replaceMode, 高级粘贴功能: 反斜杠替换, 检测到您复制了一个 Windows 下的文件路径!`n    您要如何处理这个文件路径中的反斜杠 "`\" 符号`? `n`n  输入"0"或不输入:`t不替换`, 去除引号后原样粘贴`n  输入"1" 或 输入"`/":`t将反斜杠"`\"替换为斜杠 "`/"`n  输入"2"或输入"`\":`t将反斜杠"`\"替换为双反斜杠"`\`\"`n  输入"3"或输入 ' " ': `t路径两侧加入双引号引用, , 450, 250
	
	replaceMode := trim(replaceMode)

	switch replaceMode{
		case "0", 0, "０", "":	;不改变
			
		case "1", 1, "１", "/":	;反斜杠转换成 "/"
			;MsgBox, %replaceMode%`n%str%
			str := StrReplace(str, "\", "/")
			;MsgBox, %replaceMode%`n%str%
		case "2", 2, "２", "\", "\\":	;反斜杠转换成 "\\"
			str := StrReplace(str, "\", "\\")
		case "3", 3, "３", """", """""":  ;不改变,但加入两侧双引号
			str_len := StrLen(str)
			if(SubStr(str, 1, 1) == """" && SubStr(str, StrLen, 1) == """"){
				
			}else{
				str := """" . str . """"
			}
		Default:
			ShowMsgBoxError("高级粘贴功能: 反斜杠替换", "无效的输入, 请输入合法字符!", A_ThisFunc)
			goto InputToSelectSlashMode
		
	}
}



;*^============================= 注册表和配置相关函数 ============================
;*   默认注册表目录:   HKEY_CURRENT_USER\Software\GSB_AHKScript
;	WriteRegKey("test1", "shabi22", "REG_SZ", "TEST") ;\TEST子目录, 
;						即放到HKEY_CURRENT_USER\Software\GSB_AHKScript\TEST 下
;	WriteRegKey("test1", "shabi22", "REG_SZ", "")     ;软件配置根目录
;	testvar := GetRegKey("test1", "TEST")  		;\TEST子目录
;	testvar := GetRegKey("test1", "")				;软件配置根目录
;   ReadRegKey("rAltMode", rAltMode, "")

;* 写入注册表键值, subPath格式: 保持空值 或 输入如 "IME" 或 "IME\Path", 左右两侧没有斜杠
WriteRegKey(ByRef name, ByRef value, ByRef type := "REG_SZ", ByRef subPath := "")
{
	regPath := GetRegPath(subPath)
	
	StringUpper, type, type
	
	name := Trim(name)
	value := Trim(value)
	
	switch type{
		case "REG_SZ", "SZ", "S":
			RegWrite, REG_SZ, %regPath%, %name%, %value%
			
		case "REG_EXPAND_SZ", "EXPAND_SZ", "EXPAND", "E":
			RegWrite, REG_EXPAND_SZ, %regPath%, %name%, %value%
			
		case "REG_MULTI_SZ", "MULTI_SZ", "MULTI", "M":
			RegWrite, REG_MULTI_SZ, %regPath%, %name%, %value%
			
		case "REG_DWORD", "DWORD", "D":
			RegWrite, REG_DWORD, %regPath%, %name%, %value%
			
		case "REG_BINARY", "BINARY", "B":
			RegWrite, REG_BINARY, %regPath%, %name%, %value%
			
		default:
			;MsgBox, %type%
			ShowMsgBoxParameterError("注册表写入设置项功能", A_ThisFunc, "参数错误！请输入 REG_SZ, REG_EXPAND_SZ, REG_MULTI_SZ, REG_DWORD, 或 REG_BINARY")
	}
}


GetRegKey(ByRef name, ByRef subPath := "")
{
	regPath := GetRegPath(subPath)
	name := Trim(name)
	
	RegRead, output, %regPath%, %name% ; OutputVar是一个临时变量
	
	output := Trim(output)
	return output
	
}


ReadRegKey(ByRef name, ByRef var, ByRef subPath := "")
{
	getvar := GetRegKey(name, subPath)
	
	getVar := Trim(getvar)
	
	if(getVar != ""){ ;* 确保注册表有这个项, 没有的话就不动
		var := getVar
		
	}else{
		;* 注册表没有这个项，则保持全局变量中的默认设定
		;MsgBox, 0x1000, , %name% 不存在
	}
}

GetRegPath(ByRef subPath := "")
{
	global GSB_CurrentSoftwareName
	
	subPath := trim(subPath)
	
	if(subPath == ""){
		regPath := "HKEY_CURRENT_USER\SOFTWARE\" . GSB_CurrentSoftwareName
	}else{
		regPath := "HKEY_CURRENT_USER\SOFTWARE\" . GSB_CurrentSoftwareName . "\" . subPath
	}
	
	return regPath	
}


;*  保存当前全局变量到设置文件里面
SaveSettings(operateCleanerSettings := 1)
{
	_OperateSettingsAndGlobalVariable(0, operateCleanerSettings)
}

;* 加载配置文件到全局变量
LoadSettings()
{
	_OperateSettingsAndGlobalVariable(1)
}


_OperateSettingsAndGlobalVariable(isRead, operateCleanerSettings := 1) ;* 1读 2写
{
	;软件相关
	global GSB_ScriptVersion
	
	;基本设置
	global rAltMode
	;global flag_remapMinusToUnderline
	
	;输入法相关
	global g_chineseInputMode
	
	;跑路功能
	global g_PrivacyEraserPath
	global g_USBOblivionPath
	global g_ADBPath
	global g_personalFilePath
	
	global g_isKeepSilentWhileCleaning
	global g_isRestartExplorerWhileCleaning
	global g_isShutDownAfterCleaning
	
	if(isRead == 1){ ;* 读
		ReadRegKey("rAltMode", rAltMode, "Basic")
		
		ReadRegKey("chineseInputMode", g_chineseInputMode, "IME")
		
		if(operateCleanerSettings == 1){
			ReadRegKey("PrivacyEraserPath", g_PrivacyEraserPath, "Cleaner")
			ReadRegKey("USBOblivionPath",   g_USBOblivionPath,   "Cleaner")
			ReadRegKey("ADBPath",           g_ADBPath,           "Cleaner")
			ReadRegKey("personalFilePath",  g_personalFilePath,  "Cleaner")
			
			ReadRegKey("isKeepSilentWhileCleaning", g_isKeepSilentWhileCleaning, "Cleaner")
			ReadRegKey("isRestartExplorerWhileCleaning", g_isRestartExplorerWhileCleaning, "Cleaner")
			ReadRegKey("isShutDownAfterCleaning", g_isShutDownAfterCleaning, "Cleaner")			
		}				
		
	}else{ ;* 写
		
		
		WriteRegKey("rAltMode", rAltMode, "REG_DWORD", "Basic")
		
		WriteRegKey("chineseInputMode", g_chineseInputMode, "REG_DWORD", "IME")
		
		if(operateCleanerSettings == 1){
			WriteRegKey("PrivacyEraserPath", g_PrivacyEraserPath, "REG_SZ", "Cleaner")
			WriteRegKey("USBOblivionPath",   g_USBOblivionPath,   "REG_SZ", "Cleaner")
			WriteRegKey("ADBPath",           g_ADBPath,           "REG_SZ", "Cleaner")
			WriteRegKey("personalFilePath",  g_personalFilePath,  "REG_SZ", "Cleaner")
			
			WriteRegKey("isKeepSilentWhileCleaning", g_isKeepSilentWhileCleaning, "REG_DWORD", "Cleaner")
			WriteRegKey("isRestartExplorerWhileCleaning", g_isRestartExplorerWhileCleaning, "REG_DWORD", "Cleaner")
			WriteRegKey("isShutDownAfterCleaning", g_isShutDownAfterCleaning, "REG_DWORD", "Cleaner")			
		}	
		
		
	}
}

;* 软件启动时检查安装版本
CheckScriptVersionAndWrite()
{
	global GSB_ScriptVersion
	
	ReadRegKey("installedVersion", lastVersion, "")
	
	if(lastVersion == ""){ ;* 第一次运行
		MsgBox, 0x1040, 欢迎使用, 检测到您第一次运行这个脚本, `n请查看使用说明和更新日志!`n`n 当前版本号: %GSB_ScriptVersion%
	}else{
		If (VerCompare(GSB_ScriptVersion, lastVersion) < 0){ ;*降级运行
			MsgBox, 0x1040, 降级运行脚本, 检测到您正在降级运行脚本`, 可能会导致不可预料的错误`n`n 原版本号: %lastVersion%`, 当前版本号: %GSB_ScriptVersion%
			;ExitApp
			
		}else if (VerCompare(GSB_ScriptVersion, lastVersion) > 0){ ;*升级运行
			MsgBox, 0x1040, 脚本已升级, 脚本已升级`, 请查看更新日志!`n`n 原版本号: %lastVersion%`, 当前版本号: %GSB_ScriptVersion%
		}		
	}
	

	;* 获取当前时间
	currentTime :=  A_YYYY . "-" . A_MM . "-" . A_DD . ", " . A_Hour . ":" .  A_Min . ":" . A_Sec
	
	;* 写入版本和时间
	WriteRegKey("installedVersion", GSB_ScriptVersion, "REG_SZ", "")
	WriteRegKey("lastExecuteTime", currentTime, "REG_SZ", "")
	WriteRegKey("OSType", A_OSType, "REG_SZ", "")
	WriteRegKey("OSVersion", A_OSVersion, "REG_SZ", "")
}

;*=================== 检查系统版本 ===============
CheckSystemVersion()
{
	If(A_OSVersion == "WIN_2000" || A_OSVersion == "WIN_XP" || A_OSVersion == "WIN_2003" || A_OSType == "WIN32_WINDOWS"){
		Msgbox, 0x10, 不支持的操作系统, 你的 Windows 操作系统版本 %A_OSType% %A_OSVersion% 不支持此脚本的一些功能！`n  请使用至少 Windows Vista (NT 6.0) 以上的系统！
		ExitApp
	}	
}

;*================== 检查 AutoHotkey 版本============
CheckAHKVersion()
{
	If (VerCompare(A_AhkVersion, "<= 1.1")){
		Msgbox, 0x10, 不支持的 AutoHotkey 解释器版本, 您的 AutoHotkey 解释器版本 v%A_AhkVersion% 太低 `n  请使用 AutoHotkey v1.1.x 的版本（也不支持使用 v2 及以上版本）运行！
		ExitApp
	}else if (VerCompare(A_AhkVersion, ">= 2")){
		Msgbox, 0x10, 不支持的 AutoHotkey 解释器版本, 这是一个基于 AutoHotkey v1.1.x 的脚本，`n  不可以使用 v2 及以上版本运行，因为 AutoHotkey v1 和 v2 互不兼容！
		ExitApp
	}else{
		
	}	
}

;*==================  申请管理员权限 ==================
RunThisScriptAsAdmin()
{
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
}

#If ;GSB_IsInMainScript == 1

