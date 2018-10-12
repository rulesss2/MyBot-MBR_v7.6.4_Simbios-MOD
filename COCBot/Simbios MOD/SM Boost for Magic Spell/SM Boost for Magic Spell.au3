; #FUNCTION# ====================================================================================================================
; Name ..........: Boost for Magic Spell by SM MOD
; Description ...: This file Read/Save/Apply SM MODs settings
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: by SM MOD
; Modified ......: 
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================

Func chkBoostBMagic()
	If GUICtrlRead($g_hChkBoostBMagic) = $GUI_CHECKED Then
		$g_iChkBoostBMagic = 1
	Else
		$g_iChkBoostBMagic = 0
	EndIf
EndFunc   ;==>chkBoostBMagic


Func BoostBrMagic()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbBoostBrMagic)
		Case 0
			$g_iCmbBoostBrMagic = 0
		Case 1
			$g_iCmbBoostBrMagic = 1
		Case 2
			$g_iCmbBoostBrMagic = 2
		Case 3
			$g_iCmbBoostBrMagic = 3
		Case 4
			$g_iCmbBoostBrMagic = 4
		Case 5
			$g_iCmbBoostBrMagic = 5
	EndSwitch

EndFunc   ;==>BoostBrMagic


Func chkBoostCMagic()
	If GUICtrlRead($g_hChkBoostCMagic) = $GUI_CHECKED Then
		$g_iChkBoostCMagic = 1
	Else
		$g_iChkBoostCMagic = 0
	EndIf
EndFunc   ;==>chkBoostCMagic


Func BoostClMagic()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbBoostClMagic)
		Case 0
			$g_iCmbBoostClMagic = 0
		Case 1
			$g_iCmbBoostClMagic = 1
		Case 2
			$g_iCmbBoostClMagic = 2
		Case 3
			$g_iCmbBoostClMagic = 3
		Case 4
			$g_iCmbBoostClMagic = 4
		Case 5
			$g_iCmbBoostClMagic = 5
	EndSwitch

EndFunc   ;==>BoostClMagic
