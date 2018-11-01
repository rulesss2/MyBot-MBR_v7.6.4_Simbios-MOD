; #FUNCTION# ====================================================================================================================
; Name ..........: Laboratory
; Description ...:
; Syntax ........: Laboratory()
; Parameters ....:
; Return values .: None
; Author ........: summoner
; Modified ......: KnowJack (2015-06), Sardo (2015-08), Monkeyhunter(2016-02,2016-04), MMHK(2018-06)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global Const $sColorNA = Hex(0xD3D3CB, 6) ; relative location: 47,1; Troop not unlocked in Lab, beige pixel in center just below edge for troop
Global Const $sColorNoLoot = Hex(0xFD877E, 6) ; relative location: 68,79 & 68,84; Not enough loot available to upgrade, find pink pixel in value
Global Const $sColorMaxLvl = Hex(0xFFFFFF, 6) ; relative location: 76,76 & 76,80; Upgrade already at MAX level, white in last "l"
Global Const $sColorLabUgReq = Hex(0x838383, 6) ; relative location: 0,20 or 93,20 lab upgrade required, Look for Gray pixel inside left border
Global Const $sColorMaxTroop = Hex(0xFFC360, 6) ; relative location: 23,60; troop already MAX
Global Const $aiCloseDefaultPOS[2] = [721, 143]
Global Const $aiIconDefaultPOS[33][2] = [ _
		[-1, -1], _						 ; blank
		[120, 337 + $g_iMidOffsetY], _	 ; page 1
		[120, 444 + $g_iMidOffsetY], _
		[227, 337 + $g_iMidOffsetY], _
		[227, 444 + $g_iMidOffsetY], _
		[334, 337 + $g_iMidOffsetY], _
		[334, 444 + $g_iMidOffsetY], _
		[440, 337 + $g_iMidOffsetY], _
		[440, 444 + $g_iMidOffsetY], _
		[547, 337 + $g_iMidOffsetY], _
		[547, 444 + $g_iMidOffsetY], _
		[654, 337 + $g_iMidOffsetY], _
		[654, 444 + $g_iMidOffsetY], _
		[220, 337 + $g_iMidOffsetY], _	 ; page 2
		[220, 444 + $g_iMidOffsetY], _
		[327, 337 + $g_iMidOffsetY], _
		[327, 444 + $g_iMidOffsetY], _
		[433, 337 + $g_iMidOffsetY], _
		[433, 444 + $g_iMidOffsetY], _
		[540, 337 + $g_iMidOffsetY], _
		[540, 444 + $g_iMidOffsetY], _
		[113, 337 + $g_iMidOffsetY], _ 	 ; page 3
		[113, 444 + $g_iMidOffsetY], _
		[220, 337 + $g_iMidOffsetY], _
		[220, 444 + $g_iMidOffsetY], _
		[327, 337 + $g_iMidOffsetY], _
		[327, 444 + $g_iMidOffsetY], _
		[433, 337 + $g_iMidOffsetY], _
		[433, 444 + $g_iMidOffsetY], _
		[540, 337 + $g_iMidOffsetY], _
		[540, 444 + $g_iMidOffsetY], _
		[647, 337 + $g_iMidOffsetY], _
		[647, 444 + $g_iMidOffsetY]]

Func Laboratory()

	;Create local static array to hold upgrade values
	Static $aUpgradeValue[33] = [-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	Local $iAvailElixir, $iAvailDark, $sElixirCount, $sDarkCount, $TimeDiff, $aArray, $Result
	Local $iLevel = 0
	;------------------ADDED By SM MOD - START------------------
	If $g_iLabCheck = 0 And $g_bChkPrioritySystem = True Then
		SetLog("Laboratory Priority Level Reset In Progress.", $COLOR_INFO)
		For $iz = 0 To 31
			Switch $iz
				Case 0 To 12
					ContinueCase
				Case 23 To 29
					If $g_aiTrainArmyTroopLevel[$g_iUpgradeLevel[$iz][3]] = 0 Or ($iLabMax[$iz][$g_iLabLevel] <= $g_aiTrainArmyTroopLevel[$g_iUpgradeLevel[$iz][3]] And $g_iLabLevel > 10) Then
						$g_aiTrainArmyTroopLevel[$g_iUpgradeLevel[$iz][3]] = 1
						LevUpDownTroop($g_iUpgradeLevel[$iz][3], False)
					EndIf
				Case 13 To 22
					If $g_aiTrainArmySpellLevel[$g_iUpgradeLevel[$iz][3]] = 0 Or ($iLabMax[$iz][$g_iLabLevel] <= $g_aiTrainArmySpellLevel[$g_iUpgradeLevel[$iz][3]] And $g_iLabLevel > 10) Then
						$g_aiTrainArmySpellLevel[$g_iUpgradeLevel[$iz][3]] = 1
						LevUpDownSpell($g_iUpgradeLevel[$iz][3], False)
					EndIf
				Case 30 To 31
					If $g_aiTrainArmySiegeMachineLevel[$g_iUpgradeLevel[$iz][3]] = 0 Or ($iLabMax[$iz][$g_iLabLevel] <= $g_aiTrainArmySiegeMachineLevel[$g_iUpgradeLevel[$iz][3]] And $g_iLabLevel > 10) Then
						$g_aiTrainArmySiegeMachineLevel[$g_iUpgradeLevel[$iz][3]] = 1
						LevUpDownSiege($g_iUpgradeLevel[$iz][3], False)
					EndIf
			EndSwitch
		Next
		$g_iLabCheck = 1
		Return
	ElseIf $g_iLabCheck = 1 And $g_bChkPrioritySystem = True Then
		LabPriority()
		Sleep(5000)
	EndIf
	If $g_iCmbLaboratory > 0 Then
		$iLevel = Int(IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[Int($g_iCmbLaboratory - 1)][0], $g_iUpgradeLevel[Int($g_iCmbLaboratory - 1)][1], 1))
	EndIf
	;------------------ADDED By SM MOD - END------------------
	$g_iUpgradeMinElixir = Number($g_iUpgradeMinElixir)
	$g_iUpgradeMinDark = Number($g_iUpgradeMinDark)

	$g_iLaboratoryElixirCost = 0
	If Not $g_bAutoLabUpgradeEnable Then Return ; Lab upgrade not enabled.
	If $g_iCmbLaboratory = 0 Then
		SetLog("Laboratory enabled, but no troop upgrade selected", $COLOR_WARNING)
		Return False ; Nothing selected to upgrade
	EndIf
	;------------------ADDED By SM MOD - START------------------
	If $g_iLabUpgradeProgress = 0 Or $g_iMaxCount < 32 Then
		Collect()
		_Sleep($DELAYRUNBOT1)
	EndIf
	;------------------ADDED By SM MOD - END------------------
	If $g_aiLaboratoryPos[0] = 0 Or $g_aiLaboratoryPos[1] = 0 Then
		SetLog("Laboratory Location not found!", $COLOR_WARNING)
		LocateLab() ; Lab location unknown, so find it.
		If $g_aiLaboratoryPos[0] = 0 Or $g_aiLaboratoryPos[1] = 0 Then
			SetLog("Problem locating Laboratory, train laboratory position before proceeding", $COLOR_ERROR)
			Return False
		EndIf
	EndIf

	If $g_sLabUpgradeTime <> "" Then $TimeDiff = _DateDiff("n", _NowCalc(), $g_sLabUpgradeTime) ; what is difference between end time and now in minutes?
	If @error Then _logErrorDateDiff(@error)
	If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$g_iCmbLaboratory][3] & " Lab end time: " & $g_sLabUpgradeTime & ", DIFF= " & $TimeDiff, $COLOR_DEBUG)

	If Not $g_bRunState Then Return
	If $TimeDiff <= 0 Then
		SetLog("Checking Troop Upgrade in Laboratory ...", $COLOR_INFO)
	Else
		SetLog("Laboratory Upgrade in progress, waiting for completion", $COLOR_INFO)
		Return False
	EndIf

	; Get updated village elixir and dark elixir values
	If _CheckPixel($aVillageHasDarkElixir, $g_bCapturePixel) Then ; check if the village have a Dark Elixir Storage
		$sElixirCount = getResourcesMainScreen(696, 74)
		$sDarkCount = getResourcesMainScreen(728, 123)
		If $sElixirCount = 00000000 Then $sElixirCount = 12000000 ;Edited By SM MOD (When testing on private server due to unlimited resources it read value 00000000)
		If $sDarkCount = 000000 Then $sDarkCount = 2400000 ;Edited By SM MOD (When testing on private server due to unlimited resources it read value 000000)
		SetLog("Updating village values [E]: " & $sElixirCount & " [D]: " & $sDarkCount, $COLOR_SUCCESS)
	Else
		$sElixirCount = getResourcesMainScreen(701, 74)
		If $sElixirCount = 00000000 Then $sElixirCount = 12000000 ;Edited By SM MOD (When testing on private server due to unlimited resources it read value 00000000)
		SetLog("Updating village values [E]: " & $sElixirCount, $COLOR_SUCCESS)
	EndIf
	$iAvailElixir = Number($sElixirCount)
	$iAvailDark = Number($sDarkCount)



	;Click Laboratory
	BuildingClickP($g_aiLaboratoryPos, "#0197")
	If _Sleep($DELAYLABORATORY3) Then Return ; Wait for window to open

	; Find Research Button
	Local $offColors[4][3] = [[0x708CB0, 37, 34], [0x603818, 50, 43], [0xD5FC58, 61, 8], [0x000000, 82, 0]] ; 2nd pixel Blue blade, 3rd pixel brown handle, 4th pixel Green cross, 5th black button edge
	Local $ButtonPixel = _MultiPixelSearch(433, 565 + $g_iBottomOffsetY, 562, 619 + $g_iBottomOffsetY, 1, 1, Hex(0x000000, 6), $offColors, 30) ; Black pixel of button edge
	If IsArray($ButtonPixel) Then
		If $g_bDebugSetlog Then
			SetDebugLog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_DEBUG)
			SetDebugLog("#1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 37, $ButtonPixel[1] + 34, True) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 50, $ButtonPixel[1] + 43, True) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 61, $ButtonPixel[1] + 8, True), $COLOR_DEBUG)
		EndIf
		If $g_bDebugImageSave Then DebugImageSave("LabUpgrade")
		Click($ButtonPixel[0] + 40, $ButtonPixel[1] + 25, 1, 0, "#0198") ; Click Research Button
		If _Sleep($DELAYLABORATORY1) Then Return ; Wait for window to open
	Else
		SetLog("Trouble finding research button, try again...", $COLOR_WARNING)
		ClickP($aAway, 2, $DELAYLABORATORY4, "#0199")
		Return False
	EndIf

	; reset lab troop positions to default
	For $i = 1 To UBound($aiIconDefaultPOS) - 1
		$g_avLabTroops[$i][0] = $aiIconDefaultPOS[$i][0]
		$g_avLabTroops[$i][1] = $aiIconDefaultPOS[$i][1]
	Next

	; Lab window coor correction
	Local $aiCloseBtn = findButton("CloseWindow")
	If IsArray($aiCloseBtn) Then
		Local $iXMoved = $aiCloseBtn[0] - $aiCloseDefaultPOS[0]
		Local $iYMoved = $aiCloseBtn[1] - $aiCloseDefaultPOS[1]
		If $g_bDebugSetlog Then Setlog("Lab window off: (" & $iXMoved & ", " & $iYMoved & ")", $COLOR_DEBUG)
		If $iXMoved <> 0 Then
			For $i = 1 To UBound($aiIconDefaultPOS) - 1
				$g_avLabTroops[$i][0] = $aiIconDefaultPOS[$i][0] + $iXMoved
				If $g_bDebugSetlog Then Setlog("New icon X position of " & $g_avLabTroops[$i][3] & " : " & $g_avLabTroops[$i][0], $COLOR_DEBUG)
			Next
		EndIf
		If $iYMoved <> 0 Then
			For $i = 1 To UBound($aiIconDefaultPOS) - 1
				$g_avLabTroops[$i][1] = $aiIconDefaultPOS[$i][1] + $iYMoved
				If $g_bDebugSetlog Then Setlog("New icon Y position of " & $g_avLabTroops[$i][3] & " : " & $g_avLabTroops[$i][1], $COLOR_DEBUG)
			Next
		EndIf
	Else
		SetLog("Trouble finding lab close button, try again...", $COLOR_WARNING)
		ClickP($aAway, 2, $DELAYLABORATORY4, "#0199")
		Return False
	EndIf

	; First page
	If $g_bDebugSetlog Then LabTroopImages(1, 12)
	If $g_iFirstTimeLab = 0 Then ; Need to get upgrade value for troops on page 1, only do this on 1st cycle of function
		For $i = 1 To 12
			$aUpgradeValue[$i] = getLabUpgrdResourceRed($g_avLabTroops[$i][0] + 3, $g_avLabTroops[$i][1] + 73)
			If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " Red text upgrade value = " & $aUpgradeValue[$i], $COLOR_DEBUG)
			If $aUpgradeValue[$i] = "" Or Int($aUpgradeValue[$i]) < 49999 Then ; check if blank or below min value for any upgrade on page 1
				$aUpgradeValue[$i] = getLabUpgrdResourceWht($g_avLabTroops[$i][0] + 3, $g_avLabTroops[$i][1] + 73)
				If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " White text upgrade value = " & $aUpgradeValue[$i], $COLOR_DEBUG)
			EndIf
			If $aUpgradeValue[$i] = "" Or Int($aUpgradeValue[$i]) < 49999 Then ; check if blank or below min value for any upgrade on page 1
				If _ColorCheck(_GetPixelColor($g_avLabTroops[$i][0] + 76, $g_avLabTroops[$i][1] + 76, True), $sColorMaxLvl, 20) And _
						_ColorCheck(_GetPixelColor($g_avLabTroops[$i][0] + 76, $g_avLabTroops[$i][1] + 80, True), $sColorMaxLvl, 20) Then
					$aUpgradeValue[$i] = -1
					If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " Is Maxed already, now = " & $aUpgradeValue[$i], $COLOR_DEBUG)
				EndIf
			EndIf
			If Not $g_bRunState Then Return
		Next
		$g_iFirstTimeLab = 1
	EndIf

	; Second page
	If $g_avLabTroops[$g_iCmbLaboratory][2] >= 1 Then ; when troop located on page 2+ of lab window and Move to four icon squares
		ClickDrag(650, 439 + $g_iMidOffsetY, 290, 439 + $g_iMidOffsetY, 1000)
		If $g_avLabTroops[$g_iCmbLaboratory][2] = 1 Or $g_iFirstTimeLab < 2 Then ; page 2 position correction when stay on 2nd page or 1st cycle of function
			If _Sleep($DELAYLABORATORY5) Then Return ; Edited By Simbios Mod
			If Not ClickDragLab($aiIconDefaultPOS[14][0]) Then
				SetLog("Trouble finding 2nd page of lab, try again...", $COLOR_WARNING)
				ClickP($aAway, 2, $DELAYLABORATORY4, "#0199")
				Return False
			EndIf
		EndIf
		If _Sleep($DELAYLABORATORY5) Then Return ; Edited By Simbios Mod
		If $g_bDebugSetlog Then LabTroopImages(13, 20)
		If $g_iFirstTimeLab < 2 Then ; Need to get upgrade value for troops on page 2, only do this on 1st cycle of function
			For $i = 13 To 20
				$aUpgradeValue[$i] = getLabUpgrdResourceRed($g_avLabTroops[$i][0] + 3, $g_avLabTroops[$i][1] + 73)
				If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " Red text upgrade value = " & $aUpgradeValue[$i], $COLOR_DEBUG)
				If $aUpgradeValue[$i] = "" Or $aUpgradeValue[$i] < 9999 Then ; check if blank or below min value for any upgrade on page 2
					$aUpgradeValue[$i] = getLabUpgrdResourceWht($g_avLabTroops[$i][0] + 3, $g_avLabTroops[$i][1] + 73)
					If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " White text upgrade value = " & $aUpgradeValue[$i], $COLOR_DEBUG)
				EndIf
				If $aUpgradeValue[$i] = "" Or $aUpgradeValue[$i] < 9999 Then ; check if blank or below min value for any upgrade on page 2
					If _ColorCheck(_GetPixelColor($g_avLabTroops[$i][0] + 76, $g_avLabTroops[$i][1] + 76, True), $sColorMaxLvl, 20) And _
							_ColorCheck(_GetPixelColor($g_avLabTroops[$i][0] + 76, $g_avLabTroops[$i][1] + 80, True), $sColorMaxLvl, 20) Then
						$aUpgradeValue[$i] = -1
						If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " Is Maxed already, now = " & $aUpgradeValue[$i], $COLOR_DEBUG)
					EndIf
				EndIf
				If Not $g_bRunState Then Return
			Next
			$g_iFirstTimeLab += 2
		EndIf
	EndIf

	; Last page
	If $g_avLabTroops[$g_iCmbLaboratory][2] = 2 Then ; when troop located on last (next) page of lab window and Move to the page
		ClickDrag(650, 443 + $g_iMidOffsetY, 114, 443 + $g_iMidOffsetY, 1000)
		If _Sleep($DELAYLABORATORY5) Then Return
		If $g_bDebugSetlog Then LabTroopImages(21, 32)
		If $g_iFirstTimeLab < 4 Then ; Need to get upgrade value for troops on last page, only do this on 1st cycle of function
			For $i = 21 To 32
				$aUpgradeValue[$i] = getLabUpgrdResourceRed($g_avLabTroops[$i][0] + 3, $g_avLabTroops[$i][1] + 73)
				If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " Red text upgrade value = " & $aUpgradeValue[$i], $COLOR_DEBUG)
				If $aUpgradeValue[$i] = "" Or Int($aUpgradeValue[$i]) < 9999 Then ; check if blank or below min value for any upgrade on last page
					$aUpgradeValue[$i] = getLabUpgrdResourceWht($g_avLabTroops[$i][0] + 3, $g_avLabTroops[$i][1] + 73)
					If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " White text upgrade value = " & $aUpgradeValue[$i], $COLOR_DEBUG)
				EndIf
				If $aUpgradeValue[$i] = "" Or Int($aUpgradeValue[$i]) < 9999 Then ; check if blank or below min value for any upgrade on last page
					If _ColorCheck(_GetPixelColor($g_avLabTroops[$i][0] + 76, $g_avLabTroops[$i][1] + 76, True), $sColorMaxLvl, 20) And _
							_ColorCheck(_GetPixelColor($g_avLabTroops[$i][0] + 76, $g_avLabTroops[$i][1] + 80, True), $sColorMaxLvl, 20) Then
						$aUpgradeValue[$i] = -1
						If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$i][3] & " Is Maxed already, now = " & $aUpgradeValue[$i], $COLOR_DEBUG)
					EndIf
				EndIf
				If Not $g_bRunState Then Return
			Next
			$g_iFirstTimeLab += 4
		EndIf
	EndIf

	; Track Elixir cost for Wall Upgrade check
	Switch $g_iCmbLaboratory
		Case 1 To 19 ; regular elixir
			ContinueCase
		Case 31 To 32 ; regular elixir
			If $aUpgradeValue[$g_iCmbLaboratory] > 0 Then $g_iLaboratoryElixirCost = $aUpgradeValue[$g_iCmbLaboratory]
	EndSwitch

	; check for upgrade in process - look for green in finish upgrade with gems button
	If _ColorCheck(_GetPixelColor(625, 266 + $g_iMidOffsetY, True), Hex(0x6CB91D, 6), 20) Or _ColorCheck(_GetPixelColor(660, 266 + $g_iMidOffsetY, True), Hex(0x6CB91D, 6), 20) Then
		SetLog("Upgrade in progress, waiting for completion of other troops", $COLOR_INFO)
		If _Sleep($DELAYLABORATORY2) Then Return
		; upgrade in process and time not recorded?  Then update completion time!
		If $g_sLabUpgradeTime = "" Or $TimeDiff <= 0 Then
			$Result = getRemainTLaboratory(270, 257) ; Try to read white text showing actual time left for upgrade
			If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$g_iCmbLaboratory][3] & " OCR Remaining Lab Time = " & $Result, $COLOR_DEBUG)
			$aArray = StringSplit($Result, ' ', BitOR($STR_CHRSPLIT, $STR_NOCOUNT)) ;separate days, hours, minutes, seconds
			If IsArray($aArray) Then
				Local $iRemainingTimeMin = 0
				For $i = 0 To UBound($aArray) - 1 ; step through array and compute minutes remaining
					Local $sTime = ""
					Select
						Case StringInStr($aArray[$i], "d", $STR_NOCASESENSEBASIC) > 0
							$sTime = StringTrimRight($aArray[$i], 1) ; removing the "d"
							$iRemainingTimeMin += (Int($sTime) * 24 * 60) ; change days to minutes and add
						Case StringInStr($aArray[$i], "h", $STR_NOCASESENSEBASIC) > 0
							$sTime = StringTrimRight($aArray[$i], 1) ; removing the "h"
							$iRemainingTimeMin += (Int($sTime) * 60) ; change hours to minutes and add
						Case StringInStr($aArray[$i], "m", $STR_NOCASESENSEBASIC) > 0
							$sTime = StringTrimRight($aArray[$i], 1) ; removing the "m"
							$iRemainingTimeMin += Int($sTime) ; add minutes
						Case StringInStr($aArray[$i], "s", $STR_NOCASESENSEBASIC) > 0
							$sTime = StringTrimRight($aArray[$i], 1) ; removing the "s"
							$iRemainingTimeMin += Int($sTime) / 60 ; Add seconds
						Case Else
							SetLog("Remaining lab time OCR invalid:" & $aArray[$i], $COLOR_WARNING)
							ClickP($aAway, 2, $DELAYLABORATORY4, "#0328")
							Return False
					EndSelect
					If $g_bDebugSetlog Then SetDebugLog("Remain Lab Time: " & $aArray[$i] & ", Minutes= " & $iRemainingTimeMin, $COLOR_DEBUG)
				Next
				$g_sLabUpgradeTime = _DateAdd('n', Ceiling($iRemainingTimeMin), _NowCalc()) ; add the time required to NOW to finish the upgrade
				If @error Then _logErrorDateAdd(@error)
				SetLog("Updated Lab finishing time: " & $g_sLabUpgradeTime, $COLOR_SUCCESS)
				LabStatusGUIUpdate() ; Update GUI flag
			Else
				If $g_bDebugSetlog Then SetDebugLog("Invalid getRemainTLaboratory OCR", $COLOR_DEBUG)
			EndIf
		EndIf
		ClickP($aAway, 2, $DELAYLABORATORY4, "#0328")
		Return False
	EndIf

	; Upgrade max level already
	If $aUpgradeValue[$g_iCmbLaboratory] = -1 Then
		SetLog($g_avLabTroops[$g_iCmbLaboratory][3] & " already max level, select another troop", $COLOR_WARNING)
		ClickP($aAway, 2, $DELAYLABORATORY4, "#0353")
		;------------------ADDED By SM MOD - START------------------
		IniWrite($g_sProfileConfigPath, $g_iUpgradeLevel[$g_iCmbLaboratory - 1][0], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][1], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][2])
		Switch $g_iCmbLaboratory
			Case 1 To 13
				ContinueCase
			Case 24 To 30
				$g_aiTrainArmyTroopLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $g_iUpgradeLevel[$g_iCmbLaboratory - 1][2]
				LevUpDownTroop($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
			Case 14 To 23
				$g_aiTrainArmySpellLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $g_iUpgradeLevel[$g_iCmbLaboratory - 1][2]
				LevUpDownSpell($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
			Case 31 To 32
				$g_aiTrainArmySiegeMachineLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $g_iUpgradeLevel[$g_iCmbLaboratory - 1][2]
				LevUpDownSiege($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
		EndSwitch
		;------------------ADDED By SM MOD - END------------------
		Return False
	EndIf

	; Upgrade not available
	If $aUpgradeValue[$g_iCmbLaboratory] = 0 Then
		; Check if Lab upgrade required, Look for Gray pixel inside left border
		If _ColorCheck(_GetPixelColor($g_avLabTroops[$g_iCmbLaboratory][0], $g_avLabTroops[$g_iCmbLaboratory][1] + 20, True), $sColorLabUgReq, 25) = True Or _
				_ColorCheck(_GetPixelColor($g_avLabTroops[$g_iCmbLaboratory][0] + 93, $g_avLabTroops[$g_iCmbLaboratory][1] + 20, True), $sColorLabUgReq, 25) = True Then
			SetLog("Lab upgrade required for " & $g_avLabTroops[$g_iCmbLaboratory][3] & ", select another troop", $COLOR_WARNING)
			;------------------ADDED By SM MOD - START------------------
			If $g_bChkPrioritySystem = True Then
				IniWrite($g_sProfileConfigPath, $g_iUpgradeLevel[$g_iCmbLaboratory - 1][0], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][1], 0)
				Switch $g_iCmbLaboratory
					Case 1 To 13
						ContinueCase
					Case 24 To 30
						$g_aiTrainArmyTroopLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $iLabMax[$g_iCmbLaboratory - 1][$g_iLabLevel]
						LevUpDownTroop($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
					Case 14 To 23
						$g_aiTrainArmySpellLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $iLabMax[$g_iCmbLaboratory - 1][$g_iLabLevel]
						LevUpDownSpell($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
					Case 31 To 32
						$g_aiTrainArmySiegeMachineLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $iLabMax[$g_iCmbLaboratory - 1][$g_iLabLevel]
						LevUpDownSiege($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
				EndSwitch
			EndIf
			;------------------ADDED By SM MOD - END------------------
			If _Sleep($DELAYLABUPGRADE2) Then Return
			; Check if troop not unlocked, look for beige pixel in center just below top edge
		ElseIf _ColorCheck(_GetPixelColor($g_avLabTroops[$g_iCmbLaboratory][0] + 47, $g_avLabTroops[$g_iCmbLaboratory][1] + 1, True), $sColorNA, 20) = True Then
			SetLog($g_avLabTroops[$g_iCmbLaboratory][3] & " not unlocked yet, try later or select another troop", $COLOR_WARNING)
			;------------------ADDED By SM MOD - START------------------
			If $g_bChkPrioritySystem = True Then
				IniWrite($g_sProfileConfigPath, $g_iUpgradeLevel[$g_iCmbLaboratory - 1][0], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][1], 0)
				Switch $g_iCmbLaboratory
					Case 1 To 13
						ContinueCase
					Case 24 To 30
						$g_aiTrainArmyTroopLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = 0
						LevUpDownTroop($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
					Case 14 To 23
						$g_aiTrainArmySpellLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = 0
						LevUpDownSpell($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
					Case 31 To 32
						$g_aiTrainArmySiegeMachineLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = 0
						LevUpDownSiege($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
				EndSwitch
			EndIf
			;------------------ADDED By SM MOD - END------------------
			; OCR read error, reset read flag and quit
		Else
			SetLog($g_avLabTroops[$g_iCmbLaboratory][3] & " value read error, close bot and try again!", $COLOR_ERROR)
			$g_iFirstTimeLab = 0 ; reset value read flag in case user does not restart bot to clear the flag to read again
		EndIf
		ClickP($aAway, 2, $DELAYLABORATORY4, "#0354")
		Return False
	EndIf

	;------------------ADDED By SM MOD - START------------------
	; Auto correct the troop/spell/seige level in army tab Spot Check
	If $g_bChkPrioritySystem = True And $g_iLabUpgradeProgress = 0 And $g_iCmbLaboratory > 0 Then
		SetLog("Laboratory Priority Level Check in progress.", $COLOR_INFO)
		If $aUpgradeValue[$g_iCmbLaboratory] <> $g_iLabCost[$g_iCmbLaboratory - 1][$iLevel] Then
			$iLevel = 0
			While $aUpgradeValue[$g_iCmbLaboratory] <> $g_iLabCost[$g_iCmbLaboratory - 1][$iLevel]
				$iLevel += 1
				SetLog("Standby..." & $iLevel, $COLOR_INFO)
				If $aUpgradeValue[$g_iCmbLaboratory] = $g_iLabCost[$g_iCmbLaboratory - 1][$iLevel] Then
					ExitLoop
				ElseIf $iLevel = 10 Then
					$iLevel = 1
					ExitLoop
				EndIf
			WEnd
			IniWrite($g_sProfileConfigPath, $g_iUpgradeLevel[$g_iCmbLaboratory - 1][0], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][1], ($iLevel))
			Switch $g_iCmbLaboratory
				Case 1 To 13
					ContinueCase
				Case 24 To 30
					$g_aiTrainArmyTroopLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $iLevel
					LevUpDownTroop($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
				Case 14 To 23
					$g_aiTrainArmySpellLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $iLevel
					LevUpDownSpell($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
				Case 31 To 32
					$g_aiTrainArmySiegeMachineLevel[$g_iUpgradeLevel[$g_iCmbLaboratory - 1][3]] = $iLevel
					LevUpDownSiege($g_iUpgradeLevel[$g_iCmbLaboratory - 1][3], False)
			EndSwitch
			SetLog("Upgrade level adjusted. Exiting Upgrade.", $COLOR_ERROR)
			Return False
		ElseIf Int($aUpgradeValue[$g_iCmbLaboratory]) = Int($g_iLabCost[$g_iCmbLaboratory - 1][$iLevel]) Then
			SetLog("Laboratory Priority Level Check Verified.", $COLOR_SUCCESS)
		EndIf
	EndIf
	;------------------ADDED By SM MOD - END------------------

	; Try to upgrade - LabUpgrade(), check insufficient resource first
	;------------------EDITED By SM MOD - START------------------
	Switch $g_iCmbLaboratory
		Case 1 To 19 ; regular elixir
			ContinueCase
		Case 31 To 32
			If $g_iTownHallLevel <> "" And $g_iTownHallLevel > 0 And $g_iTownHallLevel < 13 Then ; ADDED By SM MOD
				If $aUpgradeValue[$g_iCmbLaboratory] >= $g_iLimitBreakGE[$g_iTownHallLevel - 1] - $g_iUpgradeMinElixir Then
					If $iAvailElixir < ($aUpgradeValue[$g_iCmbLaboratory]) Then
						SetLog("Insufficent Elixir for " & $g_avLabTroops[$g_iCmbLaboratory][3] & ", Lab requires: " & $aUpgradeValue[$g_iCmbLaboratory] & " available: " & $iAvailElixir, $COLOR_INFO)
						ClickP($aAway, 2, $DELAYLABORATORY4, "#0355")
						Return False
					EndIf
					If LabUpgrade() = True Then
						SetLog("Elixir used = " & $aUpgradeValue[$g_iCmbLaboratory], $COLOR_INFO)
						ClickP($aAway, 2, $DELAYLABORATORY4, "#0356")
						Return True
					EndIf
				ElseIf $aUpgradeValue[$g_iCmbLaboratory] < $g_iLimitBreakGE[$g_iTownHallLevel - 1] - $g_iUpgradeMinElixir Then
					If $iAvailElixir < ($aUpgradeValue[$g_iCmbLaboratory] + $g_iUpgradeMinElixir) Then
						SetLog("Insufficent Elixir for " & $g_avLabTroops[$g_iCmbLaboratory][3] & ", Lab requires: " & $aUpgradeValue[$g_iCmbLaboratory] & " + " & $g_iUpgradeMinElixir & " user reserve, available: " & $iAvailElixir, $COLOR_INFO)
						ClickP($aAway, 2, $DELAYLABORATORY4, "#0355")
						Return False
					EndIf
					If LabUpgrade() = True Then
						SetLog("Elixir used = " & $aUpgradeValue[$g_iCmbLaboratory], $COLOR_INFO)
						ClickP($aAway, 2, $DELAYLABORATORY4, "#0356")
						Return True
					EndIf
				EndIf
			Else
				Return False
				SetLog("TownHall Level Undefined, try resetting it's location.", $COLOR_ERROR) ; ADDED By SM MOD
			EndIf

		Case 20 To 30 ; Dark Elixir
			If $g_iTownHallLevel <> "" And $g_iTownHallLevel > 0 And $g_iTownHallLevel < 13 Then
				If $aUpgradeValue[$g_iCmbLaboratory] >= $g_iLimitBreakGE[$g_iTownHallLevel - 1] - $g_iUpgradeMinDark Then
					If $iAvailDark < ($aUpgradeValue[$g_iCmbLaboratory]) Then
						SetLog("Insufficent Elixir for " & $g_avLabTroops[$g_iCmbLaboratory][3] & ", Lab requires: " & $aUpgradeValue[$g_iCmbLaboratory] & " available: " & $iAvailDark, $COLOR_INFO)
						ClickP($aAway, 2, $DELAYLABORATORY4, "#0357")
						Return False
					EndIf
					If LabUpgrade() = True Then
						SetLog("Dark Elixir used = " & $aUpgradeValue[$g_iCmbLaboratory], $COLOR_INFO)
						ClickP($aAway, 2, $DELAYLABORATORY4, "#0358")
						Return True
					EndIf
				ElseIf $aUpgradeValue[$g_iCmbLaboratory] < $g_iLimitBreakGE[$g_iTownHallLevel - 1] - $g_iUpgradeMinDark Then
					If $iAvailDark < ($aUpgradeValue[$g_iCmbLaboratory] + $g_iUpgradeMinDark) Then
						SetLog("Insufficent Dark Elixir for " & $g_avLabTroops[$g_iCmbLaboratory][3] & ", Lab requires: " & $aUpgradeValue[$g_iCmbLaboratory] & " + " & $g_iUpgradeMinDark & " user reserve, available: " & $iAvailDark, $COLOR_INFO)
						ClickP($aAway, 2, $DELAYLABORATORY4, "#0357")
						Return False
					EndIf
					If LabUpgrade() = True Then
						SetLog("Dark Elixir used = " & $aUpgradeValue[$g_iCmbLaboratory], $COLOR_INFO)
						ClickP($aAway, 2, $DELAYLABORATORY4, "#0358")
						Return True
					EndIf
				EndIf
			Else
				Return False
				SetLog("TownHall Level Undefined, try resetting it's location.", $COLOR_ERROR)
			EndIf

		Case Else
			SetLog("Something went wrong with loot value on Lab upgrade on #" & $g_avLabTroops[$g_iCmbLaboratory][3], $COLOR_ERROR)
			Return False
	EndSwitch
	;------------------EDITED By SM MOD - END------------------

	ClickP($aAway, 2, $DELAYLABORATORY4, "#0359")
	Return False

EndFunc   ;==>Laboratory
;
Func LabUpgrade()
	Local $StartTime, $EndTime, $EndPeriod, $Result, $TimeAdd = 0

	Select
		Case _ColorCheck(_GetPixelColor($g_avLabTroops[$g_iCmbLaboratory][0] + 47, $g_avLabTroops[$g_iCmbLaboratory][1] + 1, True), $sColorNA, 20) = True
			; check for beige pixel in center just below edge for troop not unlocked
			SetLog($g_avLabTroops[$g_iCmbLaboratory][3] & " not unlocked yet, select another troop", $COLOR_WARNING)
			If _Sleep($DELAYLABUPGRADE2) Then Return

		Case _PixelSearch($g_avLabTroops[$g_iCmbLaboratory][0] + 67, $g_avLabTroops[$g_iCmbLaboratory][1] + 79, $g_avLabTroops[$g_iCmbLaboratory][0] + 69, $g_avLabTroops[$g_iCmbLaboratory][0] + 84, $sColorNoLoot, 20) <> 0
			; Check for Pink pixels last zero of loot value to see if enough loot is available.
			; this case should never be run if value check is working right!
			SetLog("Value check error and Not enough Loot to upgrade " & $g_avLabTroops[$g_iCmbLaboratory][3] & "...", $COLOR_ERROR)
			If _Sleep($DELAYLABUPGRADE2) Then Return

		Case _ColorCheck(_GetPixelColor($g_avLabTroops[$g_iCmbLaboratory][0] + 22, $g_avLabTroops[$g_iCmbLaboratory][1] + 60, True), Hex(0xFFC360, 6), 20) = True
			IniWrite($g_sProfileConfigPath, $g_iUpgradeLevel[$g_iCmbLaboratory - 1][0], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][1], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][2])
			; Look for Golden pixel inside level indicator for max troops
			SetLog($g_avLabTroops[$g_iCmbLaboratory][3] & " already max level, select another troop", $COLOR_ERROR)
			If _Sleep($DELAYLABUPGRADE2) Then Return

		Case _ColorCheck(_GetPixelColor($g_avLabTroops[$g_iCmbLaboratory][0] + 3, $g_avLabTroops[$g_iCmbLaboratory][1] + 19, True), Hex(0xB7B7B7, 6), 20) = True
			; Look for Gray pixel inside left border if Lab upgrade required or if we missed that upgrade is in process
			SetLog("Laboratory upgrade not available now for " & $g_avLabTroops[$g_iCmbLaboratory][3] & "...", $COLOR_ERROR)
			If _Sleep($DELAYLABUPGRADE2) Then Return

		Case Else
			; If none of other error conditions apply, begin upgrade process
			Click($g_avLabTroops[$g_iCmbLaboratory][0] + 40, $g_avLabTroops[$g_iCmbLaboratory][1] + 40, 1, 0, "#0200") ; Click Upgrade troop button
			If _Sleep($DELAYLABUPGRADE1) Then Return ; Wait for window to open
			If $g_bDebugImageSave Then DebugImageSave("LabUpgrade")

			; double check if maxed?
			If _ColorCheck(_GetPixelColor(258, 192, True), Hex(0xFF1919, 6), 20) And _ColorCheck(_GetPixelColor(272, 194, True), Hex(0xFF1919, 6), 20) Then
				IniWrite($g_sProfileConfigPath, $g_iUpgradeLevel[$g_iCmbLaboratory - 1][0], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][1], $g_iUpgradeLevel[$g_iCmbLaboratory - 1][2])
				SetLog($g_avLabTroops[$g_iCmbLaboratory][3] & " Previously maxxed, select another troop", $COLOR_ERROR) ; oops, we found the red warning message
				If _Sleep($DELAYLABUPGRADE2) Then Return
				ClickP($aAway, 2, $DELAYLABUPGRADE3, "#0201")
				Return False
			EndIf

			; double check enough elixir?
			If _PixelSearch($g_avLabTroops[$g_iCmbLaboratory][0] + 67, $g_avLabTroops[$g_iCmbLaboratory][1] + 79, $g_avLabTroops[$g_iCmbLaboratory][0] + 69, $g_avLabTroops[$g_iCmbLaboratory][0] + 84, $sColorNoLoot, 20) <> 0 Then ; Check for Red Zero = means not enough loot!
				SetLog("Missing Loot to upgrade " & $g_avLabTroops[$g_iCmbLaboratory][3] & " (secondary check after Upgrade Value read failed)", $COLOR_ERROR)
				If _Sleep($DELAYLABUPGRADE2) Then Return
				ClickP($aAway, 2, $DELAYLABUPGRADE3, "#0333")
				Return False
			EndIf

			; triple check for upgrade in process by gray upgrade button
			If _ColorCheck(_GetPixelColor(625, 250 + $g_iMidOffsetY, True), Hex(0x848484, 6), 20) And _ColorCheck(_GetPixelColor(660, 250 + $g_iMidOffsetY, True), Hex(0x848484, 6), 20) Then
				SetLog("Upgrade in progress, waiting for completion of other troops", $COLOR_WARNING)
				If _Sleep($DELAYLABORATORY2) Then Return
				ClickP($aAway, 2, $DELAYLABORATORY4, "#0000")
				Return False
			Else
				; get upgrade time from window
				$Result = getLabUpgradeTime(581, 497) ; Try to read white text showing time for upgrade
				Local $iLabFinishTime = ConvertOCRTime("Lab Time", $Result, False)
				SetLog($g_avLabTroops[$g_iCmbLaboratory][3] & " Upgrade OCR Time = " & $Result & ", $iLabFinishTime = " & $iLabFinishTime & " m", $COLOR_INFO)
				$StartTime = _NowCalc() ; what is date:time now
				If $g_bDebugSetlog Then SetDebugLog($g_avLabTroops[$g_iCmbLaboratory][3] & "Upgrade Started @ " & $StartTime, $COLOR_SUCCESS)
				If $iLabFinishTime > 0 Then
					$g_sLabUpgradeTime = _DateAdd('n', Ceiling($iLabFinishTime), $StartTime)
					SetLog($g_avLabTroops[$g_iCmbLaboratory][3] & "Upgrade Finishes @ " & $Result & " (" & $g_sLabUpgradeTime & ")", $COLOR_SUCCESS)

					Local $txtTip = GetTranslatedFileIni("MBR Func_Village_Upgrade", "BtnResetLabUpgradeTime_Info_01", "Visible Red button means that laboratory upgrade in process") & @CRLF & _
							GetTranslatedFileIni("MBR Func_Village_Upgrade", "BtnResetLabUpgradeTime_Info_02", "This will automatically disappear when near time for upgrade to be completed.") & @CRLF & _
							GetTranslatedFileIni("MBR Func_Village_Upgrade", "BtnResetLabUpgradeTime_Info_03", "If upgrade has been manually finished with gems before normal end time,") & @CRLF & _
							GetTranslatedFileIni("MBR Func_Village_Upgrade", "BtnResetLabUpgradeTime_Info_04", "Click red button to reset internal upgrade timer BEFORE STARTING NEW UPGRADE") & @CRLF & _
							GetTranslatedFileIni("MBR Func_Village_Upgrade", "BtnResetLabUpgradeTime_Info_05", "Caution - Unnecessary timer reset will force constant checks for lab status") & @CRLF & @CRLF & _
							GetTranslatedFileIni("MBR Func_Village_Upgrade", "BtnResetLabUpgradeTime_Info_06", "Troop Upgrade started") & ": " & $StartTime & ", " & _
							GetTranslatedFileIni("MBR Func_Village_Upgrade", "BtnResetLabUpgradeTime_Info_07", "Will begin to check completion at:") & " " & $g_sLabUpgradeTime & @CRLF & " "
					_GUICtrlSetTip($g_hBtnResetLabUpgradeTime, $txtTip)

					Click(660, 520 + $g_iMidOffsetY, 1, 0, "#0202") ; Everything is good - Click the upgrade button
					If _Sleep($DELAYLABUPGRADE1) Then Return
				Else
					SetLog("Error processing upgrade time required, try again!", $COLOR_WARNING)
					Return False
				EndIf

			EndIf

			If isGemOpen(True) = False Then ; check for gem window
				; check for green button to use gems to finish upgrade, checking if upgrade actually started
				If Not (_ColorCheck(_GetPixelColor(625, 218 + $g_iMidOffsetY, True), Hex(0x6fbd1f, 6), 15) Or _ColorCheck(_GetPixelColor(660, 218 + $g_iMidOffsetY, True), Hex(0x6fbd1f, 6), 15)) Then
					SetLog("Something went wrong with " & $g_avLabTroops[$g_iCmbLaboratory][3] & " Upgrade, try again.", $COLOR_ERROR)
					ClickP($aAway, 2, $DELAYLABUPGRADE3, "#0360")
					Return False
				EndIf

				PushMsg("TroopUpgrading") ; ADDED BY SM MOD

				If _Sleep($DELAYLABUPGRADE2) Then Return

				If $g_bChkPrioritySystem = False Then
					$g_bAutoLabUpgradeEnable = False ;reset enable lab upgrade flag
					GUICtrlSetState($g_hChkAutoLabUpgrades, $GUI_UNCHECKED) ; reset enable lab upgrade check box
				EndIf

				ClickP($aAway, 2, 0, "#0204")

				Return True
			Else
				SetLog("Oops, Gems required for " & $g_avLabTroops[$g_iCmbLaboratory][3] & " Upgrade, try again.", $COLOR_ERROR)
			EndIf
	EndSelect
	ClickP($aAway, 2, $DELAYLABUPGRADE3, "#0205")
	Return False

EndFunc   ;==>LabUpgrade

Func ClickDragLab($iXTroop) ; drag a page to exact or nearby target position and update coor if necessary
	Local $iCounter = 1
	Local $iDiff = CheckXPos($iXTroop)
	While $iDiff <> 0
		If $iDiff = 9999 Then ExitLoop
		ClickDrag(426, 439 + $g_iMidOffsetY, 426 + $iDiff, 439 + $g_iMidOffsetY, 1000)
		If _Sleep($DELAYLABORATORY2) Then Return False
		$iDiff = CheckXPos($iXTroop)
		$iCounter += 1
		If $iCounter = 5 Then ExitLoop
	WEnd
	If $iDiff = 0 Then
		Return True
	ElseIf Abs($iDiff) < 10 Then
		For $i = 13 To 20 ; update x
			$g_avLabTroops[$i][0] = $aiIconDefaultPOS[$i][0] - $iDiff
			If $g_bDebugSetlog Then Setlog("New icon X position of " & $g_avLabTroops[$i][3] & " : " & $g_avLabTroops[$i][0], $COLOR_DEBUG)
		Next
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>ClickDragLab

Func CheckXPos($iXTroop) ; return x diff between lightning spell border and target position $iXTroop or 9999 when not found
	Local $aCoor = [114, 362, 740, 575]
	Local $sDirectory = "lab-lspell-bundle"
	Local $sReturnProps = "objectpoints"
	Local $Result = ""
	Local $aPosXY[0]
	Local $iDiffBorder = 23

	If $g_bDebugImageSave Then DebugImageSave("CheckXPos")
	_CaptureRegion2($aCoor[0], $aCoor[1], $aCoor[2], $aCoor[3])

	$Result = findMultiple($sDirectory, "FV", "FV", 0, 0, 1, $sReturnProps, False)
	If IsArray($Result) Then
		$aPosXY = StringSplit(($Result[0])[0], ",", $STR_NOCOUNT) ; get x,y
		Local $iRBorder = Int(Number($aPosXY[0])) - $iDiffBorder
		Local $iABorder = $iRBorder + $aCoor[0]
		Local $iXDiff = $iXTroop - $iABorder
		If $g_bDebugSetlog Then
			Setlog("CheckXPos: " & $aPosXY[0] & " - " & $iDiffBorder & " = " & $iRBorder & " relative icon border", $COLOR_DEBUG)
			Setlog("CheckXPos: " & $iRBorder & " + " & $aCoor[0] & " = " & $iABorder & " absolute icon border", $COLOR_DEBUG)
			Setlog("CheckXPos: " & $iXTroop & " - " & $iABorder & " = " & $iXDiff & " differences to target icon border", $COLOR_DEBUG)
		EndIf
		Return $iXDiff
	Else
		If $g_bDebugSetlog Then SetLog("CheckXPos: detected X = NOT Found", $COLOR_DEBUG)
		Return 9999
	EndIf
EndFunc   ;==>CheckXPos

Func DebugIconSave($sTxtName = "Unknown", $iLeft = 0, $iTop = 0) ; Debug Code to save images before zapping for later review, time stamped to align with logfile!
	SetLog("Taking debug icon snapshot for later review", $COLOR_SUCCESS)
	Local $iIconLength = 94
	Local $Date = @MDAY & "_" & @MON & "_" & @YEAR
	Local $Time = @HOUR & "_" & @MIN & "_" & @SEC
	Local $sName = $g_sProfileTempDebugPath & "LabUpgrade\" & $sTxtName & "_" & $Date & "_" & $Time & ".png"
	DirCreate($g_sProfileTempDebugPath & "LabUpgrade\")
	ForceCaptureRegion()
	_CaptureRegion($iLeft, $iTop, $iLeft + $iIconLength, $iTop + $iIconLength)
	_GDIPlus_ImageSaveToFile($g_hBitmap, $sName)
	If @error Then SetLog("DebugIconSave failed to save LabUpgrade image: " & $sName, $COLOR_WARNING)
	If _Sleep($DELAYLABORATORY2) Then Return
EndFunc   ;==>DebugIconSave

Func LabTroopImages($iStart, $iEnd) ; Debug function to record pixel values for troops
	If $g_bDebugImageSave Then DebugImageSave("LabUpgrade")
	For $i = $iStart To $iEnd
		DebugIconSave($g_avLabTroops[$i][3], $g_avLabTroops[$i][0], $g_avLabTroops[$i][1])
		SetLog($g_avLabTroops[$i][3], $COLOR_WARNING)
		SetLog("_GetPixelColor(+47, +1): " & _GetPixelColor($g_avLabTroops[$i][0] + 47, $g_avLabTroops[$i][1] + 1, True) & ":D3D3CB =Not unlocked", $COLOR_DEBUG)
		SetLog("_GetPixelColor(+68, +79): " & _GetPixelColor($g_avLabTroops[$i][0] + 68, $g_avLabTroops[$i][1] + 79, True) & ":FD877E =No Loot1", $COLOR_DEBUG)
		SetLog("_GetPixelColor(+68, +82): " & _GetPixelColor($g_avLabTroops[$i][0] + 68, $g_avLabTroops[$i][1] + 84, True) & ":FD877E =No Loot2", $COLOR_DEBUG)
		SetLog("_GetPixelColor(+81, +82): " & _GetPixelColor($g_avLabTroops[$i][0] + 81, $g_avLabTroops[$i][1] + 82, True) & ":XXXXXX =Loot type", $COLOR_DEBUG)
		SetLog("_GetPixelColor(+76, +76): " & _GetPixelColor($g_avLabTroops[$i][0] + 76, $g_avLabTroops[$i][1] + 76, True) & ":FFFFFF =Max L", $COLOR_DEBUG)
		SetLog("_GetPixelColor(+76, +80): " & _GetPixelColor($g_avLabTroops[$i][0] + 76, $g_avLabTroops[$i][1] + 80, True) & ":FFFFFF =Max L", $COLOR_DEBUG)
		SetLog("_GetPixelColor(+0, +20): " & _GetPixelColor($g_avLabTroops[$i][0] + 0, $g_avLabTroops[$i][1] + 20, True) & ":838383 =Lab Upgrade", $COLOR_DEBUG)
		SetLog("_GetPixelColor(+93, +20): " & _GetPixelColor($g_avLabTroops[$i][0] + 93, $g_avLabTroops[$i][1] + 20, True) & ":838383 =Lab Upgrade", $COLOR_DEBUG)
		SetLog("_GetPixelColor(+8, +59): " & _GetPixelColor($g_avLabTroops[$i][0] + 23, $g_avLabTroops[$i][1] + 60, True) & ":FFC360 =Max troop", $COLOR_DEBUG)
	Next
EndFunc   ;==>LabTroopImages
;------------------CUSTOM LOGIC By SM MOD - START------------------
Func LabPriority()

	Local $iLabResults[32][4] = [ _
			[0, "Elixir", 1, 0], _
			[0, "Elixir", 2, 0], _
			[0, "Elixir", 3, 0], _
			[0, "Elixir", 4, 0], _
			[0, "Elixir", 5, 0], _
			[0, "Elixir", 6, 0], _
			[0, "Elixir", 7, 0], _
			[0, "Elixir", 8, 0], _
			[0, "Elixir", 9, 0], _
			[0, "Elixir", 10, 0], _
			[0, "Elixir", 11, 0], _
			[0, "Elixir", 12, 0], _
			[0, "Elixir", 13, 0], _
			[0, "Elixir", 14, 0], _
			[0, "Elixir", 15, 0], _
			[0, "Elixir", 16, 0], _
			[0, "Elixir", 17, 0], _
			[0, "Elixir", 18, 0], _
			[0, "Elixir", 19, 0], _
			[0, "Dark Elixir", 20, 0], _
			[0, "Dark Elixir", 21, 0], _
			[0, "Dark Elixir", 22, 0], _
			[0, "Dark Elixir", 23, 0], _
			[0, "Dark Elixir", 24, 0], _
			[0, "Dark Elixir", 25, 0], _
			[0, "Dark Elixir", 26, 0], _
			[0, "Dark Elixir", 27, 0], _
			[0, "Dark Elixir", 28, 0], _
			[0, "Dark Elixir", 29, 0], _
			[0, "Dark Elixir", 30, 0], _
			[0, "Elixir", 31, 0], _
			[0, "Elixir", 32, 0]]

	Local $iElixirCount = 0 ;21
	Local $iDElixirCount = 0 ;11
	Local $minElixerValue = ""
	Local $minDarkElixerValue = ""
	Local $minDynamicValue = ""

	If $g_bChkPrioritySystem = True Then
		$g_iMaxCount = 0
		SetLog("Lab Priority Check.", $COLOR_INFO)
		For $iz = 0 To 31
			If $g_iLabCost[$iz][IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)] = "Max" Or $g_iLabCost[$iz][IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)] = 0 Then
				$g_iMaxCount += 1
			EndIf
		Next
		Setlog("Max Troop/Spell/Seige Count: " & $g_iMaxCount, $COLOR_INFO)
		If $g_iMaxCount = 32 Then
			EnableGuiControls()
			$g_iCmbLaboratory = 0
			$g_bAutoLabUpgradeEnable = False
			_GUICtrlComboBox_SetCurSel($g_hCmbLaboratory, $g_iCmbLaboratory)
			DisableGuiControls()
			cmbLab()
			SetLog("Max Level Achieved", $COLOR_SUCCESS)
			Return
		EndIf
		For $iz = 0 To 31
			$iLabResults[$iz][0] = $g_iLabCost[$iz][IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)]
		Next
		For $iz = 0 To 31
			Switch $iLabResults[$iz][1]
				Case "Elixir"
					If $iLabResults[$iz][0] <> "Max" And $iLabResults[$iz][0] <> "0" Then
						$iLabResults[$iz][3] = ($iLabResults[$iz][0] / 12000000) * 100
					EndIf
				Case "Dark Elixir"
					If $iLabResults[$iz][0] <> "Max" And $iLabResults[$iz][0] <> "0" Then
						$iLabResults[$iz][3] = ($iLabResults[$iz][0] / 240000) * 100
					EndIf
			EndSwitch
		Next
		For $iz = 0 To 31 ;
			Switch $iLabResults[$iz][1]
				Case "Elixir"
					If $g_iLabCost[$iz][IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)] = "Max" Or $g_iLabCost[$iz][IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)] = 0 Then
						$iElixirCount += 1
					EndIf
				Case "Dark Elixir"
					If $g_iLabCost[$iz][IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)] = "Max" Or $g_iLabCost[$iz][IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)] = 0 Then
						$iDElixirCount += 1
					EndIf
			EndSwitch
		Next
		SetLog("Max Elixir Count: " & $iElixirCount & " Max Dark Count: " & $iDElixirCount, $COLOR_INFO)
		For $iz = 0 To 31
			If ($iLabMax[$iz][$g_iLabLevel] < IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)) Then
				Switch $iz
					Case 0 To 12
						ContinueCase
					Case 23 To 29
						$g_aiTrainArmyTroopLevel[$g_iUpgradeLevel[$iz][3]] = 1
						LevUpDownTroop($g_iUpgradeLevel[$iz][3], False)
					Case 13 To 24
						$g_aiTrainArmySpellLevel[$g_iUpgradeLevel[$iz][3]] = 1
						LevUpDownSpell($g_iUpgradeLevel[$iz][3], False)
					Case 30 To 31
						$g_aiTrainArmySiegeMachineLevel[$g_iUpgradeLevel[$iz][3]] = 1
						LevUpDownSiege($g_iUpgradeLevel[$iz][3], False)
				EndSwitch
			EndIf
		Next
		For $iz = 0 To 31
			If $iLabResults[$iz][0] <> "Max" And $iLabResults[$iz][0] <> "0" And ($iLabMax[$iz][$g_iLabLevel] > IniRead($g_sProfileConfigPath, $g_iUpgradeLevel[$iz][0], $g_iUpgradeLevel[$iz][1], 0)) Then
				If $minElixerValue = "" And $iLabResults[$iz][1] = "Elixir" Then
					$minElixerValue = _ArrayExtract($iLabResults, $iz, $iz)
				EndIf

				If $minDarkElixerValue = "" And $iLabResults[$iz][1] = "Dark Elixir" Then
					$minDarkElixerValue = _ArrayExtract($iLabResults, $iz, $iz)
				EndIf

				If $minDynamicValue = "" Then
					$minDynamicValue = _ArrayExtract($iLabResults, $iz, $iz)
				EndIf

				If ($minElixerValue <> "" And $iLabResults[$iz][0] < $minElixerValue[0][0] And $iLabResults[$iz][1] = "Elixir") Then
					$minElixerValue = _ArrayExtract($iLabResults, $iz, $iz)
				EndIf

				If ($minDarkElixerValue <> "" And $iLabResults[$iz][0] < $minDarkElixerValue[0][0] And $iLabResults[$iz][1] = "Dark Elixir") Then
					$minDarkElixerValue = _ArrayExtract($iLabResults, $iz, $iz)
				EndIf

				If ($minDynamicValue <> "" And $iLabResults[$iz][3] < $minDynamicValue[0][3]) Then
					$minDynamicValue = _ArrayExtract($iLabResults, $iz, $iz)
				EndIf
			EndIf
		Next
		If $minElixerValue = "" And $minDarkElixerValue = "" Then
			EnableGuiControls()
			$g_iCmbLaboratory = 0
			_GUICtrlComboBox_SetCurSel($g_hCmbLaboratory, $g_iCmbLaboratory)
			DisableGuiControls()
			cmbLab()
			SetLog("No upgrades available. Upgrade your Lab", $COLOR_INFO)
			Return
		EndIf
		If $g_iCmbPrioritySystem = 0 Then
			If ($minElixerValue <> "") And $iElixirCount < 21 Then
				EnableGuiControls()
				$g_iCmbLaboratory = Number($minElixerValue[0][2])
				_GUICtrlComboBox_SetCurSel($g_hCmbLaboratory, $g_iCmbLaboratory)
				DisableGuiControls()
				cmbLab()
				SetLog("Elixir Upgrade set.", $COLOR_INFO)
				Return
			ElseIf ($minDarkElixerValue <> "") And $iDElixirCount < 11 Then
				EnableGuiControls()
				$g_iCmbLaboratory = Number($minDarkElixerValue[0][2])
				_GUICtrlComboBox_SetCurSel($g_hCmbLaboratory, $g_iCmbLaboratory)
				DisableGuiControls()
				cmbLab()
				SetLog("Elixir complete, Dark Elixir Upgrade set.", $COLOR_INFO)
				Return
			EndIf
		ElseIf $g_iCmbPrioritySystem = 1 Then
			If ($minDarkElixerValue <> "") And $iDElixirCount < 11 Then
				EnableGuiControls()
				$g_iCmbLaboratory = Number($minDarkElixerValue[0][2])
				_GUICtrlComboBox_SetCurSel($g_hCmbLaboratory, $g_iCmbLaboratory)
				DisableGuiControls()
				cmbLab()
				SetLog("Dark Elixir Upgrade set.", $COLOR_INFO)
				Return
			ElseIf ($minElixerValue <> "") And $iElixirCount < 21 Then
				EnableGuiControls()
				$g_iCmbLaboratory = Number($minElixerValue[0][2])
				_GUICtrlComboBox_SetCurSel($g_hCmbLaboratory, $g_iCmbLaboratory)
				DisableGuiControls()
				cmbLab()
				SetLog("Dark Elixir complete, Elixir Upgrade set.", $COLOR_INFO)
				Return
			EndIf
		ElseIf $g_iCmbPrioritySystem = 2 Then
			If ($minDynamicValue <> "") Then
				EnableGuiControls()
				$g_iCmbLaboratory = Number($minDynamicValue[0][2])
				_GUICtrlComboBox_SetCurSel($g_hCmbLaboratory, $g_iCmbLaboratory)
				DisableGuiControls()
				cmbLab()
				SetLog("Dynamic Upgrade set.", $COLOR_INFO)
				Return
			EndIf
		EndIf
	ElseIf $g_bChkPrioritySystem = False Then
		Return
	EndIf
EndFunc   ;==>LabPriority
;------------------CUSTOM LOGIC By SM MOD - END------------------
