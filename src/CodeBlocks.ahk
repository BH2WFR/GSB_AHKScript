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
		case "_":
			symble := "__"
		case "<<":
			symble := "<<>>"
		case "[[":
			symble := "[[]]"
		case "'''":
			symble := "''''''"
		case "":
			ShowToolTip("输入对称引号：功能未适配", 500)
	}	
}

;*=== 输入对称的括号等符号(不使用byref)
SendPairedSymbles(quoteMarksPair:=""){

	
	ExpandPairedSymbol(quoteMarksPair) ; 如果输入单个符号，则展开
	
		
	
	slen := StrLen(quoteMarksPair)
	
	Switch slen {
		case 2:  ;""
			SendByClipboard(quoteMarksPair, 20)
			Send, {Left}
				
		case 4:
			SendByClipboard(quoteMarksPair, 20)
			Send, {Left 2}	
			
		case 6:
		
			SendByClipboard(quoteMarksPair, 20)
			Send, {Left 3}	
			
		case 0:
			ShowToolTip("输入对称引号：功能未适配", 500)		
				
		Default:
			ShowMsgBoxParameterError("输入对称的括号等符号", A_ThisFunc, "传参字符串格式错误, 请输入字符串长度为 2、4、6 的对称字符！")
	}
	
}

SendPairedSymbles_detectShiftKeys(ByRef lower:="", ByRef upper:="")
{
	if (GetKeyState("Shift")){
		SendPairedSymbles(upper)
	}else{
		SendPairedSymbles(lower)
	}		
}

;* 注释当前行代码
CommentSingleLine(commentMark := "//")
{
	Send, {Home}
	SendBypassIME(commentMark)
	
}

;* 给选中的文本加对称符号（括号、引号、尖角等)
QuoteSelectedString(quoteMarksPair := """""")
{
	ExpandPairedSymbol(quoteMarksPair) ; 如果输入单个符号，则展开
	
	
	slen := StrLen(quoteMarksPair)
	
	
	if((slen == 2) || (slen == 4) || (slen == 6)){
		
		Send, ^x			; 复制文本
		Sleep, 20
		str := Clipboard
		
		halfslen := slen / 2
		
		str := SubStr(quoteMarksPair, 1, halfslen) . str . SubStr(quoteMarksPair, halfslen+1, halfslen)	
		
		SendByClipboard(str, 20) ; 粘贴文本并还原剪贴板
	
		
	}else{
		Msgbox, 0x10, 输入对称的括号等符号, 函数 SendPairedSymbles 传参字符串格式错误
		return
		
	}
	
}

;*== 给选中文本全部向右缩进
IndentSelectedString()
{
	lastClip := Clipboard ; 备份剪贴板
	
	Send, ^x			; 复制文本
	Clipwait, 1
	str := Clipboard
	
	If(StrLen(str) == 0){
		SendByClipboard("	")
		
	}else{
		str := "    " . str
		str := StrReplace(str, "`n", "`n    ")
		
		PasteString(str)
		
		Clipboard := lastClip			
	}
	

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



;*=== 输入文本, 根据是否有 shift 按下
SendSymbolByCase(ByRef lower, ByRef upper:="")
{
	if (GetKeyState("Shift")){
		SendBypassIME(upper)
	}else{
		SendBypassIME(lower)
	}	
}

SendSymbolByCaseAndCaps(ByRef lower, ByRef upper:="")
{
	global rAltMode
	
	if(lower == ""){
		if(upper != ""){	; 如果大写的没传入，则不管按没按shift一律输出小写的
			SendBypassIME(upper) ;lower空，upper有
			
		}else{ ;lower空，upper空
			ShowToolTip("RAlt mode " . rAltMode . ": 未适配当前组合键", 350)
			return
		}
		
		
	}else{ ;lower != ""
		if(upper == ""){
			SendBypassIME(lower) ;lower有，upper空
			
			
		}else{
			if(GetKeyState("CapsLock", "T") == 0){ ;caps关闭
				if (GetKeyState("Shift")){
					SendBypassIME(upper)
				}else{
					SendBypassIME(lower)
				}	
					
			}else{		;caps打开
				if (GetKeyState("Shift")){
					SendBypassIME(lower)
				}else{
					SendBypassIME(upper)
				}		
			}				
		}
	
	}

}


;*==== 字符串大小写转换
StringCaseShift(ByRef str, mode)
{
	switch mode{
		case 0:
		; 转换为小写
			StringLower, str, str
			
		case 1:
		; 转换为大写
			StringUpper, str, str
			
		case 2:
		; 转换为首字母大写
			StringUpper, str, str, T
			;TODO 对虚词仍然保持小写
			;StringCaseFirstLetterUpper(str)  ;* 未完成
			
		case -1:
		; 智能转换
			;TODO 识别文本字符串是一个什么样的大小写状态
			
		Default:
			ShowMsgBoxError("字符串大小写转换", A_ThisFunc, "mode 参数错误！")
			return
	}
}

StringCaseFirstLetterUpper(ByRef str) ;* 智能首字母大写功能
{
	StringCaseShift(str, 0) ; 先全部变成小写
	; TODO: 功能展示：
/*	TODO:
	1. 寻找所有 空格后面 和 下划线后面 或 连字符后面的词，
	2. 寻找所有被空格或下划线包围的虚词，不大写
	3. 寻找 McCathy 之类的这种反常大写词汇，对其进行特殊转换
	尽可能利用正则表达式
*/
	
}


ShiftCaseForSelectedText(mode)
{
	lastClip := Clipboard ; 备份剪贴板
	
	Send, ^x			; 复制文本
	Clipwait, 1
	str := Clipboard
	
	StringCaseShift(str, mode)
		
	PasteString(str)
	
	Clipboard := lastClip	
}

; ;TODO 函数预留未使用
; SendSymbolByCaseAndCapsWithRAlt(ByRef lower, ByRef upper:="", ByRef RAlt_lower:="", ByRef RAlt_Upper:="")
; {
; 	if((lower == "") && (upper == "") && (RAlt_lower == "") && (RAlt_upper == "")){
; 		ShowToolTip("该键未适配输入字符", 500)
; 		return
; 	}else{
		
; 		if(GetKeyState("CapsLock", "T") == 0){ ;caps关闭
; 			if (GetKeyState("F23")){
; 				if (GetKeyState("Shift")){
; 					SendBypassIME(upper)
; 				}else{
; 					SendBypassIME(lower)
; 				}	
; 			}else{ ;没挂 RAlt
; 				if (GetKeyState("Shift")){
; 					SendBypassIME(RAlt_upper)
; 				}else{
; 					SendBypassIME(RAlt_lower)
; 				}				
; 			}
			
; 		}else{		;caps打开
; 			if (GetKeyState("Alt")){
; 				if (GetKeyState("Shift")){
; 					SendBypassIME(lower)
; 				}else{
; 					SendBypassIME(upper)
; 				}		
; 			}else{ ;没挂 RAlt
; 				if (GetKeyState("Shift")){
; 					SendBypassIME(RAlt_upper)
; 				}else{
; 					SendBypassIME(RAlt_lower)
; 				}				
; 			}	
; 		}		
; 	}

; }
;^================================ 插入代码模板 ======================================

;*== 快捷输入 C++ 头文件
SendCppHeaderTemplate()
{
	headerName := ""
	
;InputHeaderName:
	InputBox, headerName, 代码块输入功能: C++ 头文件, 请输入头文件标识格式：`n    样例：MAIN_H__, , 450, 250
	
	headerName := Trim(headerName)
	
	if(headerName == ""){
		ShowMsgBoxError("代码块输入功能: C++ 头文件", " 无效的头文件防重复包含宏定义名输入, 不能为空!"， A_ThisFunc)
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
		ShowMsgBoxError("代码块输入功能:C++ 源文件", " 无效的头文件名引用输入, 不能为空!"， A_ThisFunc)
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







