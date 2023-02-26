; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}



