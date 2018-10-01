; #FUNCTION# ====================================================================================================================
; Name ..........: SM FarmSchedule
; Description ...:
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: Demen
; Modified ......: Fahid.Mahmood
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......:  =====================================================================================================================

Global $g_ahChkSetFarm[8], _
		$g_ahCmbAction1[8], $g_ahCmbCriteria1[8], $g_ahTxtResource1[8], $g_ahCmbTime1[8], _
		$g_ahCmbAction2[8], $g_ahCmbCriteria2[8], $g_ahTxtResource2[8], $g_ahCmbTime2[8]

Func CreateFarmSchedule()

	Local $x = 10, $y = 30
	GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "Label_10", "Account"), $x - 5, $y, 60, -1, $SS_CENTER)
	GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "Label_11", "Farm Schedule 1"), $x + 80, $y, 150, -1, $SS_CENTER)
	GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Bot - Profiles", "Label_12", "Farm Schedule 2"), $x + 260, $y, 150, -1, $SS_CENTER)

	$y += 18
	GUICtrlCreateGraphic($x, $y, 425, 1, $SS_GRAYRECT)

	$y += 8
	For $i = 0 To 7
		$x = 10
		$g_ahChkSetFarm[$i] = GUICtrlCreateCheckbox("Acc " & $i + 1 & ".", $x, $y + $i * 30, -1, -1)
		GUICtrlSetOnEvent(-1, "chkSetFarmSchedule")
		$g_ahCmbAction1[$i] = GUICtrlCreateCombo("Turn...", $x + 60, $y + $i * 30, 58, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Idle|Donate|Active")
		GUICtrlSetBkColor(-1, $COLOR_WHITE)
		$g_ahCmbCriteria1[$i] = GUICtrlCreateCombo("When...", $x + 123, $y + $i * 30, 62, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Gold >|Elixir >|DarkE >|Trop. >|Time:")
		GUICtrlSetBkColor(-1, $COLOR_WHITE)
		GUICtrlSetOnEvent(-1, "cmbCriteria1")
		$g_ahTxtResource1[$i] = GUICtrlCreateInput("", $x + 187, $y + $i * 30, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		$g_ahCmbTime1[$i] = GUICtrlCreateCombo("", $x + 187, $y + $i * 30, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "0 am|1 am|2 am|3 am|4 am|5 am|6 am|7 am|8 am|9 am|10am|11am|" & _
				"12pm|1 pm|2 pm|3 pm|4 pm|5 pm|6 pm|7 pm|8 pm|9 pm|10pm|11pm")
		GUICtrlSetState(-1, $GUI_HIDE)

		$x = 248 + 10 - 60
		$g_ahCmbAction2[$i] = GUICtrlCreateCombo("Turn...", $x + 60, $y + $i * 30, 58, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Idle|Donate|Active")
		GUICtrlSetBkColor(-1, $COLOR_WHITE)
		$g_ahCmbCriteria2[$i] = GUICtrlCreateCombo("When...", $x + 123, $y + $i * 30, 62, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Gold <|Elixir <|DarkE <|Trop. <|Time:")
		GUICtrlSetBkColor(-1, $COLOR_WHITE)
		GUICtrlSetOnEvent(-1, "cmbCriteria2")
		$g_ahTxtResource2[$i] = GUICtrlCreateInput("", $x + 187, $y + $i * 30, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		$g_ahCmbTime2[$i] = GUICtrlCreateCombo("", $x + 187, $y + $i * 30, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "0 am|1 am|2 am|3 am|4 am|5 am|6 am|7 am|8 am|9 am|10am|11am|" & _
				"12pm|1 pm|2 pm|3 pm|4 pm|5 pm|6 pm|7 pm|8 pm|9 pm|10pm|11pm")
		GUICtrlSetState(-1, $GUI_HIDE)
	Next

EndFunc   ;==>CreateFarmSchedule


Func chkSetFarmSchedule()
	For $i = 0 To UBound($g_ahChkSetFarm) - 1
		If @GUI_CtrlId = $g_ahChkSetFarm[$i] Then
			Return _chkSetFarmSchedule($i)
		EndIf
	Next
EndFunc   ;==>chkSetFarmSchedule

Func _chkSetFarmSchedule($i)
	If GUICtrlRead($g_ahChkSetFarm[$i]) = $GUI_CHECKED Then
		_GUI_Value_STATE("ENABLE", $g_ahCmbAction1[$i] & "#" & $g_ahCmbAction2[$i] & "#" & $g_ahCmbCriteria1[$i] & "#" & $g_ahCmbCriteria2[$i])
		_cmbCriteria1($i)
		_cmbCriteria2($i)
	Else
		_GUI_Value_STATE("DISABLE", $g_ahCmbAction1[$i] & "#" & $g_ahCmbCriteria1[$i] & "#" & $g_ahTxtResource1[$i] & "#" & $g_ahCmbTime1[$i] & "#" & _
				$g_ahCmbAction2[$i] & "#" & $g_ahCmbCriteria2[$i] & "#" & $g_ahTxtResource2[$i] & "#" & $g_ahCmbTime2[$i])
	EndIf
EndFunc   ;==>_chkSetFarmSchedule

Func cmbCriteria1()
	For $i = 0 To UBound($g_ahCmbCriteria1) - 1
		If @GUI_CtrlId = $g_ahCmbCriteria1[$i] Then
			Return _cmbCriteria1($i)
		EndIf
	Next
EndFunc   ;==>cmbCriteria1

Func _cmbCriteria1($i)
	Local $aiDefaultValue[4] = ["11500000", "11500000", "235000", "5900"]
	Local $aiDefaultLimit[4] = [12000000, 12000000, 240000, 6000]
	Local $iCmbCriteria = _GUICtrlComboBox_GetCurSel($g_ahCmbCriteria1[$i])
	Switch $iCmbCriteria
		Case 0
			_GUI_Value_STATE("DISABLE", $g_ahCmbTime1[$i] & "#" & $g_ahTxtResource1[$i])
		Case 1 To 4
			GUICtrlSetState($g_ahCmbTime1[$i], $GUI_HIDE)
			GUICtrlSetState($g_ahTxtResource1[$i], $GUI_SHOW + $GUI_ENABLE)
			If GUICtrlRead($g_ahTxtResource1[$i]) = "" Or GUICtrlRead($g_ahTxtResource1[$i]) > $aiDefaultLimit[$iCmbCriteria - 1] Then GUICtrlSetData($g_ahTxtResource1[$i], $aiDefaultValue[$iCmbCriteria - 1])
			GUICtrlSetLimit($g_ahTxtResource1[$i], StringLen($aiDefaultValue[$iCmbCriteria - 1]))
		Case 5
			GUICtrlSetState($g_ahTxtResource1[$i], $GUI_HIDE)
			GUICtrlSetState($g_ahCmbTime1[$i], $GUI_SHOW + $GUI_ENABLE)
	EndSwitch
EndFunc   ;==>_cmbCriteria1

Func cmbCriteria2()
	For $i = 0 To UBound($g_ahCmbCriteria2) - 1
		If @GUI_CtrlId = $g_ahCmbCriteria2[$i] Then
			Return _cmbCriteria2($i)
		EndIf
	Next
EndFunc   ;==>cmbCriteria2

Func _cmbCriteria2($i)
	Local $aiDefaultValue[4] = ["01000000", "01000000", "020000", "3000"]
	Local $aiDefaultLimit[4] = [11999999, 11999999, 239999, 5999]
	Local $iCmbCriteria = _GUICtrlComboBox_GetCurSel($g_ahCmbCriteria2[$i])
	Switch $iCmbCriteria
		Case 0
			_GUI_Value_STATE("DISABLE", $g_ahTxtResource2[$i] & "#" & $g_ahCmbTime2[$i])
		Case 1 To 4
			GUICtrlSetState($g_ahCmbTime2[$i], $GUI_HIDE)
			GUICtrlSetState($g_ahTxtResource2[$i], $GUI_SHOW + $GUI_ENABLE)
			If GUICtrlRead($g_ahTxtResource2[$i]) = "" Or GUICtrlRead($g_ahTxtResource2[$i]) > $aiDefaultLimit[$iCmbCriteria - 1] Then GUICtrlSetData($g_ahTxtResource2[$i], Number($aiDefaultValue[$iCmbCriteria - 1]))
			GUICtrlSetLimit($g_ahTxtResource2[$i], StringLen($aiDefaultValue[$iCmbCriteria - 1]))
		Case 5
			GUICtrlSetState($g_ahTxtResource2[$i], $GUI_HIDE)
			GUICtrlSetState($g_ahCmbTime2[$i], $GUI_SHOW + $GUI_ENABLE)
	EndSwitch
EndFunc   ;==>_cmbCriteria2
