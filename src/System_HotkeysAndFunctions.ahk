; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

;*=============== 任务栏上：任务栏上滚动鼠标滚轮以调节音量（更新：副屏的任务栏也可以了）
#if MouseIsOver("ahk_class Shell_TrayWnd") || MouseIsOver("ahk_class Shell_SecondaryTrayWnd")
	WheelUp::Send {Volume_Up}
	WheelDown::Send {Volume_Down}
	Mbutton::Send {Volume_Mute}

	MouseIsOver(WinTitle) {
		MouseGetPos,,, Win
		return WinExist(WinTitle . " ahk_id " . Win)
	}
#If


;*===============窗口上： LWin+鼠标滚轮：窗口置顶/取消置顶， LWin+Shift+鼠标滚轮：调节窗口透明度
~LWin & WheelUp::
#F1::
; 透明度调整，增加。
	BlockInput, On	;* 新增：阻塞键盘鼠标输入（不含触控板）
	if (GetKeyState("Shift")){
		WinGet, Transparent, Transparent,A
		If (Transparent="")
			Transparent=255
		Transparent_New := Transparent + 20    ;◆透明度增加速度。
		If (Transparent_New > 254)
			Transparent_New =255
		WinSet,Transparent,%Transparent_New%,A
		tooltip now: ▲%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
		;sleep 1500
		SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
	}else{
		WinSet AlwaysOnTop,On,A
		tooltip, AlwaysOnTop ON
		SetTimer, RemoveToolTip, -1000
	}
	BlockInput, Off
return
 
~LWin & WheelDown::
#F2::
;透明度调整，减少。
	BlockInput, On
	if (GetKeyState("Shift")){
		WinGet, Transparent, Transparent,A
		If (Transparent="")
			Transparent=255
		Transparent_New := Transparent - 20  ;◆透明度减少速度。
		If (Transparent_New < 35)    ;◆最小透明度限制。
			Transparent_New = 35
		WinSet,Transparent,%Transparent_New%,A
		tooltip now: ▼%Transparent_New%`nmae: __%Transparent%  ;查看当前透明度（操作之后的）。
		;sleep 1500
		SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
	}else{
		WinSet AlwaysOnTop,Off,A
		tooltip, AlwaysOnTop OFF
		SetTimer, RemoveToolTip, -1000
	}
	BlockInput, Off
return
 
;设置Lwin &Mbutton直接恢复透明度到255。
~LWin & Mbutton:: 
	WinGet, Transparent, Transparent,A
	WinSet,Transparent,255,A 
	tooltip ▲Restored ;查看当前透明度（操作之后的）。
	;sleep 1500
	SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, 1000  ;设置统一的这个格式，label在最后。
return
 
 
removetooltip_transparent_Lwin__2016.09.20:     ;LABEL
	tooltip
	SetTimer, RemoveToolTip_transparent_Lwin__2016.09.20, Off
return

;* ================ LWin+鼠标左右滚动 切换桌面
~LWin & WheelLeft::Send, ^#{Left}
~LWin & WheelRight::Send, ^#{Right}



;TODO 浏览器触控板缩放
#If ! WinActive("ahk_exe msedge.exe") || WinActive("ahk_exe chrome.exe")
	; ^WheelUp::
	
	; return
	
	; ^WheelDown::
	
	; return
	
#If

;^==================================== 测试代码和临时函数 ==================================
;* ============ 测试代码：当前键盘布局和输入法
#If use_test_getIMEcode == 1
	F16:: 
		InputLocaleID := GetCurrentKeyboardLayoutCode()
		;MsgBox, 0x40, 输入法%InputLocaleID%
		InputName := GetCurrentKeyboardLayoutName()
		MsgBox,  0x40, 当前输入法检测, ID:   %InputLocaleID% `nName: %InputName%
	return
#If
 
 ;^====================== 键盘相关函数
 ;* 释放 Shift Ctrl Alt 键
ReleaseShiftCtrlAltKeys(isTurnOffCapsLock := 0, isShowTooptip := 0)
{
	Send, {Ctrl Up}{Alt Up}{Shift Up}

	if(isTurnOffCapsLock == 1){	;* 是否释放CapsLock
		SetCapsLockState, 0
		
		if(isShowTooptip == 1){
			ShowToolTip("已释放 Ctrl Alt Shift 键，并关闭 CapsLock！", 700)
		}	
				
	}else{
		if(isShowTooptip == 1){
			ShowToolTip("已释放 Ctrl Alt Shift 键！", 700)
		}		
	}
	

	
	
}
 
 ;* 切换 CapsLock 状态
SwitchCapsLockStatus(status := -1, isShowTooltip := 0)
{

	switch status{
		case -1:
			if(0 == GetKeyState("CapsLock", "T")){
				SetCapsLockState, 1
			}else{
				SetCapsLockState, 0
			}	
				
			if(isShowTooltip == 1){
				ShowToolTip("已切换 CapsLock 状态", 400)
			}
			
		case 0:
			SetCapsLockState, 0
			if(isShowTooltip == 1){
				ShowToolTip("已关闭 CapsLock", 400)
			}
			
		case 1:
			SetCapsLockState, 1
			if(isShowTooltip == 1){
				ShowToolTip("已开启 CapsLock", 400)
			}
						
		Default:
			MsgBox, 0x10, 大写锁定切换, 函数 SwitchCapsLockStatus() 参数不合法！
	}
}
 
 
 
 ;^==================================== 输入法相关函数 ==================================
 
;* 获取当前使用的输入法/键盘布局名字，输出文本依照全局变量
GetCurrentKeyboardLayoutName(InputLocaleID:=0)
{
	global installedKeyboardLayout  ; 声明全局变量
	getLayout := 0
	layoutName := ""
	
	if(InputLocaleID == 0){
		InputLocaleID := GetCurrentKeyboardLayoutCode()
	}
	
	for ID, nm in installedKeyboardLayout{
		if(InputLocaleID == ID){
			getLayout := 1
			layoutName = %nm%
			;MsgBox, Found
			break
		}
	}
	
	if(getLayout == 0){
		MsgBox, 0x10, 未识别到你的输入法, 程序还没录入当前的输入法，不认识捏
	}
	
	;MsgBox, layoutName: %layoutName%
	
	Return layoutName
}

GetCurrentKeyboardLayoutCode()
{
	WinGet, WinID,, A
	ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
	InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
	;DllCall("GetKeyboardLayout","int",0,UInt)
	
	If(InputLocaleID == 0){
		WinActivate, ahk_class WorkerW
		WinGet, WinID2,, ahk_class WorkerW
		ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID2, "UInt", 0)
		WinActivate, ahk_id %WinID%
		InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
	}	
	return InputLocaleID
}

;* 切换输入法中英/韩英问状态，适用于
SwitchIMEmode()
{
	layout := GetCurrentKeyboardLayoutCode() ; 获取当前的输入法
	switch (layout){
		case 134481924:	; Chinese_Simp
			If(rime_KeymapChanged == 0){	;切换汉英
				Send, ^+{F4}
			}else{
				Send, ^{F20} 
			}
			
		case 68289554:	; Korean	要求：设置中关闭 RAlt 映射到韩英切换键，改为专用的 韩文切换键
			SendHangulKey()  ;切换韩英
			
		case 68224017:  ;japanese
			
	}
	
	ReleaseShiftCtrlAltKeys()
	SetCapsLockState, 0		; 关闭大写锁定，防止抽风
}

;*切换中英标点
SwitchPunctuationMode()
{
	global rime_KeymapChanged
	global use_RimeInput
	
	;* 如果不处于中文输入法下则退出
	if(134481924 != GetCurrentKeyboardLayoutCode()){ 
		return
	}
	
	if(use_RimeInput == 1){
		BlockInput, On	;阻塞用户输入增强稳定性	
		
		if(rime_KeymapChanged == 1){
			Send, {F20}
		}else{
			Send, ^``
		}
		Sleep, 150
		
		Send, {1}
		Sleep, 50
				
		Send, {5}
		Sleep, 50
		
		BlockInput, Off	
	}
	
	ShowToolTip("已切换 全角/半角标点 模式", 500)
	
	
	
}

;*简繁体切换
SwitchChineseSimplicatedMode()
{
	global rime_KeymapChanged
	global use_RimeInput
	
	;* 如果不处于中文输入法下则退出
	if(134481924 != GetCurrentKeyboardLayoutCode()){ 
		return
	}	
	
	if(use_RimeInput == 1){
		if(rime_KeymapChanged == 1){
			Send, ^+{F21}
		}else{
			Send, ^+{4}
		}		
	}else{
		
	}
	
	ShowToolTip("已切换 简体/繁体 模式", 500)
}

;*全角半角切换
SwitchFullHalfShapeMode()
{
	global rime_KeymapChanged
	
	keylayout := GetCurrentKeyboardLayoutCode()

	
	switch keylayout{
		case 134481924: ;*中文输入法
			if(use_RimeInput == 1){	;小狼毫输入法
				if(rime_KeymapChanged == 1){
					Send, ^+{F21}
				}else{
					Send, ^+{F20}
				}		
			}else{
				
			}	
		case 68289554:  ;*韩文输入法
		
		case 68224017: ;*日文输入法
			
		Default:
			
	}
	
	ShowToolTip("已切换 全角/半角 模式", 500)
}

;* 判断是否处于韩文输入法下, 输出 0 或者 1
IsInKoreanLayout()
{
	layout := GetCurrentKeyboardLayoutCode()
	
	If(layout == 68289554){	;* 如果处于韩文输入法下
		return 1
	}else{
		return 0
	}
}

SendHanjaKey()
{
	Send, {vk19}	; 汉字切换
}

SendHanjaKeyByDetectingIME()
{
	If(1 == IsInKoreanLayout()){	;* 如果处于韩文输入法下输出汉字键
		SendHanjaKey()	; 汉字切换
	}else{
		
	}	
}

SendHangulKey()
{
	Send, {vk15sc1F2}	;* 韩文键盘专有的「hangul」键
}


 
 
 
;^==================================== 跑路函数 ==================================
 
 
 ;*== 清除个人电脑中的隐私信息
 DeleteComputerPersonalData()
 {
	BlockInput, On	;阻塞用户输入增强稳定性	
	ShowToolTip("开始跑路...", 700)
	;Sleep, 500
	
	
 	DeleteComputerEvents()
	;DeletePersonalFiles()
	
	
	ShowToolTip("跑路成功！", 1500)
	BlockInput, Off
 }
 
 DeleteComputerEvents()
 {
	
	;*== 清除 windows 所有日志
	Runwait, powershell  -NoProfile -Command "Get-EventLog -LogName * | ForEach { Clear-EventLog $_.Log }"
	;-NoExit
	RunWait, cmd /c for /F "tokens=*" `%1 in ('wevtutil.exe el') DO wevtutil.exe cl "`%1"	
 }
 
 DeletePersonalFiles()
 {
	
 }
 
 DeleteAndroidEvents()
 {
	;*== 清除adb手机日志
	ShowToolTip("ADB 清除手机所有日志信息...", 1200)
	RunWait, cmd /c adb logcat -c -b main -b events -b radio -b system
	RunWait, cmd /c adb logcat -c -b main -b events -b radio -b system
	RunWait, cmd /c adb logcat -c -b main -b events -b radio -b system
	ShowToolTip("已清除手机日志信息...", 1500)
 }