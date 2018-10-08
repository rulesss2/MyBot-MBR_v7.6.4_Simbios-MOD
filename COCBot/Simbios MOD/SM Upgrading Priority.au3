; #FUNCTION# ====================================================================================================================
; Name ..........: Wall/Building Upgrading Priority and  Priority System 
; Description ...: Wall/Building Upgrading Priority Option and  Priority System
; Author ........: by SM MOD
; Modified ......: 
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func chkUpgrPriority()
	If GUICtrlRead($g_hChkUpgrPriority) = $GUI_CHECKED Then
		$g_iChkUpgrPriority = 1
	Else
		$g_iChkUpgrPriority = 0
	EndIf
EndFunc   ;==>chkUpgrPriority


Func UpgrdPriority()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbUpgrdPriority)
		Case "Walls"
			$g_iCmbUpgrdPriority = 0 
		Case "Building"
			$g_iCmbUpgrdPriority = 1
	EndSwitch

EndFunc   ;==>UpgrdPriority

Func chkPrioritySystem()
	If GUICtrlRead($g_hChkPrioritySystem) = $GUI_CHECKED Then
		$g_bChkPrioritySystem = True
		GUICtrlSetState($g_hCmbPrioritySystem, $GUI_ENABLE)
	Else
		$g_bChkPrioritySystem = False
		GUICtrlSetState($g_hCmbPrioritySystem, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkPrioritySystem

Func PrioritySystem()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbPrioritySystem)
		Case "Elixir"
			$g_iCmbPrioritySystem = 0 
		Case "Dark Elixir"
			$g_iCmbPrioritySystem = 1
		Case "Dynamic"
			$g_iCmbPrioritySystem = 2
	EndSwitch

EndFunc   ;==>PrioritySystem