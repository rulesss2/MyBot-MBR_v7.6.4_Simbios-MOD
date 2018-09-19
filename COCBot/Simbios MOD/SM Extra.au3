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


Func _StringRemoveBlanksFromSplit(ByRef $strMsg);Remove empty string pipes from string e.g |Test||Hey all| becomes Test|Hey all (Using in Chat to avoid empty messages)
	Local $strArray = StringSplit($strMsg, "|", 2)
	$strMsg = ""

	For $i = 0 To (UBound($strArray) - 1)
		If $strArray[$i] <> "" Then
			$strMsg = $strMsg & $strArray[$i] & "|"
		EndIf
	Next
	If ($strMsg <> "") Then $strMsg = StringTrimRight($strMsg, 1) ;Remove last extra pipe from string

EndFunc   ;==>_StringRemoveBlanks


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
	If $g_iCommandStop <> 0 And $g_iCommandStop <> 3 Then
		If $g_aiCurrentLoot[$eLootTrophy] > 4200 Then Return
		TrainSystem()
		TNRQT(False,True,True,True)
		If Not $g_bRunState Then Return
		SetDebugLog("Are you ready? " & String($g_bIsFullArmywithHeroesAndSpells))
		If $g_bIsFullArmywithHeroesAndSpells Then
			BoostAllWithMagicSpell()
			OneGemBoost()
			If (isInsideDiamond($g_aiTownHallPos) = False) Then
				BotDetectFirstTime()
			EndIf
			If $g_iCommandStop <> 0 And $g_iCommandStop <> 3 Then
				Setlog("Before any other routine let's attack!!", $COLOR_INFO)
				If Not $g_bRunState Then Return
				AttackMain()
				$g_bSkipFirstZoomout = False
				If $g_bOutOfGold = True Then
					SetLog("Switching to Halt Attack, Stay Online/Collect mode ...", $COLOR_ERROR)
					$g_bFirstStart = True
					Return
				EndIf
				If _Sleep($DELAYRUNBOT1) Then Return
			EndIf
		EndIf
	EndIf
EndFunc   ;==>AttackPriority

Func BalanceRecRec($bSetLog = False)

	If Not $g_bCanRequestCC Then Return False ; Will disable donation
	If Not $g_bUseCCBalanced Then Return True ; will enable the donation

	Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)

	If Not $g_abRequestCCHours[$hour[0]] Then Return False ; will disable the donation


	If $g_bUseCCBalanced Then
		If $g_iTroopsDonated = 0 And $g_iTroopsReceived = 0 Then ProfileReport()
		If Number($g_iTroopsDonated) <> 0 Then
			If Number(Number($g_iTroopsReceived) / Number($g_iTroopsDonated)) >= (Number($g_iCCReceived) / Number($g_iCCDonated)) Then
				;Stop Donating
				If $bSetLog Then SetLog("Skipping Receive because Donate/Recieve Ratio is wrong", $COLOR_INFO)
				Return False
			Else
				; Continue
				Return True
			EndIf
		EndIf
	Else
		Return True
	EndIf
EndFunc   ;==>BalanceRecRec
