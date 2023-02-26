; encoding: UTF-8 with BOM




str1 := "123"
str2 = 
(
456
	789
	%str1%
)


MsgBox, %str2%









Send2(ByRef str){
	SendInput, {Text}%str%
}

F16::
	Send2("..ss1/")
return

/*

..ss1/
..ss1/
..ss1/




*/