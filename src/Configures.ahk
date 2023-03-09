; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

#If GSB_IsInMainScript == 1

;*=================== 弹出启动框 ==================
Progress, b fs20 zh0 W600 H70 C11, GSB_AKHScript  %GSB_ScriptVersion%  启动中..., , , Segoe UI



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



g_chineseInputMode := 2 ;* 中文输入法模式, 见上面多行注释说明
/*  0:未定义	
	1:小狼毫输入法默认模式
*	2:小狼毫输入法魔改模式
	
	10:微软拼音, Shift切换中英文
	11:微软拼音, Ctrl切换中英文
	12:微软拼音, Ctrl+Space 切换中英文	
	
	20: 搜狗拼音, Shift切换中英文	
*/


use_test_getIMEcode := 1 ; F16键弹出对话框显示当前输入法代号



;* 跑路功能增强 目录中有空格就两侧加双引号
g_PrivacyEraserPath := """D:\Portable_Programs\Privacy_Eraser\PrivacyEraser.exe"""
g_USBOblivionPath := """D:\Portable_Programs\USBOblivion\USBOblivion32.exe"""
g_ADBPath := "adb"

g_isKeepSilentWhileCleaning := 1
g_isRestartExplorerWhileCleaning := 0
g_isShutDownAfterCleaning := 0

g_personalFilePath = 
(
	D:\Data\personalFileTest
	D:\Data\personalFileTest2
)




;^==========================  检查环境/申请管理员权限/加载设置 ========================

;*检查 AHK 和系统版本, 不符合就退出程序
CheckSystemVersion()
CheckAHKVersion()

;*申请管理员权限
RunThisScriptAsAdmin()

;*从配置文件加载设置到全局变量里面
LoadSettings()

;*检查版本并向配置文件写入运行时间
CheckScriptVersionAndWrite()

;*施放按键
ReleaseShiftCtrlAltKeys(1) 


Sleep, 100
Progress, Off ;关闭启动条


#If ;GSB_IsInMainScript == 1




; ;* 新版使用类包装所有全局变量定义
; Class GSB_Configure_Typedef{
; 	isInTestMode := 1
; 	defaultRAltMode := 1
	
; 	QuickMousemoveStep := 30
	
; 	Class IME{
		
; 	}
; }
; g_Config = New GSB_Configure_Typedef