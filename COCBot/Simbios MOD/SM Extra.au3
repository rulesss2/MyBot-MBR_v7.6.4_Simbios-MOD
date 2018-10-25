; #FUNCTION# ====================================================================================================================
; Name ..........: SM MOD Extra
; Description ...:
; Syntax ........:
; Parameters ....: ---
; Return values .: ---
; Author ........: RK
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================


Func _StringRemoveBlanksFromSplit(ByRef $strMsg) ;Remove empty string pipes from string e.g |Test||Hey all| becomes Test|Hey all (Using in Chat to avoid empty messages)
	Local $strArray = StringSplit($strMsg, "|", 2)
	$strMsg = ""

	For $i = 0 To (UBound($strArray) - 1)
		If $strArray[$i] <> "" Then
			$strMsg = $strMsg & $strArray[$i] & "|"
		EndIf
	Next
	If ($strMsg <> "") Then $strMsg = StringTrimRight($strMsg, 1) ;Remove last extra pipe from string

EndFunc   ;==>_StringRemoveBlanksFromSplit


Func ConvertOCRLongTime($WhereRead, $ToConvert, $bSetLog = True) ; Convert longer time with days - hours - minutes - seconds

	Local $iRemainTimer = 0, $aResult, $iDay = 0, $iHour = 0, $iMinute = 0, $iSecond = 0

	If $ToConvert <> "" Then
		If StringInStr($ToConvert, "d") > 1 Then
			$aResult = StringSplit($ToConvert, "d", $STR_NOCOUNT)
			; $aResult[0] will be the Day and the $aResult[1] will be the rest
			$iDay = Number($aResult[0])
			$ToConvert = $aResult[1]
		EndIf
		If StringInStr($ToConvert, "h") > 1 Then
			$aResult = StringSplit($ToConvert, "h", $STR_NOCOUNT)
			$iHour = Number($aResult[0])
			$ToConvert = $aResult[1]
		EndIf
		If StringInStr($ToConvert, "m") > 1 Then
			$aResult = StringSplit($ToConvert, "m", $STR_NOCOUNT)
			$iMinute = Number($aResult[0])
			$ToConvert = $aResult[1]
		EndIf
		If StringInStr($ToConvert, "s") > 1 Then
			$aResult = StringSplit($ToConvert, "s", $STR_NOCOUNT)
			$iSecond = Number($aResult[0])
		EndIf

		$iRemainTimer = Round($iDay * 24 * 60 + $iHour * 60 + $iMinute + $iSecond / 60, 2)
		If $iRemainTimer = 0 And $g_bDebugSetlog Then SetLog($WhereRead & ": Bad OCR string", $COLOR_ERROR)

		If $bSetLog Then SetLog($WhereRead & " time: " & StringFormat("%.2f", $iRemainTimer) & " min", $COLOR_INFO)

	Else
		If $g_bDebugSetlog Then SetLog("Can not read remaining time for " & $WhereRead, $COLOR_ERROR)
	EndIf
	Return $iRemainTimer
EndFunc   ;==>ConvertOCRLongTime

Func AttackPriority()
	If Not $g_bChkAttackPriority Then Return
	If $g_iCommandStop <> 0 And $g_iCommandStop <> 3 Then
		If $g_aiCurrentLoot[$eLootTrophy] > 4200 Then Return
		TrainSystem()
		If Not $g_bRunState Then Return
		SetDebugLog("From Attack Priority Are you ready? " & String($g_bIsFullArmywithHeroesAndSpells))
		If $g_bIsFullArmywithHeroesAndSpells Then
			BoostAllWithMagicSpell()
			OneGemBoost()
			If (isInsideDiamond($g_aiTownHallPos) = False) Then
				BotDetectFirstTime()
			EndIf
			If $g_iCommandStop <> 0 And $g_iCommandStop <> 3 Then
				Setlog("Due To Attack Priority Checked Before any other routine let's attack!!", $COLOR_INFO)
				If Not $g_bRunState Then Return
				AttackMain()
				$g_bSkipFirstZoomout = False
				If $g_bOutOfGold = True Then
					SetLog("From Attack Priority Switching to Halt Attack, Stay Online/Collect mode ...", $COLOR_ERROR)
					$g_bFirstStart = True
					Return
				EndIf
				If _Sleep($DELAYRUNBOT1) Then Return
			EndIf
		EndIf
	EndIf
EndFunc   ;==>AttackPriority

Func BalanceRecDon($bSetLog = False) ; This function is to make sure that the request of cc troops we are doing validates Recive/Donate ratio Used in RequestCC.au3

	If Not $g_bCanRequestCC Then Return False ; Will disable request of cc troops
	If Not $g_bUseCCBalanced Then Return True ; Will enable the request of cc troops

	Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)

	If Not $g_abRequestCCHours[$hour[0]] Then Return False ; Will disable the request of cc troops


	If $g_bUseCCBalanced Then
		If $g_iTroopsDonated = 0 And $g_iTroopsReceived = 0 Then ProfileReport()
		If Number($g_iTroopsDonated) <> 0 Then
			If Number(Number($g_iTroopsReceived) / Number($g_iTroopsDonated)) >= (Number($g_iCCReceived) / Number($g_iCCDonated)) Then
				;Stop Request
				If $bSetLog Then SetLog("Skipping Request CC troops because Donate/Recieve Ratio is wrong", $COLOR_INFO)
				Return False
			Else
				; Continue
				Return True
			EndIf
		EndIf
	Else
		Return True
	EndIf
EndFunc   ;==>BalanceRecDon

; @Author Fahid.Mahmood
; This Function Returns  ; coordinates of each image found - eg: $Array[0] = [X1, Y1] ; $Array[1] = [X2, Y2]
;
Func FindImageInPlaces($sImageName, $sImageTile, $place, $bForceCaptureRegion = True, $AndroidTag = Default)
	;creates a reduced capture of the place area a finds the image in that area
	;returns string with X,Y of ACTUALL FULL SCREEN coordinates or Empty if not found
	If StringRight($sImageTile, 1) <> "*" Then $sImageTile = $sImageTile & "*" ;ADD * End of image e.g Arch* to check if multiimage (Arch_100_92.xml,Arch_100_91.xml) exist in directory will check both
	If $g_bDebugSetlog Then SetDebugLog("FindImageInPlaces : > " & $sImageName & " - " & $sImageTile & " - " & $place, $COLOR_INFO)
	Local $returnvalue = ""
	Local $aPlaces = GetRectArray($place)
	Local $sImageArea = GetDiamondFromRect($aPlaces)

	If $bForceCaptureRegion = True Then
		$sImageArea = "FV"
		_CaptureRegion2(Number($aPlaces[0]), Number($aPlaces[1]), Number($aPlaces[2]), Number($aPlaces[3]))
	EndIf
	Local $coords = findImage($sImageName, $sImageTile, $sImageArea, 10, False, $AndroidTag) ; reduce capture full image
	If $g_bDebugSetlog Then SetDebugLog("FindImageInPlaces : < $aPlaces : " & Number($aPlaces[0]) & "," & Number($aPlaces[1]) & "," & Number($aPlaces[2]) & "," & Number($aPlaces[3]) & " : " & $sImageName & " Found in $coords :" & $coords, $COLOR_INFO)
	If $coords = "" Then
		If $g_bDebugSetlog Then SetDebugLog("FindImageInPlaces : $sImageArea : " & $sImageArea & " : " & $sImageName & " NOT Found", $COLOR_INFO)
		Return ""
	EndIf
	If $bForceCaptureRegion Then
		Local $CoordsInArray = StringSplit($coords, "|", $STR_NOCOUNT) ; 2|357,33|709,33
		For $i = 1 To UBound($CoordsInArray) - 1 ;Start From 1 Index as 0 index has points value
			Local $aCoords = decodeSingleCoord($CoordsInArray[$i])
			$returnvalue &= Number($aCoords[0]) + Number($aPlaces[0]) & "," & Number($aCoords[1]) + Number($aPlaces[1]) & "|"
		Next
	Else
		Local $CoordsInArray = StringSplit($coords, "|", $STR_NOCOUNT) ; 2|357,33|709,33
		For $i = 1 To UBound($CoordsInArray) - 1 ;Start From 1 Index as 0 index has points value
			Local $aCoords = decodeSingleCoord($CoordsInArray[$i])
			$returnvalue &= Number($aCoords[0]) & "," & Number($aCoords[1]) & "|"
		Next
	EndIf
	If StringRight($returnvalue, 1) = "|" Then $returnvalue = StringLeft($returnvalue, (StringLen($returnvalue) - 1))
	If $g_bDebugSetlog Then SetDebugLog("FindImageInPlaces : < " & $sImageName & " Found in " & $returnvalue, $COLOR_INFO)
	Local $CoordsInArray = StringSplit($returnvalue, "|", $STR_NOCOUNT)
	Return $CoordsInArray
EndFunc   ;==>FindImageInPlaces

;------------------Use Event Troops & Spells - ADDED By SM MOD - START----------------
Func chkUseEventTroops()
	$g_bUseEventTroops = (GUICtrlRead($g_hChkUseEventTroops) = $GUI_CHECKED ? True : False)
EndFunc
;------------------Use Event Troops & Spells - ADDED By SM MOD - END------------------