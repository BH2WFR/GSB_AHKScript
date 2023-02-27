; encoding: UTF-8 with BOM
;#SingleInstance, Force
;SendMode Input
;SetWorkingDir, %A_ScriptDir%
/*
^ ====================================== GSB_AKHScript ==================================
^ |   	版本：v0.2.7      作者：BH2WFR, GSB Electronic   	更新时间：27 Feb 2023 	 |
------------------------------------------------------------------------------------
*     				 AHK 版本： v1.1.x, 		操作系统支持版本 >= Vista(NT6.0)                     
	----------------------------------------------------------------	
*  			代码仓库 git 地址：	 https://github.com/BH2WFR/GSB_AHKScript.git
*			网页：				https://github.com/BH2WFR/GSB_AHKScript
* 			开源协议：  
*
*-----------------------------------------------------------------------------------
*/

; 重要全局变量, include脚本通过这个变量来判断自己是否为main脚本调用, 而不是单独运行
GSB_IsInMainScript := 1	

; 当前版本
GSB_ScriptVersion := "v0.2.7"
GSB_ScriptUpdateDate := "27 Feb, 2023"


;* 启动时检查环境版本 + 定义全局变量
#include .\src\Configures.ahk

;* 脚本中用到的函数列表
#include .\src\Functions.ahk

;* 系统级热键和特定应用程序热键
#include .\src\System_HotkeysAndFunctions.ahk
#include .\src\Program_Hotkeys.ahk

;* 加载代码片段
#include .\src\CodeBlocks.ahk


;* Caps 和 RAlt 特殊热键
#include .\src\Caps_Hotkeys.ahk

#include .\src\RAlt_Global_Hotkeys.ahk
#include .\src\RAlt_Mode1_Hotkeys.ahk
#include .\src\RAlt_Mode2_Hotkeys.ahk

;* GUI界面
#include .\src\GUI_Settings.ahk
