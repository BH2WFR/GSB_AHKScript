; encoding: UTF-8 with BOM

;* ===== 检查脚本是否正确 include 到主脚本中, 确保此脚本不能单独运行
If (GSB_IsInMainScript != 1){ ;* 这个全局变量在主脚本中定义
	Msgbox, 0x10, 脚本 %A_ScriptName% 不支持单独运行, `n 此脚本 "%A_ScriptFullPath%" 为主脚本的 include 文件, 为脚本的一部分, 不能单独运行. `n `t请运行 main.ahk 脚本! `t程序退出! `n`n GSB_IsInMainScript == %GSB_IsInMainScript%
	ExitApp
}

#If GSB_IsInMainScript == 1

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
LWin & WheelUp::
#F1::
	SetWindowOnTopOrTransparency_detectKey("Up")
return
 
LWin & WheelDown::
#F2::
	SetWindowOnTopOrTransparency_detectKey("Down")
return
 
 
;设置Lwin &Mbutton直接恢复透明度到255。
~LWin & Mbutton:: 
	SetWindowOnTopOrTransparency_detectKey("Reset")
return
 
 


;* ================ LWin+鼠标左右滚动 切换桌面
; $LWin Up::Send, {LWin}
$#WheelLeft::Send, ^#{Left}
$#WheelRight::Send, ^#{Right}





;*========== RAlt+方向键 以像素为单位移动鼠标指针, 加上 Shift 后快速移动鼠标
#If 1




	F23 & RWin::
		Send, {LButton}
	return



	F23 & AppsKey::
		Send, {RButton}
	return


#If








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
 
 
 ;^==================================== 鼠标相关函数 ===========================================
 
;*移动鼠标，Dir=1左，2右，3上，4下； Increment 为每次移动像素点
MoveMouse(ByRef Dir, Increment, isShowTooptip:=0, isBlockInput := 1)
{
	CoordMode,Mouse,Screen	;必须加入，适应多屏幕情况，否则会抽风
	MouseGetPos,x_pos,y_pos	;获取鼠标位置
	
	If(isBlockInput == 1){ ;* 屏蔽外界输入
		BlockInput, On
	}
	
	;MsgBox,  X:%x_pos% Y:%y_pos%, incr:%Increment%, Dir:%Dir%
	Switch Dir{	;加入方向增量
		case "Left", "left", "L", "l", "←":
			x_pos -= Increment
		case "Right", "right","R", "r", "→":
			x_pos += Increment
		case "Up", "up", "U", "u", "↑":
			y_pos -= Increment
		case "Down", "down", "D", "d", "↓":
			y_pos += Increment
		default:
			ShowMsgBoxParameterError("移动鼠标", A_ThisFunc, "方向指令无效，请输入小写字母的 up, down, left, right")
			BlockInput, Off
			return
	}
	
	;MsgBox,  X:%x_pos% Y:%y_pos%
	DllCall("SetCursorPos", "int", x_pos, "int", y_pos)	;移动鼠标指针到指定位置
	;MsgBox,  X:%x_pos% Y:%y_pos%
	
	if(isShowTooptip == 1)
	{	
		if(Increment == 1){
			ShowToolTip("移动鼠标指针, 方向 " . dir, 400)
		}else{
			ShowToolTip("快速移动鼠标指针, 方向 " . dir, 400)
		}
	}
	
	If(isBlockInput == 1){ ;* 恢复外界输入
		BlockInput, Off
	}
}

MoveMouse_detectKey(dir:="")	; 检测按键和 Shift 状态, 用于热键上
{
	global g_MouseQuickMoveUnitPixels
	
	if (GetKeyState("Shift")){
		increment := g_MouseQuickMoveUnitPixels
	}else{
		increment := 1
	}
	
	;dir := Trim(dir)
	
	if(dir == ""){
		if (InStr(A_ThisHotkey, "Left")){
			dir := "Left"
			
		}else if (InStr(A_ThisHotkey, "Right")){
			dir := "Right"
			
		}else if (InStr(A_ThisHotkey, "Up")){
			dir := "Up"
			
		}else if (InStr(A_ThisHotkey, "Down")){
			dir := "Down"
			
		}			
	}
	
		
	MoveMouse(dir, increment, 1)
	
}

;* 发送鼠标滚动操作
MouseWheelScroll(ByRef dir, steps:= 1, isShowTooptip:=0, isBlockInput := 1)
{	
	If(isBlockInput == 1){ ;* 屏蔽外界输入
		BlockInput, On
	}

 	;* 直接发送鼠标横向滚动键
	Switch dir{
		case "Up", "up", "U", "u", "↑":
			Send, {WheelUp %steps%}
			strapd := ""
		case "Down", "down", "D", "d", "↓":
			Send, {WheelDown %steps%}		
			strapd := ""
		case "Left", "left", "L", "l", "←":
			Send, {WheelLeft %steps%}	
			strapd := "横向"
		case "Right", "right","R", "r", "→":
			Send, {WheelRight %steps%}	
			strapd := "横向"
		Default:
			ShowMsgBoxParameterError("滚动鼠标", A_ThisFunc, "方向指令无效，请输入小写字母的 up, down, left, right")
			BlockInput, Off
			return
	}
	
	if(isShowTooptip == 1)
	{
		if(steps == 1){
			ShowToolTip(strapd . "滚动鼠标滚轮, 方向 " . dir, 500)
		}else{
			ShowToolTip(strapd . "快速滚动鼠标滚轮, 方向 " . dir, 500)
		}
	}
	
	If(isBlockInput == 1){ ;* 恢复外界输入
		BlockInput, Off
	}
}

MouseWheelScroll_detectKey(dir:="")	; 检测按键和 Shift 状态, 用于热键上
{
	global g_MouseQuickScrollUnit
	
	if (GetKeyState("Shift")){
		increment := g_MouseQuickScrollUnit
	}else{
		increment := 1
	}	
	
	if(dir == ""){
		if (InStr(A_ThisHotkey, "Left")){
			dir := "Left"
			
		}else if (InStr(A_ThisHotkey, "Right")){
			dir := "Right"
			
		}else if (InStr(A_ThisHotkey, "Up")){
			dir := "Up"
			
		}else if (InStr(A_ThisHotkey, "Down")){
			dir := "Down"
			
		}			
	}	
	
	MouseWheelScroll(dir, increment, 1)
	
}






;* 发送方向键
SendDirectionKey(ByRef dir, steps:= 1, isShowTooptip:=0 , isBlockInput := 1)
{	
	If(isBlockInput == 1){ ;* 屏蔽外界输入
		BlockInput, On
	}
	
 	;* 直接发送鼠标横向滚动键
	Switch dir{
		case "Up", "up", "U", "u", "↑":
			Send, {Up %steps%}
		case "Down", "down", "D", "d", "↓":
			Send, {Down %steps%}		
		case "Left", "left", "L", "l", "←":
			Send, {Left %steps%}	
		case "Right", "right","R", "r", "→":
			Send, {Right %steps%}	
		Default:
			ShowMsgBoxParameterError("发送方向键", A_ThisFunc, "方向指令无效，请输入小写字母的 up, down, left, right")
			BlockInput, Off
			return
	}
	
	if(isShowTooptip == 1)
	{
		if(steps == 1){
			;ShowToolTip("正在滚动页面, 方向 " . dir, 300)
		}else{
			ShowToolTip("正在发送多次方向键, 方向 " . dir, 300)
		}
	}
	
	If(isBlockInput == 1){ ;* 恢复外界输入
		BlockInput, Off
	}
}

SendDirectionKey_detectKey(dir:="")	; 检测按键和 Shift 状态, 用于热键上
{
	global g_SendDirectionKeyQuickModeUnit
	
	if (GetKeyState("Shift")){
		increment := g_SendDirectionKeyQuickModeUnit
	}else{
		increment := 1
	}	
	
	if(dir == ""){
		if (InStr(A_ThisHotkey, "Left")){
			dir := "Left"
			
		}else if (InStr(A_ThisHotkey, "Right")){
			dir := "Right"
			
		}else if (InStr(A_ThisHotkey, "Up")){
			dir := "Up"
			
		}else if (InStr(A_ThisHotkey, "Down")){
			dir := "Down"
			
		}			
	}	
	
	SendDirectionKey(dir, increment, 1)	
}



 
 
 ;^======================================== 键盘相关函数 ========================================
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
			ShowMsgBoxParameterError("大写锁定切换", A_ThisFunc, "参数不合法！请输入 -1 0 或 1")
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
		ShowMsgBoxError("获取当前输入法", "程序还没录入当前的输入法, 暂时无法识别", A_ThisFunc)
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
	
	ReleaseShiftCtrlAltKeys(1)  ; 关闭大写锁定，施放按键
	
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
	global use_RimeInput
	
	keylayout := GetCurrentKeyboardLayoutCode()

	
	switch keylayout{
		case 134481924: ;*中文输入法
			if(use_RimeInput == 1){	;小狼毫输入法
			
				; BlockInput, On
				
				if(rime_KeymapChanged == 1){
					Send, ^+{F20}
					; Send, {F20}
				}else{
					Send, ^+{3}
					; Send, ^``
				}
				; MsgBox, 11
				; Sleep, 150
				
				; Send, {1}
				; Sleep, 50
						
				; Send, {3}
				; Sleep, 50				
				
				; BlockInput, Off
				
					
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



;^================================= 系统API相关函数  ==============================

;*=== 窗体置顶
SetWindowOnTopStatus(status := -1)
{
	switch status{
		case 0:
			WinSet AlwaysOnTop,Off,A
			ShowToolTip("已取消置顶当前窗口", 1000)
			
		case 1:
			WinSet AlwaysOnTop,On,A
			ShowToolTip("已置顶当前窗口", 1000)
			
		Default:
			ToggleWindowOnTopStatus() ; 切换置顶/非置顶，
	}
}

ToggleWindowOnTopStatus()
{
	; Use ExStyle to figure out if AlwaysOnTop is set, and display a ToolTip
	WinGet, ExStyle, ExStyle, A

	if (ExStyle & 0x8) {	; 窗口已经置顶
		SetWindowOnTopStatus(0)
		;ToolTip, AlwaysOnTop - "%title%"
	} else {		; 窗口没有置顶
		SetWindowOnTopStatus(1)
		;ToolTip, Not AlwaysOnTop - "%title%"
	}	
}

;*=== 窗体透明度设置
SetWindowTransparency(ByRef value, isBlockInput := 0)
{
	maxTransparency := 255
	minTransparency := 35
	
	if(isBlockInput == 1){
		BlockInput, On	;* 新增：阻塞键盘鼠标输入（不含触控板）
	}
	
	WinGet, Transparent, Transparent,A ; 获取当前透明度
	
	If (Transparent=""){
		Transparent=255	
	}	
	
		
	switch value{
		case "Up", "up", "UP", "Increase", "increase", "U", "u", "↑":
			Transparent_New := Transparent + 20    ;透明度增加速度。
			If (Transparent_New >= maxTransparency){		;最大透明度限制。
				Transparent_New := maxTransparency	
			}		
			ShowToolTip("当前窗口透明度：▲ 增加`n   now: " . Transparent_New . "    mae: __" . Transparent , 1000)
			
		case "Down", "down", "DN", "Decrease", "decrease", "D", "d", "↓":
			Transparent_New := Transparent - 20  ;透明度减少速度。
			If (Transparent_New <= minTransparency) {   ;最小透明度限制。
				Transparent_New := minTransparency
			}
			ShowToolTip("当前窗口透明度：▼ 减少`n   now: " . Transparent_New . "    mae: __" . Transparent , 1000)
			
			
		case "Reset", "reset", "Rst", "rst", "RST":
			Transparent_New := 255
			ShowToolTip("当前窗口透明度：◉ 已重置`n ", 1000)
			
		Default:
			if (value is number){
				If (value >= maxTransparency){		;最大透明度限制。
					value := maxTransparency	
				}
				If (value <= minTransparency) {   ;最小透明度限制。
					value := minTransparency
				}				
				Transparent_New := value
				
			}else{
				ShowMsgBoxParameterError("窗口透明度设置", A_ThisFunc, " 参数错误！, 接收 Up, Down, Reset 这三种字符串，或一个 0-255 的整数值！")
				
				BlockInput, Off
				return
			}
			
		
	}
	
	WinSet,Transparent,%Transparent_New%,A	; 设置透明度
	
	

	if(isBlockInput == 1){
		BlockInput, Off	
	}
}


SetWindowOnTopOrTransparency_detectKey(dir)
{
	switch dir{
		case "Up", "up", "UP", "Increase", "increase", "U", "u", "↑":
			if (GetKeyState("Shift")){
				SetWindowTransparency("Up")
			}else{
				SetWindowOnTopStatus(1)
			}		
				
		case "Down", "down", "DN", "Decrease", "decrease", "D", "d", "↓":
			if (GetKeyState("Shift")){
				SetWindowTransparency("Down")
			}else{
				SetWindowOnTopStatus(0)
			}
		case "Toggle", "toggle", "Reset", "reset", "RST":
			if (GetKeyState("Shift")){
				SetWindowTransparency("Reset")
			}else{
				ToggleWindowOnTopStatus()
			}			
		Default:
			ShowMsgBoxParameterError("窗口透明度设置", A_ThisFunc, "参数错误！请输入 Up/Down/Toggle/Reset")
		
	}
	
	
	

}

;*======= 强制调整窗口大小
ForceModifyWindowSize(Width:=0, Height:=0, isShowToolTip := 1, ByRef str := "")
{
	
	if(str == ""){  ;字符串未传参或非空
		str := "已强制修改当前窗口大小"
	}
	
	if(Width > 200){
		;调整窗体宽度
		if(str != ""){
			str := str . ", 宽度调整为:" . Width
		}
		
		WinMove, A, , , , %Width%
	}

	if(Height > 200){
		;调整窗体高度
		if(str != ""){
			str := str . ", 高度调整为:" . Height
		}
		
		WinMove, A, , , , , %Height%
	}
		
	if(isShowToolTip == 1){
		ShowToolTip(str, 1000)
	}
}

ForceModifyWindowSizeByIncrement(Width_increment:=0, Height_increment:=0)
{
	WinGetPos, form_X, form_Y, form_Width, form_Height, A	
	form_Width += Width_increment
	form_Height += Height_increment
	
	
	ForceModifyWindowSize(form_Width, form_Height, 0)
	ShowToolTip("已改变窗口大小, 宽度增加:" . form_Width . ", 高度增加:" . form_Height, 1000)
	
}



;*======= 强制把窗口放到屏幕正中间，并调整大小
ForceMoveWindowToCenter(Width:=0, Heigth:=0)
{
	;ShowToolTip("强制窗口移动到屏幕正中间并调整大小功能: 未开发完毕，敬请等待…", 1000)
	WinGetPos, form_X, form_Y, form_Width, form_Height, A
	TargetX := (A_ScreenWidth / 2) - (form_Width / 2)
	TargetY := (A_ScreenHeight / 2) - (form_Height / 2)
	
	; 窗口居中
	WinMove, A, , %TargetX%, %TargetY%
	toolTipStr := "已将此窗口强制移动到屏幕正中间"
	
	ForceModifyWindowSize(Width, Height, 0, toolTipStr)
	
	ShowToolTip(toolTipStr, 1000)
	
}

ForceMoveWindowToCenter_detectShiftKey()
{
	if (GetKeyState("Shift")){
		ForceModifyWindowSize(800, 600)
	}else{
		ForceMoveWindowToCenter()
	}
}


;*===== 查看当前活动窗口的各项属性
ShowCurrentWindowInformation()
{
	WinGetTitle, form_Title, A
	WinGetClass, form_Class, A
	WinGetPos, form_X, form_Y, form_W, form_H, A
	
	WinGet, form_ID, ID, A
	WinGet, form_PID, PID,A
	WinGet, form_ProcessName, ProcessName,A
	WinGet, form_ProcessPath, ProcessPath,A
	
	WinGet, form_Count, Count,A
	WinGet, form_Style, Style,A
	WinGet, form_ExStyle, ExStyle,A		
	WinGet, form_transparency, Transparent,A

	WinGet, form_ControlListHwnd, ControlListHwnd,A
	WinGet, form_ControlList, ControlList,A
	WinGet, form_MinMax, MinMax,A
	WinGet, form_List, List,A

	switch form_MinMax{
		case -1:
			form_MinMax_text := "最大化"
		case 1:
			form_MinMax_text := "最小化"
		case 0:
			form_MinMax_text := "正常"
	}
	
	if(form_transparency == ""){
		form_transparency := 255
	}
	
	str = 
(
当前窗口标题: "%form_Title%" 的各项信息如下：

ID (句柄 HWND):	%form_ID%
PID (进程 PID):	%form_PID%
Class:		%form_Class%
进程名:		%form_ProcessName%
进程路径:	
       %form_ProcessPath%
	   
Count (窗口数量):%form_Count%
透明度:		%form_transparency%  (范围：0~255)
位置和大小：	X 座标: %form_X% | Y 座标: %form_Y% | 宽度: %form_W% | 高度: %form_H%
最大化/最小化:	%form_MinMax%:   %form_MinMax_text%
List（窗口号）:	%form_List%

Style:		%form_Style%
ExStyle:		%form_ExStyle%
)
; ControlListHwnd (窗体中每个控件的唯一 ID 号):
; %form_ControlListHwnd%

; ControlList (窗体中每个控件的控件名):
; %form_ControlList%



; )

	MsgBox, 0x1000, 当前窗口信息, %str%
	
}


;^==================================== 跑路函数 ==================================
 ;*强制关机
System_ForceShutdown(waitTime := 15)
{
	Run, cmd /c shutdown -s -f -t %waitTime%  ;15秒后强制关机
}
 
 
 ;*取消强制关机
System_CancelShutdown()
{
	System_RunCMDCommand("shutdown -a", 0, 1)
	ShowToolTip("已取消强制关机", 700)
}

;*== 执行 CMD 命令, 参数 isSilent==2 时根据全局变量 g_isKeepSilentWhileCleaning 决定是否静默运行
System_RunCMDCommand(ByRef cmdstr, isWait := 1, isSilent := 0)
{
	global g_isKeepSilentWhileCleaning
	
	if(isSilent == 2){
		isSilent := g_isKeepSilentWhileCleaning
	}
	
	if(isWait == 1){
		if(isSilent == 0){
			RunWait, cmd /c %cmdstr%
		}else{
			RunWait, cmd /c %cmdstr%, , Hide
		}			
	}else{
		if(isSilent == 0){
			Run, cmd /c %cmdstr%
		}else{
			Run, cmd /c %cmdstr%, , Hide
		}			
	}

}
 ;*== 清除个人电脑中的隐私信息
DeleteComputerPersonalData()
{
	global g_ShutDownAfterCleaning
	
	BlockInput, On	;阻塞用户输入增强稳定性	
	ShowToolTip("开始跑路...", 700)
	
	Sleep, 500
	
	

	DeletePersonalFiles()
	
	Extern_PrivacyEraser()
	Extern_USBOblivion()
	
 	DeleteComputerEvents()	
	
	;Sleep, 20000
	
	if(g_ShutDownAfterCleaning == 0){
		ShowToolTip("跑路成功！", 1500)
	}else{
		ShowToolTip("跑路成功！ 15 秒后即将强制关机, 运行 Shutdown -a 撤销关机功能...", 1500)
		System_ForceShutdown()  ;15秒后强制关机
	}
	
	BlockInput, Off
}

;* 删除 Windows 系统所有日志
DeleteComputerEvents()
{
	global g_isKeepSilentWhileCleaning
	
	;*== 清除 windows 所有日志
	ShowToolTip("正在清除所有 Windows 日志...", 1200)
	
	if(g_isKeepSilentWhileCleaning == 0){
		Runwait, powershell  -NoProfile -Command "Get-EventLog -LogName * | ForEach { Clear-EventLog $_.Log }"
		RunWait, cmd /c for /F "tokens=*" `%1 in ('wevtutil.exe el') DO wevtutil.exe cl "`%1"
	}else{
		Runwait, powershell  -NoProfile -Command "Get-EventLog -LogName * | ForEach { Clear-EventLog $_.Log }", , Hide
		RunWait, cmd /c for /F "tokens=*" `%1 in ('wevtutil.exe el') DO wevtutil.exe cl "`%1", , Hide
	}	
	
}
 
DeletePersonalFiles()
{
	
}

;* ADB 清除安卓手机的所有日志
DeleteAndroidEvents(loopTime := 3)
{
	global g_ADBPath
	global g_isKeepSilentWhileCleaning
		
	;*== 清除adb手机日志
	ShowToolTip("正在使用 ADB 清除手机所有日志信息...", 1200)
	
	cmdstr := g_ADBPath . " logcat -c -b main -b events -b radio -b system"
	Loop, %loopTime%{
		System_RunCMDCommand(cmdstr, 1, 0)
	}
	
	ShowToolTip("已清除手机日志信息...", 1500)
}

;* 调用 PrivacyEraser 软件 删除电脑上的隐私和系统垃圾
Extern_PrivacyEraser()
{
	global g_isKeepSilentWhileCleaning
	global g_PrivacyEraserPath
	
	ShowToolTip("正在使用 PrivacyEraser 清除电脑痕迹信息...", 800)
	
	cmdstr := g_PrivacyEraserPath . " /Clean"
	
	if(g_isKeepSilentWhileCleaning == 1){
		cmdstr := cmdstr . " /Silent"
	}
	
	System_RunCMDCommand(cmdstr, 1, g_isKeepSilentWhileCleaning)
	
}

;* 调用 USBOblivion 软件 删除电脑上的所有 USB 使用记录
Extern_USBOblivion()
{
	;cmdstr := """" . g_USBOblivionPath . """"
	global g_isKeepSilentWhileCleaning
	global g_USBOblivionPath
	global g_isRestartExplorerWhileCleaning
	
	ShowToolTip("正在使用 USBOblivion 清除电脑 USB 使用记录...", 800)
	
	cmdstr := g_USBOblivionPath . " -norestart -auto -enable"
	
	if(g_isKeepSilentWhileCleaning == 1){
		cmdstr := cmdstr . " -silent"
	}	

	if(g_isRestartExplorerWhileCleaning == 0){
		cmdstr := cmdstr . " -noexplorer"
	}	
		
	System_RunCMDCommand(cmdstr, 1, g_isKeepSilentWhileCleaning)
	
}




#If ;GSB_IsInMainScript == 1
