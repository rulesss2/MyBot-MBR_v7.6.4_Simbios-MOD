; #FUNCTION# ====================================================================================================================
; Name ..........: GetLabLevel
; Description ...:
; Syntax ........: GetLabLevel($bFirstTime)
; Parameters ....: $bFirstTime          - a boolean value True = first time the bot has run
; Return values .: None
; Author ........: 
; Modified ......: 
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func GetLabLevel($bFirstTime = False)

	Local $aLabInfo[3] = ["", "", ""]

	If $g_bDebugSetlog Then SetDebugLog("Laboratory Position: " & $g_aiLaboratoryPos[0] & ", " & $g_aiLaboratoryPos[1], $COLOR_DEBUG)
	If isInsideDiamond($g_aiLaboratoryPos) = False Then ; If Lab pos is not known or is outside village then get new position
		LocateTownHall(True) ; Set flag = true for location only, or repeated loop happens
		If isInsideDiamond($g_aiLaboratoryPos) Then SaveConfig() ; save new location
		If _Sleep($DELAYGETTHLEVEL1) Then Return
	EndIf

	If $bFirstTime = True Then
		BuildingClickP($g_aiLaboratoryPos, "#0349")
		If _Sleep($DELAYGETTHLEVEL2) Then Return
	EndIf

	If $g_bDebugImageSave Then DebugImageSave("GetLabLevelView")

	$g_iLabLevel = 0 ; Reset Townhall level
	$aLabInfo = BuildingInfo(242, 520 + $g_iBottomOffsetY)
	If $g_bDebugSetlog Then SetDebugLog("$aLabInfo[0]=" & $aLabInfo[0] & ", $aLabInfo[1]=" & $aLabInfo[1] & ", $aLabInfo[2]=" & $aLabInfo[2], $COLOR_DEBUG)
	If $aLabInfo[0] > 1 Then
		If StringInStr($aLabInfo[1], "Laboratory") = 0 Then
			SetLog("Laboratory not found! I detected a " & $aLabInfo[1] & "! Please locate again!", $COLOR_WARNING)
			Return $aLabInfo
		EndIf
		If $aLabInfo[2] <> "" Then
			$g_iLabLevel = $aLabInfo[2] ; grab building level from building info array
			SetLog("Your Laboratory Level read as: " & $g_iLabLevel, $COLOR_SUCCESS)
		Else
			SetLog("Your Laboratory Level was not found! Please Manually Locate", $COLOR_INFO)
			ClickP($aAway, 1, 0, "#0350") ; Unselect Lab
			Return False
		EndIf
	Else
		SetLog("Your Laboratory Level was not found! Please Manually Locate", $COLOR_INFO)
		ClickP($aAway, 1, 0, "#0351") ; Unselect Lab
		Return False
	EndIf

	ClickP($aAway, 2, $DELAYGETTHLEVEL3, "#0352") ; Unselect Lab
	Return True

EndFunc   ;==>GetLabLevel
