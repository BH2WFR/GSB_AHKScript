; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

#If GSB_IsInMainScript == 1
;^ ============================== 运行前检查兼容性并获取管理员权限 ===============================

Progress, b fs20 zh0 W600 H70 C11, GSB_AKHScript  %GSB_ScriptVersion%  启动中..., , , Segoe UI



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

;*==================== 施放按键 关闭 CapsLock =====================

ReleaseShiftCtrlAltKeys(1)


;*=================== 弹出启动框 ==================







;^==================================  全局变量 ================================
;全局变量
; 注意： 使用时要在函数头部中声明一次这个变量, 否则无法使用, 格式: global isTestMode

isTestMode := 1		; 是否处于测试模式
rAltMode := 1		; 默认 RAlt 特殊模式，0 为关闭状态
rAltModeList := {0:"OFF", 1:"Programming Mode", 2:"Unified Latin Script", 3:"Art Script", 4:"Colemak Input"}

g_MouseQuickMoveUnitPixels := 30  ;F23+Shift+方向键 快速移动鼠标速度（每次移动的像素点个数) 
g_MouseQuickScrollUnit := 3		;caps+鼠标滚轮 快速滚动速度
g_MouseSuperScrollUnit := 6		;caps+鼠标滚轮 快速滚动速度
g_SendDirectionKeyQuickModeUnit := 5 ;caps+ijkl 发送方向键 shift按下时快速加倍幅度

flag_remapMinusToUnderline := 0 ; 仅在RAltMode==1时有效！ caps+下划线，开启/关闭 把 减号/下划线交换

;* 系统安装的输入法语言代码：
installedKeyboardLayout := {134481924:"Chinese,Simplicated", 68289554:"Korean", 67699721:"English,US,QWERTY", 68224017:"Japanese"}
;Layout_ChineseSimp_Code := 134481924
;Layout_Korean_Code := 68289554

;IMEmodeChangeKey := 1   ; ==0:Shift切换，1:F24(Caps)切换, 2:Ctrl+Space 切换 3: Ctrl切换

;'use_SemiColonAsRAlt := 0  ; 废弃使用 deprecated!

rime_KeymapChanged := 1	; 小狼毫 快捷键是否非默认状态
installed_Korean := 1
installed_English_US := 1
use_test_getIMEcode := 1 ; F16键弹出对话框显示当前输入法代号


;* 是否启用模块功能
use_RimeInput := 1
use_Anki := 1
use_AutoCAD := 1
use_Explorer_CopyFullPath := 1 

;* 跑路功能增强
g_PrivacyEraserPath := """D:\Portable_Programs\Privacy_Eraser\PrivacyEraser.exe"""
g_USBOblivionPath := """D:\Portable_Programs\USBOblivion\USBOblivion32.exe"""
g_ADBPath := "adb"

g_isKeepSilentWhileCleaning := 1
g_isRestartExplorerWhileCleaning := 0
g_isShutDownAfterCleaning := 0


;*从配置文件加载设置到全局变量里面
LoadSettingsToGlobalVariable()



; ;* 新版使用类包装所有全局变量定义
; Class GSB_Configure_Typedef{
; 	isInTestMode := 1
; 	defaultRAltMode := 1
	
; 	QuickMousemoveStep := 30
	
; 	Class IME{
		
; 	}
; }
; g_Config = New GSB_Configure_Typedef

Sleep, 200
Progress, Off


#If ;GSB_IsInMainScript == 1
