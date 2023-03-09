; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}


#If GSB_IsInMainScript == 1


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
#If WinActive("ahk_exe anki.exe") && (WinActive("Add") || WinActive("Edit Current") || WinActive("Browse")) ;* 编辑/添加/浏览 窗口中
	XButton1::	;鼠标 后退键 触发 文本加粗
		Send, ^b
	return
	
	XButton2::	;鼠标 前进键 触发 文本标红
		Send, {F7}
	return
	
	WheelLeft::	; 鼠标 向左滚动 触发 
		
	return
	
	WheelRight:: ; 鼠标 向右滚动 触发
		Send, ^r
	return
#If  ;WinActive

#If WinActive("ahk_exe anki.exe") && !(WinActive("Add") || WinActive("Edit Current") || WinActive("Browse")) ;* 背诵窗口中
	;TODO 功能预留
	
#If  ;WinActive

;*============== AutoCAD  鼠标特殊按键映射到快捷键
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


;*============== Onenote F20触发鼠标位置显示
#IfWinActive ahk_exe ONENOTE.EXE
	
	
#IfWinActive

;*================ MDK 中：
#IfWinActive ahk_exe UV4.exe
	;快捷输入主函数


#IfWinActive



#If ;GSB_IsInMainScript == 1
