; #FUNCTION# ====================================================================================================================
; Name ..........: GetLabLevel
; Description ...:
; Syntax ........: GetLabLevel($bFirstTime)
; Parameters ....: $bFirstTime          - a boolean value True = first time the bot has run
; Return values .: None
; Author ........: Simbios Mod
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

	If $g_aiLaboratoryPos[0] = 0 Or $g_aiLaboratoryPos[1] = 0 Then
		SetLog("Laboratory Location not found!", $COLOR_WARNING)
		LocateLab() ; Lab location unknown, so find it.
		If $g_aiLaboratoryPos[0] = 0 Or $g_aiLaboratoryPos[1] = 0 Then
			SetLog("Problem locating Laboratory, train laboratory position before proceeding", $COLOR_ERROR)
			Return False
		EndIf
		If _Sleep($DELAYLABORATORY4) Then Return
	EndIf

	If $bFirstTime = True Then
		BuildingClickP($g_aiLaboratoryPos, "#0197") ;Click Laboratory
		If _Sleep($DELAYLABORATORY3) Then Return
	EndIf

	If $g_bDebugImageSave Then DebugImageSave("GetLabLevelView")

	$g_iLabLevel = 0 ; Reset Labortry level
	$aLabInfo = BuildingInfo(242, 520 + $g_iBottomOffsetY)
	If IsArray($aLabInfo) And UBound($aLabInfo) > 2 Then
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
				ClickP($aAway, 1, 0, "#0199") ; Unselect Lab
				Return False
			EndIf
		Else
			SetLog("Your Laboratory Level was not found! Please Manually Locate", $COLOR_INFO)
			ClickP($aAway, 1, 0, "#0199") ; Unselect Lab
			Return False
		EndIf
	Else
		SetLog("Your Laboratory Level was not found! Please Manually Locate", $COLOR_INFO)
		ClickP($aAway, 1, 0, "#0199") ; Unselect Lab
		Return False
	EndIf

	ClickP($aAway, 2, 0, "#0207") ; Unselect Lab
	Return True

EndFunc   ;==>GetLabLevel
