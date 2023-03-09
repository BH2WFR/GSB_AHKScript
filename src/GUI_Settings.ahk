; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

#If GSB_IsInMainScript == 1

ShowSettingsGUI()
{
	global GSB_ScriptVersion
	global GSB_ScriptUpdateDate
	global GSB_CurrentSoftwareName
	
	
	guiTitle := "软件设置和关于页面：" . GSB_CurrentSoftwareName . " " . GSB_ScriptVersion
	
	Gui, GuiSettings:New, ,%guiTitle%
	Gui, GuiSettings:Font, s12, Segoe UI
	Gui, GuiSettings:-MaximizeBox -MinimizeBox +AlwaysOnTop
	
	;Gui, GuiSettings:Add, Text,, %guiTitle%
	
	Gui, GuiSettings:Font, s12, Segoe UI
	Gui, GuiSettings:Add, Button, gSettings_Button_OK x280 y376 w107 h31 +0x0000000, 确定(&O)
	Gui, GuiSettings:Add, Button, gSettings_Button_Cancel  x392 y376 w107 h31, 取消(&C)
	Gui, GuiSettings:Add, Button, gSettings_Button_Apply x504 y376 w107 h31 +0x0000000, 应用(&A)
	Gui, GuiSettings:Font
	
	Gui, GuiSettings:Font, s10, Segoe UI
	Gui, GuiSettings:Add, Tab3, x8 y24 w599 h343, 关于软件|功能设置|输入法设置|跑路功能设置
	Gui, GuiSettings:Font
	
	
	Gui, GuiSettings:Tab, 1
	
		Gui, GuiSettings:Add, Picture, x104 y64 w80 h80, .\res\icon.png
		Gui, GuiSettings:Font, s25 Bold Underline cBlack, Times New Roman
			Gui, GuiSettings:Add, Text, x216 y64 w302 h51 +0x200 +0x9 -0x9 +0x1 +0x1, GSB_AKHScript
		Gui, GuiSettings:Font
		Gui, GuiSettings:Font, s11 cMaroon, Segoe UI
			Gui, GuiSettings:Add, Text, x208 y112 w305 h28 +0x200 +0x1, 版本：%GSB_ScriptVersion%     更新日期：%GSB_ScriptUpdateDate%
		Gui, GuiSettings:Font
		Gui, GuiSettings:Font, s12 cBlack, Segoe UI
			Gui, GuiSettings:Add, Text, x72 y288 w120 h23 +0x200, 项目主页：
		Gui, GuiSettings:Font
		Gui, GuiSettings:Font, s13 cBlue, Segoe UI
			Gui, GuiSettings:Add, Text, x152 y256 w319 h26 +0x200 +0x1, 本脚本永久开源
		Gui, GuiSettings:Font
		Gui, GuiSettings:Font, s12, Segoe UI
			Gui, GuiSettings:Add, Link, x168 y288 w377 h24, <a href="https://github.com/BH2WFR/GSB_AHKScript">https://github.com/BH2WFR/GSB_AHKScript</a>
		Gui, GuiSettings:Font
		
		Gui, GuiSettings:Font, s12 cBlack, Segoe UI
			Gui, GuiSettings:Add, Text, x72 y320 w120 h23 +0x200, 更新发布：
		Gui, GuiSettings:Font
		
		Gui, GuiSettings:Font, s12, Segoe UI
			Gui, GuiSettings:Add, Link, x168 y320 w377 h24, <a href="https://github.com/BH2WFR/GSB_AHKScript/releases">https://github.com/BH2WFR/GSB_AHKScript/releases</a>
		Gui, GuiSettings:Font
		
		Gui, GuiSettings:Add, Text, x24 y253 w570 h2 +0x10
	
		Gui, GuiSettings:Font, s11 cPurple, Segoe UI
			Gui, GuiSettings:Add, Text, x152 y208 w161 h30 +0x200, 作者：BH2WFR
		Gui, GuiSettings:Font
		
		Gui GuiSettings:Font, s11 cRed, Consolas
			configPath := GetRegPath()
			Gui GuiSettings:Add, Text, x40 y144 w542 h45 +0x200, 配置文件(注册表)路径:  %configPath%\
		Gui GuiSettings:Font

	Gui, GuiSettings:Tab, 2
		
		
	Gui, GuiSettings:Tab, 3	
		
		
	Gui, GuiSettings:Tab, 4	
		
	Gui, GuiSettings:Tab
	

	LoadSettingsToGUI()	;* 加载设置
	
	Gui, Show, w618 h420	;* 弹出窗口
	
}


;* 按钮事件函数
Settings_Button_OK:
	SaveSettingsFronGUI()
	ShowToolTip("已保存当前更改设置, 并关闭窗口. ", 1000)
	Gui, GuiSettings:Destroy
	;MsgBox, test
return
	
Settings_Button_Cancel:
	ShowToolTip("您刚才关闭了设置窗口，但是未保存更改的设置. ", 1000)
	Gui, GuiSettings:Destroy
return	
	
Settings_Button_Apply:
	SaveSettingsFronGUI()
	ShowToolTip("已应用当前更改的设置. ", 1000)
	;MsgBox, test
return



;*  保存当前设置
SaveSettingsFronGUI()
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
	
	
	
	
	
		
	SaveSettings() ;再把全局变量保存到配置文件里面
}

;*加载全局变量到设置窗口里面
LoadSettingsToGUI()
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
	
	
	
		
}









#If ;GSB_IsInMainScript == 1

