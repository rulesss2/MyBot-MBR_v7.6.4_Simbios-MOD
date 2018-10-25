; #FUNCTION# ====================================================================================================================
; Name ..........: SM CheckBuilderStatus
; Description ...: This file is used for reading builder time
; Author ........: Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Builder Status - Sm MOD
Func getBuilderTime()
	Local $iBuilderTime = -1
	Static $sBuilderTimeLastCheck = ""
	Static $asBuilderTimeLastCheck[8] = ["", "", "", "", "", "", "", ""]

	If ProfileSwitchAccountEnabled() Then
		$g_sNextBuilderReadyTime = $g_asNextBuilderReadyTime[$g_iCurAccount]
		$sBuilderTimeLastCheck = $asBuilderTimeLastCheck[$g_iCurAccount]
	EndIf

	If _DateIsValid($sBuilderTimeLastCheck) And _DateIsValid($g_sNextBuilderReadyTime) And Not $g_bFirstStart Then
		Local $iTimeFromLastCheck = Int(_DateDiff('n', $sBuilderTimeLastCheck, _NowCalc())) ; elapse time in minutes
		Local $iTimeTillNextBuilderReady = Int(_DateDiff('n', _NowCalc(), $g_sNextBuilderReadyTime)) ; builder time in minutes

		SetDebugLog("Next Builder will be ready in " & $iTimeTillNextBuilderReady & "m, (" & $g_sNextBuilderReadyTime & ")")
		SetDebugLog("It has been " & $iTimeFromLastCheck & "m since last check (" & $sBuilderTimeLastCheck & ")")

		If $iTimeFromLastCheck <= 6 * 60 And $iTimeTillNextBuilderReady > 0 Then
			SetDebugLog("Next time to check: " & _Min(360 - Number($iTimeFromLastCheck), Number($iTimeTillNextBuilderReady)) & "m")
			Return
		EndIf
	EndIf

	If $g_iFreeBuilderCount >= $g_iTotalBuilderCount Then Return

	SetLog("Getting builder time", $COLOR_INFO)

	If IsMainPage() Then Click(293, 32) ; click builder's nose for poping out information
	If _Sleep(1000) Then Return

	Local $sBuilderTime = QuickMIS("OCR", @ScriptDir & "\imgxml\BuilderTime", 335, 102, 335 + 124, 102 + 14, True)
	If $sBuilderTime <> "none" Then
		$iBuilderTime = ConvertOCRLongTime("Builder Time", $sBuilderTime, False)
		SetDebugLog("$sResult QuickMIS OCR: " & $sBuilderTime & " (" & Round($iBuilderTime,2) & " minutes)")
	EndIf

	If $iBuilderTime > 0 Then
		$g_sNextBuilderReadyTime = _DateAdd("n", $iBuilderTime, _NowCalc())
		$sBuilderTimeLastCheck = _NowCalc()
		SetLog("Builder will be free in : "&$sBuilderTime&" at "&$g_sNextBuilderReadyTime, $COLOR_SUCCESS)
	Else
		$g_sNextBuilderReadyTime = ""
		$sBuilderTimeLastCheck = ""
	EndIf

	If ProfileSwitchAccountEnabled() Then
		$g_asNextBuilderReadyTime[$g_iCurAccount] = $g_sNextBuilderReadyTime
		$asBuilderTimeLastCheck[$g_iCurAccount] = $sBuilderTimeLastCheck
	EndIf

	ClickP($aAway, 2, 0, "#0000") ;Click Away
EndFunc   ;==>getBuilderTime