; #FUNCTION# ====================================================================================================================
; Name ..........: Multy Lang
; Description ...: Extended GUI Control Lang
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: by SM MOD
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func _SendExEx($sKeys, $iFlag = 0)
	If @KBLayout = 0419 Then
		Local $sANSI_Chars = "ёйцукенгшщзхъфывапролджэячсмитьбю.?"
	   Local $sASCII_Chars = "`qwertyuiop[]asdfghjkl;'zxcvbnm,./&"

		Local $aSplit_Keys = StringSplit($sKeys, "")
		Local $sKey
		$sKeys = ""

		For $i = 1 To $aSplit_Keys[0]
			$sKey = StringMid($sANSI_Chars, StringInStr($sASCII_Chars, $aSplit_Keys[$i]), 1)

			If $sKey <> "" Then
				$sKeys &= $sKey
			Else
				$sKeys &= $aSplit_Keys[$i]
			EndIf
		Next
	EndIf
	Return Send($sKeys, $iFlag)
EndFunc   ;==>_SendExEx

Func chkRusLang2()
	If GUICtrlRead($g_hChkRusLang2) = $GUI_CHECKED Then
	    $g_bChkRusLang2 = True
	Else
	    $g_bChkRusLang2 = False
	EndIf
EndFunc ;==>chkRusLangRequest 