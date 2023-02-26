﻿; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

;^ ============================== 运行前检查兼容性并获取管理员权限 ===============================
;*=================== 检查系统版本 ===============
If(A_OSVersion == "WIN_2000" || A_OSVersion == "WIN_XP" || A_OSVersion == "WIN_2003" || A_OSType == "WIN32_WINDOWS"){
	Msgbox, 0x10, 不支持的操作系统, 你的 Windows 操作系统版本 %A_OSType% %A_OSVersion% 不支持此脚本的一些功能！`n  请使用至少 Windows Vista (NT 6.0) 以上的系统！
	ExitApp
}

;*================== 检查 AutoHotkey 版本============
If (VerCompare(A_AhkVersion, "<= 1.1")){
	Msgbox, 0x10, 不支持的 AutoHotkey 解释器版本, 您的 AutoHotkey 解释器版本 v%A_AhkVersion% 太低 `n  请使用 AutoHotkey v1.1.x 的版本（也不支持使用 v2 及以上版本）运行！
	ExitApp
}else if (VerCompare(A_AhkVersion, ">= 2")){
	Msgbox, 0x10, 不支持的 AutoHotkey 解释器版本, 这是一个基于 AutoHotkey v1.1.x 的脚本，`n  不可以使用 v2 及以上版本运行，因为 AutoHotkey v1 和 v2 互不兼容！
	ExitApp
}else{
	
}


;*==================  申请管理员权限 ==================
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

	
;^==================================  全局变量 ================================
;全局变量
; 注意： 使用时要在函数头部中声明一次这个变量, 否则无法使用, 格式: global isTestMode

isTestMode := 1		; 是否处于测试模式
rAltMode := 1		; 默认 RAlt 特殊模式，0 为关闭状态
rAltModeList := {0:"OFF", 1:"Programming Mode", 2:"Galian Script", 3:"Esp Script", 4:"Colemak Input"}
MouseQuickMoveUnitPixels := 30  ;F23+Shift+方向键 快速移动鼠标速度（每次移动的像素点个数) 

flag_remapMinusToUnderline := 0 ; caps+下划线，开启/关闭 把 减号/下划线交换

;* 系统安装的输入法语言代码：
installedKeyboardLayout := {134481924:"Chinese,Simplicated", 68289554:"Korean", 67699721:"English,US,QWERTY"}
;Layout_ChineseSimp_Code := 134481924
;Layout_Korean_Code := 68289554

;IMEmodeChangeKey := 1   ; ==0:Shift切换，1:F24(Caps)切换, 2:Ctrl+Space 切换 3: Ctrl切换

use_SemiColonAsRAlt := 0  ; 使用分号代替RAlt,（适用于一些 RAlt 不方便按到的键盘, 要提前映射到 F23）

rime_KeymapChanged := 1	; 小狼毫 快捷键是否非默认状态
installed_Korean := 1
installed_English_US := 1
use_test_getIMEcode := 0 ; F16键弹出对话框显示当前输入法代号


;* 是否启用模块功能
use_RimeInput := 1
use_Anki := 1
use_AutoCAD := 1
use_Explorer_CopyFullPath := 1 



; ;* 新版使用类包装所有全局变量定义
; Class GSB_Configure_Typedef{
; 	isInTestMode := 1
; 	defaultRAltMode := 1
	
; 	QuickMousemoveStep := 30
	
; 	Class IME{
		
; 	}
; }
; g_Config = New GSB_Configure_Typedef

