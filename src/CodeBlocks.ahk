; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}



;^============================ 设计 输入文本的函数 =====================================

ExpandPairedSymbol(ByRef symble)
{
	switch symble{
		case "'":
			symble := "''"
		case """":
			symble := """"""
		case "(":
			symble := "()"
		case "[":
			symble := "[]"
		case "{":
			symble := "{}"
		case "<":
			symble := "<>"
		case "%":
			symble := "%%"
	}	
}

;*=== 输入对称的括号等符号(不使用byref)
SendPairedSymbles(quoteMarksPair){

	
	ExpandPairedSymbol(quoteMarksPair) ; 如果输入单个符号，则展开
		
	if (StrLen(quoteMarksPair) == 2){	;文本长度必须为 2
		Switch GetNotebookType(){
			case 1: ;支持输入单侧花括号后自动补全另一侧的 智能 IDE
				SendBypassIME(SubStr(quoteMarksPair, 1, 1))
				
			Default: ;不支持输入单侧花括号自动补全另一侧的 智障 IDE
				SendBypassIME(quoteMarksPair)
				Send, {Left}	
		}
	}else{
		Msgbox, 0x10, 输入对称的括号等符号, 函数 SendPairedSymbles 传参字符串格式错误
	}
}

SendPairedQuotes_detectShiftKey()
{
	if (GetKeyState("Shift")){
		SendPairedSymbles("""""")
	}else{
		SendPairedSymbles("''")
	}	
}

SendPairedBrackets_detectShiftKey()
{
	if (GetKeyState("Shift")){
		
	}else{
		SendPairedSymbles("()")
	}	
}

SendPairedBraces_detectShiftKey()
{
	if (GetKeyState("Shift")){
		SendPairedSymbles("{}")
	}else{
		SendPairedSymbles("[]")
	}	
}

SendIntendedBraces_detectShiftKey()
{
	if (GetKeyState("Shift")){
		SendCodeBlock("{}")
	}else{
		SendCodeBlock("[]")
	}	
}

SendTabs_detectShiftKey()
{
	if (GetKeyState("Shift")){		
		SendByClipboard("	")
	}else{
		Send, {Space 4}
	}	
}

SendRawTabs_detectShiftKey()
{
	if (GetKeyState("Shift")){		
		
	}else{
		IndentSelectedString()
	}	
}

;* 给选中的文本加对称符号（括号、引号、尖角等)
QuoteSelectedString(quoteMarksPair := """""")
{
	ExpandPairedSymbol(quoteMarksPair) ; 如果输入单个符号，则展开
	
	if (StrLen(quoteMarksPair) != 2){
		MsgBox, 0x10, 给选中的文本加对称符号, QuoteSelectedString 传参错误！
	}
	
	lastClip := Clipboard ; 备份剪贴板
	
	Send, ^x			; 复制文本
	Clipwait, 1
	str := Clipboard
	;MsgBox, %str%
	
	str := SubStr(quoteMarksPair, 1, 1) . str . SubStr(quoteMarksPair, 2, 1)
	
	
	Clipboard := str
	Clipwait, 1
	Send, ^v
	Sleep, 30
	ReleaseShiftCtrlAltKeys()
	Clipboard := lastClip		

	
}

;*== 给选中文本全部向右缩进
IndentSelectedString()
{
	lastClip := Clipboard ; 备份剪贴板
	
	Send, ^x			; 复制文本
	Clipwait, 1
	str := Clipboard
	MsgBox, %str%
	
	str := "    " . str
	s11 := InStr(str, "`n")
	MsgBox, %s11%
	
	;TODO: 此代码无效，尚未完成
	;StrReplace(str, "`r`n", "`r`n    ")
	;RegExReplace(str,"(.{50}\s)","$1`n     ")

	MsgBox, %str%
	
	Clipboard := str
	Clipwait, 1
	Send, ^v
	Sleep, 30
	ReleaseShiftCtrlAltKeys()
	Clipboard := lastClip	
}

;*=== 插入代码块并设置好缩进
SendCodeBlock(ByRef str){
	if (StrLen(str) == 2){	;文本长度必须为 2
		Switch GetNotebookType(){
			case 1: ;VS/VSCode/QtCreator
				SendBypassIME(SubStr(str, 1, 1))
				Send, {Enter}
			case 2: ; VC6.0/Keil
				SendPairedSymbles(str)
				Send, {Enter}
			Default:
				SendPairedSymbles(str)
				Send, {Enter 2}	{BackSpace}{Up} {Space 3}
		}
		
	}else{
		Msgbox, Length of String should to be 2 in function Calling "SendCodeBlock"
	}	
}


;*=== 绕过输入法直接输入字符（无法绕过 IDE 智能感知）
SendBypassIME(ByRef str){
	SendInput, {Text}%str%
}

;*=== 使用剪贴板强制输入指定长文本
SendByClipboard(ByRef str){
	lastClip := ClipBoard
	;Clipwait, 1
	;Sleep, 50
	ClipBoard := ""
	Clipboard := str
	Clipboard := str
	Clipboard := str
	Clipwait, 1
	Send, ^v
	Sleep, 50
	Clipboard := lastClip
	
	ReleaseShiftCtrlAltKeys()
}


;*=== 输入文本, 根据是否有 shift 按下
SendSymbolByCase(ByRef lower, ByRef upper:="")
{
	if (GetKeyState("Shift")){
		SendBypassIME(upper)
	}else{
		SendBypassIME(lower)
	}	
}



;^================================ 插入代码模板 ======================================

;*== 快捷输入 C++ 头文件
SendCppHeaderTemplate()
{
	headerName := ""
	
;InputHeaderName:
	InputBox, headerName, 代码块输入功能: C++ 头文件, 请输入头文件标识格式：`n    样例：MAIN_H__, , 450, 250
	
	headerName := Trim(headerName)
	
	if(headerName == ""){
		MsgBox, 0x10, 代码块输入功能: C++ 头文件, 无效的输入`, 不能为空!
		return
	}
	
	headerTemplate = 
(
#ifndef %headerName%
#define %headerName%

#ifdef __cplusplus
//==================== 公共头文件 =======================

//====================== 类定义 ========================


//================== 全局变量和函数声明 ==================


#endif //#ifdef __cplusplus

#endif //#ifndef %headerName%

)
	;MsgBox, %headerTemplate%
	
	SendByClipboard(headerTemplate)


}


;*== 快捷输入 C++ 源文件
SendCppSourceTemplate()
{
	headerName := ""
	
;InputHeaderName:
	InputBox, headerName, 代码块输入功能: C++ 源文件, 请输入头文件名：`n    样例：main.h, , 450, 250
	
	headerName := Trim(headerName)
	
	if(headerName == ""){
		MsgBox, 0x10, 代码块输入功能: C++ 源文件, 无效的输入`, 不能为空!
		return
	}
	
	sourceTemplate = 
(

//==================== 私有头文件 =======================
#include <%headerName%>


//====================== 全局变量 ========================


//====================内联和临时函数====================


//================== 类成员： ==================




)
	
	SendByClipboard(sourceTemplate)


}

SendCppSourceTemplate_detectShiftKey()
{
	if (GetKeyState("Shift")){
		SendCppSourceTemplate()
	}else{
		SendCppHeaderTemplate()
	}		
}





