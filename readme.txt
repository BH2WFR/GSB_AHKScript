^ ==================================== 使用说明和注意事项：=============================
*  -- 1. 要先使用 PowerToys 等工具物理映射下列按键：
;*			右Alt 或 分号键	 ->	F23(之前为F13), 需要更改全局变量"use_SemiColonAsRAlt"来选择
;*			CapsLock 		->	F24(之前为F14)

* -- 2. 中文 小狼毫输入法中，如下更改快捷键：
*				功能	|				默认映射			|			更改后映射			|    
			弹出菜单	|			F4 或 Ctrl+{`}			|		F20 或 Ctrl+Shift+{`(grave)}
			中英切换	|	Ctrl+Shift+2 或 Shift 或 Caps	|		Ctrl+F20
			全角/半角	|		Ctrl+Shift+3 				|		Ctrl+Shift+F20
			繁简切换	|		Ctrl+Shift+4 或 F4,1,4		|		Control+Shift+F21
			增广字集			Ctrl+Shift+5				|		Shift+F21
			中英标点	|		F4,1,5						|		Ctrl+F21	
 			输入法切换	|     .next  Ctrl+Shift+1			|		Shift+F20
			---------------------------------------------------------------------
*		更改方法：在程序目录的 key_bindings.yaml 中，找到对应配置代码，更改或 patch 为：
    - { when: always, accept: Shift+F20, select: .next }
    - { when: always, accept: Control+F20, toggle: ascii_mode }
    - { when: always, accept: Control+Shift+F20, toggle: full_shape }
    - { when: always, accept: Control+Shift+F21, toggle: simplification }
    - { when: always, accept: Shift+F21, toggle: extended_charset }
    - { when: always, accept: Ctrl+F21, toggle: ascii_punct }


;* -- 3. 朝鲜语输入法中 需要将键盘布局设置为：Keyboard layout: Korean keyboard (101 key) Type 1，
		即把韩文切换键和汉字键映射到专用按键上, 否则会默认按照 RAlt 韩英，RCtrl 汉字作为切换快捷键，
		输入法快捷键为系统级别快捷键，会干扰 PowerToys 的 将 RAlt 映射到 F23 的功能
; 			注释：Hangul Key:{vk15sc1F2}     Hanja Key:sc1F1




