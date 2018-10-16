; #FUNCTION#  ====================================================================================================================
; Name ..........: MoveUpgrades
; Description ...: Move upgrade-box-checked buildings down or up one row OR to the bottom or top of the list
; Syntax ........: None
; Parameters ....: $bDirUp				boolean, up=True, down=False
;				   $bTillEnd			boolean, till end of the list, default False
; Return values .: Success:				None
;				   Failure:				None
;				   @error:				None
; Author ........: MMHK (July-2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: None
; ====================================================================================================================

Func MoveUpgrades($bDirUp, $bTillEnd = False)
	; save all GUI check box stats to the array variables
	btnchkbxUpgrade()
	btnchkbxRepeat()

	Local $iStart, $iStop, $iStep, $bSwap
	If $bDirUp Then
		$iStart = 0
		$iStop = $g_iUpgradeSlots - 1
		$iStep = 1
	Else
		$iStart = $g_iUpgradeSlots - 1
		$iStop = 0
		$iStep = -1
	EndIf
	Do
		$bSwap = False
		For $i = $iStart To $iStop Step $iStep
			If $g_abBuildingUpgradeEnable[$i] <> 1 Or $i = $iStart Then ContinueLoop
			If $g_abBuildingUpgradeEnable[$i - $iStep] <> 1 Then
				$bSwap = True
				SwapUpgrades($i, $i - $iStep)
			EndIf
		Next
	Until (Not $bTillEnd) Or (Not $bSwap)

	applyUpgradesGUI()
EndFunc   ;==>MoveUpgrades

Func SwapUpgrades($i, $j)
	_ArraySwap($g_aiPicUpgradeStatus, $i, $j)
	_ArraySwap($g_abBuildingUpgradeEnable, $i, $j)
	_ArraySwap($g_avBuildingUpgrades, $i, $j)
	_ArraySwap($g_abUpgradeRepeatEnable, $i, $j)
EndFunc   ;==>SwapUpgrades

Func applyUpgradesGUI()

	For $i = 0 To $g_iUpgradeSlots - 1 ; apply the buildings upgrade variable to GUI

		GUICtrlSetImage($g_hPicUpgradeStatus[$i], $g_sLibIconPath, $g_aiPicUpgradeStatus[$i]) ; set status pic

		If $g_abBuildingUpgradeEnable[$i] = 1 Then ; set upgrade check box
			GUICtrlSetState($g_hChkUpgrade[$i], $GUI_CHECKED)
		Else
			GUICtrlSetState($g_hChkUpgrade[$i], $GUI_UNCHECKED)
		EndIf

		GUICtrlSetData($g_hTxtUpgradeName[$i], $g_avBuildingUpgrades[$i][4]) ; set unit name
		GUICtrlSetData($g_hTxtUpgradeLevel[$i], $g_avBuildingUpgrades[$i][5]) ; set unit level

		Switch $g_avBuildingUpgrades[$i][3] ; set upgrade loot type
			Case "Gold"
				GUICtrlSetImage($g_hPicUpgradeType[$i], $g_sLibIconPath, $eIcnGold)
			Case "Elixir"
				GUICtrlSetImage($g_hPicUpgradeType[$i], $g_sLibIconPath, $eIcnElixir)
			Case "Dark"
				GUICtrlSetImage($g_hPicUpgradeType[$i], $g_sLibIconPath, $eIcnDark)
			Case Else
				GUICtrlSetImage($g_hPicUpgradeType[$i], $g_sLibIconPath, $eIcnBlank)
		EndSwitch

		If $g_avBuildingUpgrades[$i][2] > 0 Then ; set unit cost
			GUICtrlSetData($g_hTxtUpgradeValue[$i], _NumberFormat($g_avBuildingUpgrades[$i][2]))
		Else
			GUICtrlSetData($g_hTxtUpgradeValue[$i], "")
		EndIf

		GUICtrlSetData($g_hTxtUpgradeTime[$i], StringStripWS($g_avBuildingUpgrades[$i][6], $STR_STRIPALL)) ; set upgrade time

		If $g_abUpgradeRepeatEnable[$i] = 1 Then ; set repeat check box
			GUICtrlSetState($g_hChkUpgradeRepeat[$i], $GUI_CHECKED)
		Else
			GUICtrlSetState($g_hChkUpgradeRepeat[$i], $GUI_UNCHECKED)
		EndIf

	Next
EndFunc   ;==>applyUpgradesGUI

Func chkUpgradeAllOrNone()
	If GUICtrlRead($g_hChkUpgradeAllOrNone) = $GUI_CHECKED And GUICtrlRead($g_hChkUpgrade[0]) = $GUI_CHECKED Then
		For $i = 0 To $g_iUpgradeSlots - 1
			GUICtrlSetState($g_hChkUpgrade[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 0 To $g_iUpgradeSlots - 1
			GUICtrlSetState($g_hChkUpgrade[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_hChkUpgradeAllOrNone, $GUI_UNCHECKED)
EndFunc   ;==>chkUpgradeAllOrNone

Func chkUpgradeRepeatAllOrNone()
	If GUICtrlRead($g_hChkUpgradeRepeatAllOrNone) = $GUI_CHECKED And GUICtrlRead($g_hChkUpgradeRepeat[0]) = $GUI_CHECKED Then
		For $i = 0 To $g_iUpgradeSlots - 1
			GUICtrlSetState($g_hChkUpgradeRepeat[$i], $GUI_UNCHECKED)
		Next
	Else
		For $i = 0 To $g_iUpgradeSlots - 1
			GUICtrlSetState($g_hChkUpgradeRepeat[$i], $GUI_CHECKED)
		Next
	EndIf
	Sleep(300)
	GUICtrlSetState($g_hChkUpgradeRepeatAllOrNone, $GUI_UNCHECKED)
EndFunc   ;==>chkUpgradeRepeatAllOrNone

Func chkUpdateNewUpgradesOnly()
	If GUICtrlRead($g_hChkUpdateNewUpgradesOnly) = $GUI_CHECKED Then
		$g_ibUpdateNewUpgradesOnly = 1
	Else
		$g_ibUpdateNewUpgradesOnly = 0
	EndIf
EndFunc   ;==>chkUpdateNewUpgradesOnly

Func chkSmartSwitchUpgrade()
	If GUICtrlRead($g_hChkSmartSwitchUpgrade) = $GUI_CHECKED Then
		$g_bSmartSwitchUpgrade = True
	Else
		$g_bSmartSwitchUpgrade = False
	EndIf
EndFunc   ;==>chkSmartSwitchUpgrade

Func btnTop()
	MoveUpgrades($UP, $TILL_END)
EndFunc   ;==>btnTop

Func btnUp()
	MoveUpgrades($UP)
EndFunc   ;==>btnUp

Func btnDown()
	MoveUpgrades($DOWN)
EndFunc   ;==>btnDown

Func btnBottom()
	MoveUpgrades($DOWN, $TILL_END)
EndFunc   ;==>btnBottom
