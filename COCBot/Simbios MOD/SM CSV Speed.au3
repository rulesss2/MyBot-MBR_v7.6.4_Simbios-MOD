; #FUNCTION# ====================================================================================================================
; Name ..........: RK CSV Speed (v2)
; Description ...: This file contains all functions of RK CSV Speed feature
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: RoroTiti
; Modified ......: 08/05/2017
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......: ---
;================================================================================================================================

Func cmbCSVSpeed()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$g_iMatchMode])
		Case 0
			$g_CSVSpeedDivider = 0.5
		Case 1
			$g_CSVSpeedDivider = 0.75
		Case 2
			$g_CSVSpeedDivider = 1
		Case 3
			$g_CSVSpeedDivider = 1.25
		Case 4
			$g_CSVSpeedDivider = 1.5
		Case 5
			$g_CSVSpeedDivider = 2
		Case 6
			$g_CSVSpeedDivider = 3
	EndSwitch

	; Only LOG IF is a CSV attack
	If ($g_iMatchMode = $DB And $g_aiAttackAlgorithm[$DB] = 1) Or ($g_iMatchMode = $LB And $g_aiAttackAlgorithm[$LB] = 1) Then
		Setlog("Executing Scripted attack at " & $g_CSVSpeedDivider & " Speed", $COLOR_INFO)
	EndIF

EndFunc   ;==>cmbCSVSpeed
