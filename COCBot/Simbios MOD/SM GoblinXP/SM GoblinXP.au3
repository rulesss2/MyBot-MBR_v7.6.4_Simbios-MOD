; #FUNCTION# ====================================================================================================================
; Name ..........: SuperXP
; Description ...: This file is all related to Gaining XP by Attacking to Goblin Picninc Signle player
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: MR.ViPER (2016-11-5)
; Modified ......: MR.ViPER (2016-11-13), MR.ViPER (2017-1-1)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SetStatsGoblinsXP()

	If Not ProfileSwitchAccountEnabled() Then Return
	Static $FirstRun = True
	Static $StatsAccounts[9][4]

	If $FirstRun Then
		For $i = 0 To UBound($StatsAccounts) - 1
			$StatsAccounts[$i][0] = 0
			$StatsAccounts[$i][1] = 0
			$StatsAccounts[$i][2] = 0
			$StatsAccounts[$i][3] = 0
		Next
	EndIf

	Static $CurrentAccountGoblinsXP = -1

	If $g_bDebugSX Then
		SetDebugLog("$CurrentAccountGoblinsXP:" & $CurrentAccountGoblinsXP, $COLOR_DEBUG)
		SetDebugLog("$g_iCurAccount:" & $g_iCurAccount, $COLOR_DEBUG)
		SetDebugLog("$g_iStartXP:" & $g_iStartXP, $COLOR_DEBUG)
	EndIf

	If $g_iCurAccount = $CurrentAccountGoblinsXP Then
		If $g_bDebugSX Then SetDebugLog("'Same' account Update Values!", $COLOR_DEBUG)
		; Store the values from this account
		$StatsAccounts[$g_iCurAccount][0] = $g_iStartXP
		$StatsAccounts[$g_iCurAccount][1] = $g_iCurrentXP
		$StatsAccounts[$g_iCurAccount][2] = $g_iGainedXP
		$StatsAccounts[$g_iCurAccount][3] = $g_iGainedXPHour
	Else
		If $g_bDebugSX Then SetDebugLog("'Other' account Update Values!", $COLOR_DEBUG)
		; Restore the previous values from this account
		$g_iStartXP = $StatsAccounts[$g_iCurAccount][0]
		$g_iCurrentXP = $StatsAccounts[$g_iCurAccount][1]
		$g_iGainedXP = $StatsAccounts[$g_iCurAccount][2]
		$g_iGainedXPHour = $StatsAccounts[$g_iCurAccount][3]
		; Update the account number
		$CurrentAccountGoblinsXP = $g_iCurAccount
	EndIf
	$FirstRun = False

EndFunc   ;==>SetStatsGoblinsXP

Func ResetGoblinsXP()
	$g_iStartXP = 0
	$g_iCurrentXP = 0
	$g_iGainedXP = 0
	$g_iGainedXPHour = 0
	$g_iTxtXPRunTime = 0
	GUICtrlSetData($g_hLblXPatStart, $g_iStartXP)
	GUICtrlSetData($g_hLblXPCurrent, $g_iCurrentXP)
	GUICtrlSetData($g_hLblXPSXWon, $g_iGainedXP)
	GUICtrlSetData($g_hLblXPSXWonHour, $g_iGainedXPHour)
	GUICtrlSetData($g_hLblXPRunTime, "00:00:00")

EndFunc   ;==>ResetGoblinsXP

Func DisableSX()
	GUICtrlSetState($g_hChkEnableSuperXP, $GUI_UNCHECKED)
	$g_bEnableSuperXP = False

	For $i = $g_hGrpSuperXP To $g_hLblXPSXWonHour
		GUICtrlSetState($i, $GUI_DISABLE)
	Next

	GUICtrlSetState($g_hLblLOCKEDSX, BitOR($GUI_SHOW, $GUI_ENABLE))
EndFunc   ;==>DisableSX

Func SXSetXP($toSet = "")
	SetStatsGoblinsXP()
	If $toSet = "S" Or $toSet = "" Then GUICtrlSetData($g_hLblXPatStart, $g_iStartXP)
	If $toSet = "C" Or $toSet = "" Then GUICtrlSetData($g_hLblXPCurrent, $g_iCurrentXP)
	If $toSet = "W" Or $toSet = "" Then GUICtrlSetData($g_hLblXPSXWon, $g_iGainedXP)
	$g_iGainedXPHour = Round($g_iGainedXP / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)
	If $toSet = "H" Or $toSet = "" Then GUICtrlSetData($g_hLblXPSXWonHour, $g_iGainedXPHour)
	If $g_iTxtXPRunTime <> 0 And _DateIsValid($g_iTxtXPRunTime) Then
		Local $hour = 0, $min = 0, $sec = 0
		Local $sDateTimeDiffOfXPRunTimeInSec = _DateDiff("s", $g_iTxtXPRunTime, _NowCalc())
		_TicksToTime($sDateTimeDiffOfXPRunTimeInSec * 1000, $hour, $min, $sec)
		GUICtrlSetData($g_hLblXPRunTime, StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
	EndIf


EndFunc   ;==>SXSetXP

Func chkEnableSuperXP()
	$g_bEnableSuperXP = True
	If GUICtrlRead($g_hChkEnableSuperXP) = $GUI_CHECKED Then

		GUICtrlSetState($rbSXTraining, $GUI_ENABLE)
		GUICtrlSetState($rbSXIAttacking, $GUI_ENABLE)
		GUICtrlSetState($g_hChkSkipZoomOutXP, $GUI_ENABLE)
		GUICtrlSetState($g_hChkFastGoblinXP, $GUI_ENABLE)
		GUICtrlSetState($g_hChkSkipDragToEndXP, $GUI_ENABLE)
		GUICtrlSetState($g_hChkSXBK, $GUI_ENABLE)
		GUICtrlSetState($g_hChkSXAQ, $GUI_ENABLE)
		GUICtrlSetState($g_hChkSXGW, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtMaxXPtoGain, $GUI_ENABLE)
	Else
		$g_bEnableSuperXP = False

		GUICtrlSetState($rbSXTraining, $GUI_DISABLE)
		GUICtrlSetState($rbSXIAttacking, $GUI_DISABLE)
		GUICtrlSetState($g_hChkSkipZoomOutXP, $GUI_DISABLE)
		GUICtrlSetState($g_hChkFastGoblinXP, $GUI_DISABLE)
		GUICtrlSetState($g_hChkSkipDragToEndXP, $GUI_DISABLE)
		GUICtrlSetState($g_hChkSXBK, $GUI_DISABLE)
		GUICtrlSetState($g_hChkSXAQ, $GUI_DISABLE)
		GUICtrlSetState($g_hChkSXGW, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtMaxXPtoGain, $GUI_DISABLE)
	EndIf

EndFunc   ;==>chkEnableSuperXP

Func chkEnableSuperXP2()
	$g_bEnableSuperXP = (GUICtrlRead($g_hChkEnableSuperXP) = $GUI_CHECKED)
	$g_bSkipZoomOutXP = (GUICtrlRead($g_hChkSkipZoomOutXP) = $GUI_CHECKED)
	$g_bFastGoblinXP = (GUICtrlRead($g_hChkFastGoblinXP) = $GUI_CHECKED)
	$g_bSkipDragToEndXP = (GUICtrlRead($g_hChkSkipDragToEndXP) = $GUI_CHECKED)
	$g_irbSXTraining = GUICtrlRead($rbSXTraining) = $GUI_CHECKED ? 1 : 2
	$g_bSXBK = (GUICtrlRead($g_hChkSXBK) = $GUI_CHECKED) ? $eHeroKing : $eHeroNone
	$g_bSXAQ = (GUICtrlRead($g_hChkSXAQ) = $GUI_CHECKED) ? $eHeroQueen : $eHeroNone
	$g_bSXGW = (GUICtrlRead($g_hChkSXGW) = $GUI_CHECKED) ? $eHeroWarden : $eHeroNone
	$g_iTxtMaxXPtoGain = Int(GUICtrlRead($g_hTxtMaxXPtoGain))
	chkEnableSuperXP()
EndFunc   ;==>chkEnableSuperXP2

Func MainSuperXPHandler()
	If Not $g_bEnableSuperXP Then Return
	If $g_bDebugSetlog Or $g_bDebugSX Then SetDebugLog("Begin MainSuperXPHandler, $g_irbSXTraining=" & $g_irbSXTraining & ", $IsFullArmywithHeroesAndSpells=" & $g_bIsFullArmywithHeroesAndSpells, $COLOR_DEBUG)
	If $g_irbSXTraining = 1 And $g_bIsFullArmywithHeroesAndSpells = True Then Return ; If Gain while Training Enabled but Army is Full Then Return
	$g_iTxtXPRunTime = _NowCalc()
	If $g_iGainedXP >= $g_iTxtMaxXPtoGain Then
		SetLog("You have Max XP to Gain GoblinXP", $COLOR_DEBUG)
		If $g_bDebugSX Then SetDebugLog("$g_iGainedXP = " & $g_iGainedXP & "|$g_iTxtMaxXPtoGain = " & $g_iTxtMaxXPtoGain, $COLOR_DEBUG)
		$g_bEnableSuperXP = False
		GUICtrlSetState($g_hChkEnableSuperXP, $GUI_UNCHECKED)
		Return ; If Gain XP More Than Max XP to Gain Then Exit/Return
	EndIf

	If Not WaitForMain() Then
		SetLog("Cannot get in Main Screen!! Exiting SuperXP", $COLOR_RED)
		Return False
	EndIf

	$g_aiCurrentLoot[$eLootTrophy] = getTrophyMainScreen($aTrophies[0], $aTrophies[1]) ; get OCR to read current Village Trophies
	If $g_bDebugSetlog Then SetDebugLog("Current Trophy Count: " & $g_aiCurrentLoot, $COLOR_DEBUG) ;Debug
	If Number($g_aiCurrentLoot) > Number($g_iDropTrophyMax) Then Return

	Local $aHeroResult = getArmyHeroCount(True, True)
	If $aHeroResult = @error And @error > 0 Then SetLog("Error while getting hero count, #" & @error, $COLOR_DEBUG)
	If Not WaitForMain() Then
		SetLog("Cannot get in Main Screen!! Exiting SuperXP", $COLOR_RED)
		Return False
	EndIf

	$g_canGainXP = ($g_iHeroAvailable <> $eHeroNone And (IIf($g_bSXBK = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroKing) = $eHeroKing) Or IIf($g_bSXAQ = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroQueen) = $eHeroQueen) Or IIf($g_bSXGW = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroWarden) = $eHeroWarden) And IIf($g_irbSXTraining = 1, $g_bIsFullArmywithHeroesAndSpells = False, True) And Number($g_iGainedXP) < Number($g_iTxtMaxXPtoGain)))

	If $g_bDebugSX Then SetDebugLog("$g_iHeroAvailable = " & $g_iHeroAvailable)
	If $g_bDebugSX Then SetDebugLog("BK: " & $g_bSXBK & ", AQ: " & $g_bSXAQ & ", GW: " & $g_bSXGW)
	If $g_bDebugSX Then SetDebugLog("$canGainXP = " & $g_canGainXP & @CRLF & "1: " & String(IIf($g_bSXBK = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroKing) = $eHeroKing)) & ", 2: " & _
			String(IIf($g_bSXAQ = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroQueen) = $eHeroQueen) & "|" & BitAND($g_iHeroAvailable, $eHeroQueen)) & ", 3: " & _
			String(IIf($g_bSXGW = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroWarden) = $eHeroWarden) & "|" & BitAND($g_iHeroAvailable, $eHeroWarden)) & ", 4: " & ($g_iHeroAvailable <> $eHeroNone) & _
			", 5: " & String(IIf($g_irbSXTraining = 1, $g_bIsFullArmywithHeroesAndSpells = False, True)) & ", 6: " & String(Number($g_iGainedXP) < Number($g_iTxtMaxXPtoGain)))

	If Not $g_canGainXP Then Return

	; Check if Start XP is not grabbed YET
	If $g_iStartXP = 0 Or $g_iStartXP = "" Then
		$g_iStartXP = GetCurXP()
		SXSetXP("S")
	EndIf

	; For SwitchAccounts loops
	Local $CurrentXPgain = 0

	; Okay everything is Good, Attack Goblin Picnic
	While $g_canGainXP
		If Not WaitForMain() Then
			SetLog("Cannot get in Main Screen!! Exiting SuperXP", $COLOR_RED)
			Return False
		EndIf
		If $g_iGainedXP >= $g_iTxtMaxXPtoGain And Not $g_bFastGoblinXP Then
			$g_canGainXP = False
			SetLog("You have Max XP to Gain GoblinXP", $COLOR_DEBUG)
			If $g_bDebugSX Then SetDebugLog("$g_iGainedXP = " & $g_iGainedXP & "|$g_iTxtMaxXPtoGain = " & $g_iTxtMaxXPtoGain, $COLOR_DEBUG)
			$g_bEnableSuperXP = False
			GUICtrlSetState($g_hChkEnableSuperXP, $GUI_UNCHECKED)
			ExitLoop ; If Gain XP More Than Max XP to Gain Then Exit/Return
		EndIf
		SetLog("Attacking to Goblin Picnic - GoblinXP", $COLOR_BLUE)
		If Not $g_bRunState Then Return
		If Not OpenGoblinPicnic() Then
			SafeReturnSX()
			Return False
		EndIf
		If Not $g_bRunState Then Return
		Local $rAttackSuperXP = AttackSuperXP()
		If $rAttackSuperXP Then
			If Not $g_bRunState Then Return
			WaitToFinishSuperXP()
		EndIf
		If Not $g_bRunState Then Return
		SetLog("Attack Finished - GoblinXP", $COLOR_GREEN)
		If $rAttackSuperXP Then AttackFinishedSX()
		If Not $g_canGainXP Then ExitLoop
		$CurrentXPgain += 5

		If Not SkipDonateNearFullTroops(False, $aHeroResult) And BalanceDonRec(False) Then
			DonateCC(True)
		EndIf

		If Not $g_bSkipZoomOutXP Then
			checkMainScreen(False)
			If IsMainPage() Then Zoomout()
		EndIf

		If $g_irbSXTraining = 1 Then CheckForFullArmy()
		$g_canGainXP = ($g_iHeroAvailable <> $eHeroNone And (IIf($g_bSXBK = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroKing) = $eHeroKing) Or IIf($g_bSXAQ = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroQueen) = $eHeroQueen) Or IIf($g_bSXGW = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroWarden) = $eHeroWarden) And IIf($g_irbSXTraining = 1, $g_bIsFullArmywithHeroesAndSpells = False, True) And $g_bEnableSuperXP = True And Number($g_iGainedXP) < Number($g_iTxtMaxXPtoGain)))

		If ProfileSwitchAccountEnabled() And $g_canGainXP And $CurrentXPgain >= 50 And Not $g_bFastGoblinXP Then
			SetLog("Switch Account is enable let's check it", $COLOR_GREEN)
			ExitLoop
		EndIf

		If $g_bDebugSX Then SetDebugLog("$g_iHeroAvailable = " & $g_iHeroAvailable)
		If $g_bDebugSX Then SetDebugLog("BK: " & $g_bSXBK & ", AQ: " & $g_bSXAQ & ", GW: " & $g_bSXGW)
		If $g_bDebugSX Then SetDebugLog("While|$g_canGainXP = " & $g_canGainXP & @CRLF & "1: " & String(IIf($g_bSXBK = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroKing) = $eHeroKing)) & ", 2: " & _
				String(IIf($g_bSXAQ = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroQueen) = $eHeroQueen)) & ", 3: " & _
				String(IIf($g_bSXGW = $eHeroNone, False, BitAND($g_iHeroAvailable, $eHeroWarden) = $eHeroWarden)) & ", 4: " & ($g_iHeroAvailable <> $eHeroNone) & _
				", 5: " & String(IIf($g_irbSXTraining = 1, $g_bIsFullArmywithHeroesAndSpells = False, True)) & ", 6: " & String($g_bEnableSuperXP = True) & ", 7: " & String(Number($g_iGainedXP) < Number($g_iTxtMaxXPtoGain)))
	WEnd
EndFunc   ;==>MainSuperXPHandler

Func CheckForFullArmy()
	If $g_bDebugSX Then SetDebugLog("SX|CheckForFullArmy", $COLOR_PURPLE)

	; ********** This will check ALL , Troops , Spells, Heroes, CC etc etc  **************
	CheckIfArmyIsReady()

	$g_bCanRequestCC = _ColorCheck(_GetPixelColor($aRequestTroopsAO[0], $aRequestTroopsAO[1], True), Hex($aRequestTroopsAO[2], 6), $aRequestTroopsAO[5])

	; $g_bCanRequestCC was updated on previous Function getArmyCCStatus()
	If $g_bCanRequestCC Then
		; If Use CC Balanced : check the ratio
		If $g_bUseCCBalanced Then
			If Number($g_iTroopsDonated) / Number($g_iTroopsReceived) >= Number($g_iCCDonated) / Number($g_iCCReceived) Then
				RequestCC()
			EndIf
		Else
			RequestCC()
		EndIf
	EndIf

	;Test for Train/Donate Only and Fullarmy
	If ($g_iCommandStop = 3 Or $g_iCommandStop = 0) And $g_bFullArmy Then
		SetLog("You are in halt attack mode and your Army is prepared!", $COLOR_DEBUG) ;Debug
		If $g_bFirstStart Then $g_bFirstStart = False
		Return
	EndIf

	If $g_bDebugSX Then SetDebugLog("$g_bIsFullArmywithHeroesAndSpells: " & $g_bIsFullArmywithHeroesAndSpells)
	If $g_bDebugSX Then SetDebugLog("1 Pixel : " & _GetPixelColor(391, 126, True))
	If $g_bDebugSX Then SetDebugLog("2 Pixel : " & _GetPixelColor(587, 126, True))

	If Not $g_bIsFullArmywithHeroesAndSpells And _
			((Not $g_bFullArmy And _ColorCheck(_GetPixelColor(391, 126, True), Hex(0x605C4C, 6), 15)) Or _
			(Not $g_bFullArmySpells And _ColorCheck(_GetPixelColor(587, 126, True), Hex(0x605C4D, 6), 15))) Then ; if Full army was false and nothing was in 'Train' and 'Brew' Queue then check for train

		If $g_bDebugSX Then SetDebugLog("SX|CFFA TrainSystem Condi. #1")
		TrainSystem()
	ElseIf $g_bIsFullArmywithHeroesAndSpells And $g_bEnableSuperXP And $g_irbSXTraining = 1 Then ; Train Troops Before Attack
		If $g_bDebugSX Then SetDebugLog("SX|CFFA TrainSystem Condi. #2")
		TrainSystem()
	EndIf

	;ClickP($aAway, 2, 0, "#0346") ;Click Away
	If $g_bDebugSX Then SetDebugLog("SX|CheckForFullArmy Finished", $COLOR_PURPLE)
EndFunc   ;==>CheckForFullArmy

Func SafeReturnSX()
	If $g_bDebugSX Then SetDebugLog("SX|SafeReturn", $COLOR_PURPLE)
	Local $bObstacleResult = checkObstacles(False)
	If $g_bDebugSetLog Then SetDebugLog("CheckObstacles Result = " & $bObstacleResult, $COLOR_DEBUG)

	If (Not $bObstacleResult And $g_bMinorObstacle) Then
		$g_bMinorObstacle = False
	ElseIf (Not $bObstacleResult And Not $g_bMinorObstacle) Then
		RestartAndroidCoC() ; Need to try to restart CoC
	Else
		$g_bRestart = True
	EndIf
	$g_canGainXP = False
	If IsMainPage() Then Return True
	Local $rExit = False
	If IsInAttackSuperXP() Then
		$rExit = ReturnHomeSuperXP()
	ElseIf IsInSPPage() Then
		$rExit = ExitSPPage()
	EndIf
	If $g_bDebugSX Then SetDebugLog("SX|SafeReturn=" & $rExit)
	Return $rExit
EndFunc   ;==>SafeReturnSX

Func ExitSPPage()
	If $g_bDebugSX Then SetDebugLog("SX|ExitSPPage", $COLOR_PURPLE)
	Click(822, 32, 1, 0, "#0152")
	Local $Counter = 0
	While Not (IsMainPage())
		If _Sleep(50) Then Return False
		$Counter += 1
		If $Counter >= 200 Then ExitLoop
	WEnd
	If $Counter >= 200 Then
		SetLog("Cannot Exit Single Player Page", $COLOR_RED)
		Return False
	EndIf
	If $g_bDebugSX Then SetDebugLog("SX|ExitSPPage Finished", $COLOR_PURPLE)
	Return True
EndFunc   ;==>ExitSPPage

Func AttackFinishedSX()
	If $g_bDebugSX Then SetDebugLog("SX|AttackFinished", $COLOR_PURPLE)
	$g_iCurrentXP = GetCurXP("Current")
	$g_iGainedXP += 5
	SXSetXP()
	$g_ActivatedHeroes[0] = False
	$g_ActivatedHeroes[1] = False
	$g_ActivatedHeroes[2] = False
	If $g_bDebugSX Then SetDebugLog("SX|AttackFinished Finished", $COLOR_PURPLE)
EndFunc   ;==>AttackFinishedSX

Func GetCurXP($returnVal = "Current")
	If $g_bFastGoblinXP Then Return
	;Return getVillageExp(55, 20)
	If $g_bDebugSX Then SetDebugLog("SX|GetCurXP", $COLOR_PURPLE)
	Local $ToReturn = "0#0"

	Click(135, 30, 1)

	If _Sleep(2000) Then Return

	Local $XPOCRResult = getCurrentXP(80, 60)

	If $g_bDebugSX Then SetDebugLog("SX|GetCurXP $XPOCRResult: " & $XPOCRResult, $COLOR_PURPLE)

	ClickP($aAway, 1, 0, "#0346") ; Click Away To Close XP Stats

	If $returnVal = "" Then
		$ToReturn = $XPOCRResult
	ElseIf StringInStr($returnVal, "Cur") And StringInStr($XPOCRResult, "#") Then
		$ToReturn = StringSplit($XPOCRResult, "#", 2)[0]
	ElseIf StringInStr($returnVal, "Tot") And StringInStr($XPOCRResult, "#") Then
		$ToReturn = StringSplit($XPOCRResult, "#", 2)[1]
	Else
		$ToReturn = $XPOCRResult
	EndIf

	If $g_bDebugSX Then SetDebugLog("SX|GetCurXP Finished", $COLOR_PURPLE)

	Return $ToReturn

EndFunc   ;==>GetCurXP

Func TestSuperXP()
	Local $oRunState = $g_bRunState
	$g_bRunState = True

	OpenGoblinPicnic()

	$g_bRunState = $oRunState
EndFunc   ;==>TestSuperXP

Func WaitToFinishSuperXP()
	If $g_bDebugSX Then SetDebugLog("SX|WaitToFinishSuperXP", $COLOR_PURPLE)
	Local $BdTimer = TimerInit()
	While 1
		If CheckEarnedStars($g_minStarsToEnd) = True Then ExitLoop
		If _Sleep(70) Then ExitLoop
		If Not $g_bRunState Then ExitLoop
		If IsInAttackSuperXP() = False Then ExitLoop
		ActivateHeroesByDelay($BdTimer)
		If TimerDiff($BdTimer) >= 120000 Then ; If Battle Started 2 Minutes ago, Then Return
			If $g_bDebugSX Then SetDebugLog("SX|WaitToFinishSuperXP TimeOut", $COLOR_RED)
			SafeReturnSX()
			ExitLoop
		EndIf
	WEnd
	If $g_bDebugSX Then SetDebugLog("SX|WaitToFinishSuperXP Finished", $COLOR_PURPLE)
	Return True
EndFunc   ;==>WaitToFinishSuperXP

Func ActivateHeroesByDelay($hBdTimer)
	Local $QueenDelay = $g_BdGoblinPicnic[0]
	If StringInStr($QueenDelay, "-") > 0 Then $QueenDelay = Random(Number(StringSplit($QueenDelay, "-", 2)[0]), Number(StringSplit($QueenDelay, "-", 2)[1]), 1)

	Local $WardenDelay = $g_BdGoblinPicnic[1]
	If StringInStr($WardenDelay, "-") > 0 Then $WardenDelay = Random(Number(StringSplit($WardenDelay, "-", 2)[0]), Number(StringSplit($WardenDelay, "-", 2)[1]), 1)

	Local $KingDelay = $g_BdGoblinPicnic[2]
	If StringInStr($KingDelay, "-") > 0 Then $KingDelay = Random(Number(StringSplit($KingDelay, "-", 2)[0]), Number(StringSplit($KingDelay, "-", 2)[1]), 1)

	Local $tDiff = TimerDiff($hBdTimer)
	If $tDiff >= $QueenDelay And $QueenDelay <> 0 And $g_ActivatedHeroes[0] = False And $g_iQueenSlot <> -1 And $g_bSXAQ <> $eHeroNone Then
		If $g_bDebugSX Then SetDebugLog("SX|Activating Queen Ability After " & Round($tDiff, 3) & "/" & $QueenDelay & " ms(s)")
		SelectDropTroop($g_iQueenSlot)
		$g_ActivatedHeroes[0] = True
	EndIf
	If $tDiff >= $WardenDelay And $WardenDelay <> 0 And $g_ActivatedHeroes[1] = False And $g_iWardenSlot <> -1 And $g_bSXGW <> $eHeroNone Then
		If $g_bDebugSX Then SetDebugLog("SX|Activating Warden Ability After " & Round($tDiff, 3) & "/" & $WardenDelay & " ms(s)")
		SelectDropTroop($g_iWardenSlot)
		$g_ActivatedHeroes[1] = True
	EndIf
	If $tDiff >= $KingDelay And $KingDelay <> 0 And $g_ActivatedHeroes[2] = False And $g_iKingSlot <> -1 And $g_bSXBK <> $eHeroNone Then
		If $g_bDebugSX Then SetDebugLog("SX|Activating King Ability After " & Round($tDiff, 3) & "/" & $KingDelay & " ms(s)")
		SelectDropTroop($g_iKingSlot)
		$g_ActivatedHeroes[2] = True
	EndIf
EndFunc   ;==>ActivateHeroesByDelay

Func IsInAttackSuperXP()
	If $g_bDebugSX Then SetDebugLog("SX|IsInAttackSuperXP", $COLOR_PURPLE)
	If _ColorCheck(_GetPixelColor(60, 576, True), Hex(0x000000, 6), 20) Then Return True
	If $g_bDebugSX Then SetDebugLog("SX|IsInAttackSuperXP=FALSE")
	Return False
EndFunc   ;==>IsInAttackSuperXP

Func IsInSPPage()
	If $g_bDebugSX Then SetDebugLog("SX|IsInSPPage", $COLOR_PURPLE)
	Local $rColCheck = _ColorCheck(_GetPixelColor(316, 34, True), Hex(0xFFFFFF, 6), 20)
	If $g_bDebugSX Then SetDebugLog("SX|IsInSPPage=" & $rColCheck)
	Return $rColCheck
EndFunc   ;==>IsInSPPage

Func AttackSuperXP()
	If $g_bDebugSX Then SetDebugLog("SX|AttackSuperXP", $COLOR_PURPLE)
	If WaitForNoClouds() = False Then
		If $g_bDebugSX Then SetDebugLog("SX|ASX|Wait For Clouds = False")
		$g_bIsClientSyncError = False
		Return False
	EndIf
	PrepareSuperXPAttack()
	If CheckAvailableHeroes() = False Then
		SetLog("No heroes available to attack with", $COLOR_ORANGE)
		ReturnHomeSuperXP()
		Return False
	EndIf
	DropAQSuperXP($g_BdGoblinPicnic[0] = 0)
	If CheckEarnedStars($g_minStarsToEnd) = True Then Return True
	DropGWSuperXP($g_BdGoblinPicnic[1] = 0)
	If CheckEarnedStars($g_minStarsToEnd) = True Then Return True
	DropBKSuperXP($g_BdGoblinPicnic[2] = 0)
	If $g_bDebugSX Then SetDebugLog("SX|AttackSuperXP Finished", $COLOR_PURPLE)
	Return True
EndFunc   ;==>AttackSuperXP

Func CheckAvailableHeroes()
	$g_canGainXP = ((IIf($g_bSXBK = $eHeroNone, False, $g_iKingSlot <> -1) Or IIf($g_bSXAQ = $eHeroNone, False, $g_iQueenSlot <> -1) Or IIf($g_bSXGW = $eHeroNone, False, $g_iWardenSlot <> -1)) And IIf($g_irbSXTraining = 1, $g_bIsFullArmywithHeroesAndSpells = False, True))
	If $g_bDebugSX Then SetDebugLog("SX|CheckAvailableHeroes=" & $g_canGainXP)
	Return $g_canGainXP
EndFunc   ;==>CheckAvailableHeroes

Func DropAQSuperXP($bActivateASAP = True)
	If $g_iQueenSlot <> -1 And $g_bSXAQ <> $eHeroNone Then
		SetLog("Deploying Queen", $COLOR_BLUE)
		Click(GetXPosOfArmySlot($g_iQueenSlot, 68), 595 + $g_ibottomOffsetY, 1, 0, "#0000") ;Select Queen
		If _Sleep($DELAYDROPSuperXP1) Then Return False
		If CheckEarnedStars($g_minStarsToEnd) = True Then Return True
		ClickP(GetDropPointSuperXP(1), 1, 0, "#0000") ;Drop Queen
		If _Sleep($DELAYDROPSuperXP3) Then Return False
		If $bActivateASAP = True Then
			If IsAttackPage() Then
				SelectDropTroop($g_iQueenSlot) ;If Queen was not activated: Boost Queen
				$g_ActivatedHeroes[0] = True
			EndIf
		EndIf
		If _Sleep($DELAYDROPSuperXP3) Then Return False
	EndIf
EndFunc   ;==>DropAQSuperXP

Func DropGWSuperXP($bActivateASAP = True)
	If $g_iWardenSlot <> -1 And $g_bSXGW <> $eHeroNone Then
		SetLog("Deploying Warden", $COLOR_BLUE)
		Click(GetXPosOfArmySlot($g_iWardenSlot, 68), 595 + $g_ibottomOffsetY, 1, 0, "#0179") ;Select Warden
		If _Sleep($DELAYDROPSuperXP1) Then Return False
		If CheckEarnedStars($g_minStarsToEnd) = True Then Return True
		ClickP(GetDropPointSuperXP(2), 1, 0, "#0180") ;Drop Warden
		If _Sleep($DELAYDROPSuperXP3) Then Return False
		If $bActivateASAP = True Then
			If IsAttackPage() Then
				SelectDropTroop($g_iWardenSlot) ;If Warden was not activated: Boost Warden
				$g_ActivatedHeroes[1] = True
			EndIf
		EndIf
		If _Sleep($DELAYDROPSuperXP3) Then Return False
	EndIf
EndFunc   ;==>DropGWSuperXP

Func DropBKSuperXP($bActivateASAP = True)
	If $g_iKingSlot <> -1 And $g_bSXBK <> $eHeroNone Then
		SetLog("Deploying King", $COLOR_BLUE)
		Click(GetXPosOfArmySlot($g_iKingSlot, 68), 595 + $g_ibottomOffsetY, 1, 0, "#0177") ;Select King
		If _Sleep($DELAYDROPSuperXP1) Then Return False
		If CheckEarnedStars($g_minStarsToEnd) = True Then Return True
		ClickP(GetDropPointSuperXP(3), 1, 0, "#0178") ;Drop King
		If _Sleep($DELAYDROPSuperXP3) Then Return False
		If $bActivateASAP = True Then
			If IsAttackPage() Then
				SelectDropTroop($g_iKingSlot) ;If King was not activated: Boost King
				$g_ActivatedHeroes[2] = True
			EndIf
		EndIf
		If _Sleep($DELAYDROPSuperXP3) Then Return False
	EndIf
EndFunc   ;==>DropBKSuperXP

Func GetDropPointSuperXP($iHero)
	; Local variables
	Local $ToReturn[2] = [-1, -1]
	Local $Hero = $iHero - 1
	Local $rDpGoblinPicnic[4] = [0, 0, 0, 0]
	; Just in case
	If $iHero = 0 Or $iHero > 3 Then $Hero = 0
	; Populatre with correct Globals
	$rDpGoblinPicnic[0] = $g_DpGoblinPicnic[$Hero][0]
	$rDpGoblinPicnic[1] = $g_DpGoblinPicnic[$Hero][1]
	$rDpGoblinPicnic[2] = $g_DpGoblinPicnic[$Hero][2]
	$rDpGoblinPicnic[3] = $g_DpGoblinPicnic[$Hero][3]
	;random
	$ToReturn[0] = Random($rDpGoblinPicnic[0] - $rDpGoblinPicnic[2], $rDpGoblinPicnic[0] + $rDpGoblinPicnic[2], 1)
	$ToReturn[1] = Random($rDpGoblinPicnic[1] - $rDpGoblinPicnic[3], $rDpGoblinPicnic[1] + $rDpGoblinPicnic[3], 1)

	Return $ToReturn
EndFunc   ;==>GetDropPointSuperXP

Func PrepareSuperXPAttack()
	If $g_bDebugSX Then SetDebugLog("SX|PrepareSuperXPAttack", $COLOR_PURPLE)
	Local $troopsnumber = 0
	If _Sleep($DELAYPREPAREATTACK1) Then Return
	_CaptureRegion2(0, 571 + $g_ibottomOffsetY, 859, 671 + $g_ibottomOffsetY)
	Local $Plural = 0
	Local $result = AttackBarCheck()
	If $g_bDebugSetlog Then SetDebugLog("DLL Troopsbar list: " & $result, $COLOR_DEBUG) ;Debug
	Local $aTroopDataList = StringSplit($result, "|")
	Local $aTemp[22][3] ; Slot11+
	If $result <> "" Then
		; example : 0#0#92|1#1#108|2#2#8|22#3#1|20#4#1|21#5#1|26#5#0|23#6#1|24#7#2|25#8#1|29#10#1
		; [0] = Troop Enum Cross Reference [1] = Slot position [2] = Quantities
		For $i = 1 To $aTroopDataList[0]
			Local $troopData = StringSplit($aTroopDataList[$i], "#", $STR_NOCOUNT)
			$aTemp[Number($troopData[1])][0] = $troopData[0]
			$aTemp[Number($troopData[1])][1] = Number($troopData[2])
			$aTemp[Number($troopData[1])][2] = Number($troopData[1])
		Next
	EndIf
	For $i = 0 To UBound($aTemp) - 1
		If $aTemp[$i][0] = "" And $aTemp[$i][1] = "" Then
			$g_avAttackTroops[$i][0] = -1
			$g_avAttackTroops[$i][1] = 0
		Else
			Local $troopKind = $aTemp[$i][0]
			If $troopKind < $eKing Then
				$g_avAttackTroops[$i][0] = $aTemp[$i][0]
				$g_avAttackTroops[$i][1] = $aTemp[$i][1]
				$troopKind = $aTemp[$i][1]
				$troopsnumber += $aTemp[$i][1]

			Else ;king, queen, warden and spells
				$g_avAttackTroops[$i][0] = $troopKind
				$troopsnumber += 1
				$g_avAttackTroops[$i][0] = $aTemp[$i][0]
				$troopKind = $aTemp[$i][1]
				$troopsnumber += 1
			EndIf
			$Plural = 0
			If $aTemp[$i][1] > 1 Then $Plural = 1
			If $troopKind <> -1 Then SetLog($aTemp[$i][2] & " » " & $aTemp[$i][1] & " " & NameOfTroop($g_avAttackTroops[$i][0], $Plural), $COLOR_GREEN)
		EndIf
	Next

	;ResumeAndroid()

	If $g_bDebugSetlog Then SetDebugLog("troopsnumber  = " & $troopsnumber)

	$g_iKingSlot = -1
	$g_iQueenSlot = -1
	$g_iWardenSlot = -1
	For $i = 0 To UBound($g_avAttackTroops) - 1
		If $g_avAttackTroops[$i][0] = $eKing Then
			$g_iKingSlot = $i
		ElseIf $g_avAttackTroops[$i][0] = $eQueen Then
			$g_iQueenSlot = $i
		ElseIf $g_avAttackTroops[$i][0] = $eWarden Then
			$g_iWardenSlot = $i
		EndIf
	Next

	If $g_bDebugSX Then SetDebugLog("SX|PrepareSuperXPAttack Finished", $COLOR_PURPLE)
	Return $troopsnumber
EndFunc   ;==>PrepareSuperXPAttack

Func CheckEarnedStars($ExitWhileHave = 0) ; If the parameter is 0, will not exit from attack lol
	If $g_bDebugSX Then SetDebugLog("SX|CheckEarnedStars", $COLOR_PURPLE)
	Local $starsearned = 0

	If $ExitWhileHave = 1 Then
		; IT CAN BE DETECTED By WRONG... But just made this to prevent heroes getting attacked
		; Please Simply Comment This If Condition If you Saw Problems And Bot Returned to Home Without Getting At Least One Star
		If _ColorCheck(_GetPixelColor(455, 405, True), Hex(0xD0D8D0, 6), 20) Then
			SetLog("1 Star earned", $COLOR_GREEN)
			If ReturnHomeSuperXP() = False Then CloseCoC(True) ; If Something Was Wrong with Returning Home, Close CoC And Open Again
			Return True
		EndIf
	EndIf

	If _ColorCheck(_GetPixelColor(714, 594, True), Hex(0xCCCFC8, 6), 20) Then $starsearned += 1

	If $ExitWhileHave <> 0 And $starsearned >= $ExitWhileHave Then
		SetLog($starsearned & " Star earned", $COLOR_GREEN)
		If ReturnHomeSuperXP() = False Then CloseCoC(True) ; If Something Was Wrong with Returning Home, Close CoC And Open Again
		Return True
	EndIf

	If $ExitWhileHave >= 2 Then
		If _ColorCheck(_GetPixelColor(740, 583, True), Hex(0xC6CBC5, 6), 20) Then $starsearned += 1

		If $ExitWhileHave <> 0 And $starsearned >= $ExitWhileHave Then
			SetLog($starsearned & " Stars earned", $COLOR_GREEN)
			If ReturnHomeSuperXP() = False Then CloseCoC(True) ; If Something Was Wrong with Returning Home, Close CoC And Open Again
			Return True
		EndIf

		If $ExitWhileHave >= 3 Then
			If _ColorCheck(_GetPixelColor(764, 583, True), Hex(0xBEC5BE, 6), 20) Then $starsearned += 1

			If $ExitWhileHave <> 0 And $starsearned >= $ExitWhileHave Then
				SetLog($starsearned & " Stars earned", $COLOR_GREEN)
				If ReturnHomeSuperXP() = False Then CloseCoC(True) ; If Something Was Wrong with Returning Home, Close CoC And Open Again
				Return True
			EndIf
		EndIf
	EndIf

	Return False

EndFunc   ;==>CheckEarnedStars

Func ReturnHomeSuperXP()
	Local Const $EndBattleText[4] = [29, 565 + $g_iMidOffsetY, 0xFFFFFF, 10], $EndBattle2Text[4] = [377, 244 + $g_iMidOffsetY, 0xFFFFFF, 20], $ReturnHomeText[4] = [428, 545 + $g_iMidOffsetY, 0xFFFFFF, 10]
	Local Const $DELAYEachCheck = 70, $iRetryLimits = 429 ; Wait for each Color About 30 Seconds If didn't found!
	Local $Counter = 0

	$g_iKingSlot = -1
	$g_iQueenSlot = -1
	$g_iWardenSlot = -1
	SetLog("Returning Home - SuperXP", $COLOR_BLUE)

	; 1st Step
	While _ColorCheck(_GetPixelColor($EndBattleText[0], $EndBattleText[1], True), Hex($EndBattleText[2], 6), $EndBattleText[3]) = False ; First EndBattle Button
		If $g_bDebugSX Then SetDebugLog("SX|RHSX|1-Loop #" & $Counter, $COLOR_DEBUG)
		If _Sleep($DELAYEachCheck) Then Return False
		$Counter += 1
		If $Counter >= $iRetryLimits Then
			If $g_bDebugSX Then SetDebugLog("SX|RHSX|First EndBattle Button not found")
			Return False
		EndIf
	WEnd

	Click(Random($EndBattleText[0] - 5, $EndBattleText[0] + 5, 1), Random($EndBattleText[1] - 5, $EndBattleText[1] + 5, 1)) ; Click First EndBattle Button
	If _Sleep($DELAYEachCheck) Then Return False

	; 2nd Step
	$Counter = 0 ; Reset Counter
	While _ColorCheck(_GetPixelColor($EndBattle2Text[0], $EndBattle2Text[1], True), Hex($EndBattle2Text[2], 6), $EndBattle2Text[3]) = False ; Second EndBattle Button
		If $g_bDebugSX Then SetDebugLog("SX|RHSX|2-Loop #" & $Counter, $COLOR_DEBUG)
		If _Sleep($DELAYEachCheck) Then Return False
		$Counter += 1
		If $Counter >= $iRetryLimits Then
			If $g_bDebugSX Then SetDebugLog("SX|RHSX|Second EndBattle Button not found")
			Return False
		EndIf
	WEnd

	Click(Random(455, 565, 1), Random(412, 447, 1)) ; Click 2nd EndBattle Button, (Verify)
	If _Sleep($DELAYEachCheck) Then Return False

	; 3rd Step
	$Counter = 0 ; Reset Counter
	While _ColorCheck(_GetPixelColor($ReturnHomeText[0], $ReturnHomeText[1], True), Hex($ReturnHomeText[2], 6), $ReturnHomeText[3]) = False ; Last - Return Home Button
		If $g_bDebugSX Then SetDebugLog("SX|RHSX|3-Loop #" & $Counter, $COLOR_DEBUG)
		If _Sleep($DELAYEachCheck) Then Return False
		$Counter += 1
		If $Counter >= $iRetryLimits Then
			If $g_bDebugSX Then SetDebugLog("SX|RHSX|Last Return Home Button not found")
			Return False
		EndIf
	WEnd

	Click(Random($ReturnHomeText[0] - 5, $ReturnHomeText[0] + 5, 1), Random($ReturnHomeText[1] - 5, $ReturnHomeText[1] + 5, 1)) ; Click on Return Home Button
	If _Sleep($DELAYReturnHome2) Then Return ; short wait for screen to Exit

	; Last Step, Check for Main Screen
	$Counter = 0 ; Reset Counter
	While 1
		If $g_bDebugSX Then SetDebugLog("SX|RHSX|4-Loop #" & $Counter, $COLOR_DEBUG)
		If _Sleep($DELAYReturnHome4) Then Return
		If IsMainPage(1) Then
			_GUICtrlEdit_SetText($g_hTxtLog, _PadStringCenter(" BOT LOG ", 71, "="))
			_GUICtrlRichEdit_SetFont($g_hTxtLog, 6, "Lucida Console")
			_GUICtrlRichEdit_AppendTextColor($g_hTxtLog, "" & @CRLF, _ColorConvert($Color_Black))
			Return True
		EndIf
		$Counter += 1
		If $Counter >= 50 Or isProblemAffect(True) Then
			SetLog("Cannot return home.", $COLOR_RED)
			checkMainScreen(True)
			Return True
		EndIf
	WEnd

EndFunc   ;==>ReturnHomeSuperXP

Func WaitForNoClouds()
	If $g_bDebugSX Then SetDebugLog("SX|WaitForNoClouds", $COLOR_PURPLE)
	Local $i = 0
	ForceCaptureRegion()
	While _ColorCheck(_GetPixelColor(60, 576, True), Hex(0x000000, 6), 20) = False
		If _Sleep($DELAYGetResources1) Then Return False
		$i += 1
		If $i >= 120 Or isProblemAffect(True) Then ; Wait 30 seconds then restart bot and CoC
			$g_bIsClientSyncError = True
			checkMainScreen()
			If $g_bRestart Then
				$g_iNbrOfOoS += 1
				UpdateStats()
				SetLog("Disconnected At Search Clouds - SuperXP", $COLOR_RED)
				PushMsg("OoSResources")
			Else
				SetLog("Stuck At Search Clouds, Restarting CoC and Bot... - SuperXP", $COLOR_RED)
				$g_bIsClientSyncError = False ; disable fast OOS restart if not simple error and restarting CoC
				CloseCoC(True)
			EndIf
			Return False
		EndIf
		If $g_bDebugSX Then SetDebugLog("SX|WFNC|Loop #" & $i)
		ForceCaptureRegion() ; ensure screenshots are not cached
	WEnd
	If $g_bDebugSX Then SetDebugLog("SX|WaitFornoClouds Finished", $COLOR_PURPLE)
	Return True
EndFunc   ;==>WaitForNoClouds

Func OpenGoblinPicnic()
	If $g_bDebugSX Then SetDebugLog("SX|OpenGoblinPicnic", $COLOR_PURPLE)
	Local $rOpenSinglePlayerPage = OpenSinglePlayerPage()
	If $rOpenSinglePlayerPage = False Then
		SetLog("Failed to open Attack page, Single Player", $COLOR_RED)
		SafeReturnSX()
		Return False
	EndIf
	Local $rDragToGoblinPicnic = DragToGoblinPicnic()
	If $rDragToGoblinPicnic = False Then
		SetLog("Failed to find Goblin Picnic", $COLOR_RED)
		DebugImageSave("SuperXP_", True, "png", True, String(Random(5, 100, 1)) & ", " & String(Random(5, 100, 1)) & ", " & String(Random(5, 100, 1)))
		SafeReturnSX()
		Return False
	EndIf

	If $g_bDebugSX Then SetDebugLog("SX|OGP|Clicking On GP Text: " & $rDragToGoblinPicnic[0] & ", " & $rDragToGoblinPicnic[1])
	Click($rDragToGoblinPicnic[0], $rDragToGoblinPicnic[1]) ; Click On Goblin Picnic Text To Show Attack Button
	Local $Counter = 0
	While _ColorCheck(_GetPixelColor(621, 665, True), Hex(0xFFFFFF, 6), 10) = False Or _ColorCheck(_GetPixelColor(663, 662, True), Hex(0xFFFFFF, 6), 10) = False ; Wait for Attack Button
		If _Sleep(50) Then ExitLoop
		$Counter += 1
		If $Counter > 200 Then
			SetLog("Available loot info didn't Displayed!", $COLOR_RED)
			SafeReturnSX()
			Return False
		EndIf
	WEnd

	$Counter = 0
	While _ColorCheck(_GetPixelColor($rDragToGoblinPicnic[0], $rDragToGoblinPicnic[1] + 83, True), Hex(0xE04A00, 6), 30) = False
		If _Sleep(50) Then ExitLoop
		;SetLog("waiting for button color")
		Click($rDragToGoblinPicnic[0], $rDragToGoblinPicnic[1]) ; Click On Goblin Picnic Text To Show Attack Button

		$Counter += 1
		If $Counter > 200 Then
			If IsGoblinPicnicLocked($rDragToGoblinPicnic) = True Then
				SetLog("Are you kidding me? Goblin Picnic is Locked", $COLOR_RED)
				DisableSX()
				SafeReturnSX()
				Return False
			EndIf
			SetLog("Attack Button Cannot be Verified", $COLOR_RED)
			DebugImageSave("SuperXP_", True, "png", True, String(Number($rDragToGoblinPicnic[0], 2) & ", " & Number($rDragToGoblinPicnic[1], 2) & @CRLF & Number($rDragToGoblinPicnic[0], 2) & ", " & Number($rDragToGoblinPicnic[1] + 83, 2)))
			SafeReturnSX()
			Return False
		EndIf
	WEnd

	If $g_bDebugSX Then SetDebugLog("SX|OGP|Clicking On Attack Btn: " & $rDragToGoblinPicnic[0] & ", " & $rDragToGoblinPicnic[1] + 78)
	Click($rDragToGoblinPicnic[0], $rDragToGoblinPicnic[1] + 78) ; Click On Attack Button

	$Counter = 0
	While IsInSPPage()
		If _Sleep(50) Then ExitLoop
		$Counter += 1
		If $Counter > 150 Then
			SetLog("Still in SinglePlayer Page!! Something Strange Happened", $COLOR_RED)
			;DebugImageSave("SuperXP_", True, "png", True, String(Number($rDragToGoblinPicnic[0], 2) & ", " & Number($rDragToGoblinPicnic[1], 2) & @CRLF & Number($rDragToGoblinPicnic[0], 2) & ", " & Number($rDragToGoblinPicnic[1] + 78, 2)), 80, 145, 35, $rDragToGoblinPicnic[0] - 5, $rDragToGoblinPicnic[1] - 5 + 78, 10, 10)
			$g_canGainXP = False
			Return False
		EndIf
	WEnd

	Local $rIsGoblinPicnic = IsInGoblinPicnic() ; Wait/Check if is In Goblin Picnic Base
	If $rIsGoblinPicnic = False Then
		SetLog("Looks like we're not in Goblin Picnic", $COLOR_RED)
		If _CheckPixel($aCancelFight, $g_bNoCapturePixel) Or _CheckPixel($aCancelFight2, $g_bNoCapturePixel) Then
			If $g_bDebugSetlog Then SetDebugLog("#cOb# Clicks X 2, $aCancelFight", $COLOR_BLUE)
			PureClickP($aCancelFight, 1, 0, "#0135") ;Clicks X
			If _Sleep($DELAYcheckObstacles1) Then Return False
			SafeReturnSX()
			Return False
		EndIf
		SafeReturnSX()
		Return False
	EndIf
	SetLog("Now we're in Goblin Picnic Base", $COLOR_GREEN)
	Return True
EndFunc   ;==>OpenGoblinPicnic

Func IsInGoblinPicnic($Retry = True, $maxRetry = 30, $timeBetweenEachRet = 300)
	If $g_bDebugSX Then SetDebugLog("SX|IsInGoblinPicnic", $COLOR_PURPLE)
	Local $Found = False
	Local $Counter = 0
	Local $directory = @ScriptDir & "\imgxml\Resources\SuperXP\Verify"
	Local $result = ""
	While $Found = False
		If _Sleep($timeBetweenEachRet) Then Return False
		If Not IsInAttackSuperXP() Then
			$Counter += 1
			If $Counter = $maxRetry Then
				$Found = False
				ExitLoop
			EndIf
			ContinueLoop
		EndIf

		$result = multiMatchesPixelOnly($directory, 0, "FV", "FV", "", 0, 1000, 0, 0, 111, 31)
		If $g_bDebugSX Then SetDebugLog("SX|IGP|$result=" & $result)
		$Found = (StringLen($result) > 2 And StringInStr($result, ","))

		$Counter += 1
		If $Counter = $maxRetry Then
			$Found = False
			ExitLoop
		EndIf
	WEnd
	If $g_bDebugSX Then SetDebugLog("SX|IsGoblinPicnic=" & $Found, $COLOR_PURPLE)
	Return $Found
EndFunc   ;==>IsInGoblinPicnic

Func IsGoblinPicnicLocked($FoundCoord)
	If $g_bDebugSX Then SetDebugLog("SX|IsGoblinPicnicLocked", $COLOR_PURPLE)
	Local $x = $FoundCoord[0], $y = $FoundCoord[1] + 9, $x1 = $x + 29, $y1 = $y + 34
	Local $directory = @ScriptDir & "\imgxml\Resources\SuperXP\Locked"
	Local $result = multiMatchesPixelOnly($directory, 0, "FV", "FV", "", 0, 1000, $x, $y, $x1, $y1)
	If $g_bDebugSX Then SetDebugLog("SX|IGPL|$result=" & $result)
	Local $Found = (StringLen($result) > 2 And StringInStr($result, ","))
	If $g_bDebugSX Then SetDebugLog("SX|IGPL Return " & $Found)
	Return $Found
EndFunc   ;==>IsGoblinPicnicLocked

Func DragToGoblinPicnic()
	If $g_bDebugSX Then SetDebugLog("SX|DragToGoblinPicnic", $COLOR_PURPLE)
	Local $rIsGoblinPicnicFound = False
	Local $Counter = 0
	Local $posInSinglePlayer2 = "MIDDLE"
	Local $posInSinglePlayer = GetPositionInSinglePlayer()
	If $g_bDebugSX Then SetDebugLog("SX|DTGP|$posInSinglePlayer=" & $posInSinglePlayer)
	If $posInSinglePlayer = "MIDDLE" Then
		If $g_bDebugSX Then SetDebugLog("SX|DTGP|Pos Middle, checking for GP")
		$rIsGoblinPicnicFound = IsGoblinPicnicFound()
		If IsArray($rIsGoblinPicnicFound) Then Return $rIsGoblinPicnicFound
		If $g_bDebugSX Then SetDebugLog("SX|DTGP|Pos middle, Dragging To End")
		If $g_bSkipDragToEndXP Then ;Skip Dragging to End
			$posInSinglePlayer = "END"
		Else
			If DragToEndSinglePlayer() = True Then $posInSinglePlayer = "END" ; If position was Middle, then try to Drag to end
		EndIf
	EndIf
	If $posInSinglePlayer = "MIDDLE" Then
		If $g_bDebugSX Then SetDebugLog("SX|DTGP|Failed to Drag To End, Still middle")
		Return False ; If Failed to Drag To End Then Return False
	EndIf

	Switch $posInSinglePlayer
		Case "END"
			While Not (IsArray($rIsGoblinPicnicFound))
				If $g_bDebugSX Then SetDebugLog("SX|DTGP|Drag from End Loop #" & $Counter)
				If $g_bSkipDragToEndXP Then
					ClickDrag(Random(510, 515, 1), Random(100, 105, 1), Random(510, 515, 1), Random(561, 566, 1), 100) ;EDITED BY SM MOD SAFE DRAG
				Else
					ClickDrag(Random(505, 515, 1), Random(95, 105, 1), Random(505, 515, 1), Random(656, 666, 1), 100)
				EndIf
				If _Sleep(100) Then Return False
				$rIsGoblinPicnicFound = IsGoblinPicnicFound()
				If IsArray($rIsGoblinPicnicFound) Then ExitLoop
				$Counter += 1
				$posInSinglePlayer2 = GetPositionInSinglePlayer()
				If $Counter = 15 Or $posInSinglePlayer2 = "FIRST" Then ExitLoop
			WEnd
			If $Counter = 15 Or $posInSinglePlayer2 And IsArray($rIsGoblinPicnicFound) = False Then Return False
			Return $rIsGoblinPicnicFound
		Case "FIRST"
			While Not (IsArray($rIsGoblinPicnicFound))
				If $g_bDebugSX Then SetDebugLog("SX|DTGP|Drag from First Loop #" & $Counter)
				If $g_bSkipDragToEndXP Then
					ClickDrag(Random(510, 515, 1), Random(561, 566, 1), Random(510, 515, 1), Random(100, 105, 1), 100) ;EDITED BY SM MOD SAFE DRAG
				Else
					ClickDrag(Random(505, 515, 1), Random(656, 666, 1), Random(505, 515, 1), Random(95, 105, 1), 100)
				EndIf
				If _Sleep(100) Then Return False
				$rIsGoblinPicnicFound = IsGoblinPicnicFound()
				If IsArray($rIsGoblinPicnicFound) Then ExitLoop
				$Counter += 1
				$posInSinglePlayer2 = GetPositionInSinglePlayer()
				If $Counter = 15 Or $posInSinglePlayer2 = "FIRST" Then ExitLoop
			WEnd
			If $Counter = 15 Or $posInSinglePlayer2 And IsArray($rIsGoblinPicnicFound) = False Then Return False
			Return $rIsGoblinPicnicFound
	EndSwitch
EndFunc   ;==>DragToGoblinPicnic

Func IsGoblinPicnicFound()
	If $g_bDebugSX Then SetDebugLog("SX|IsGoblinPicnicFound", $COLOR_PURPLE)
	Click(840, 230 + $g_iMidOffsetY)
	If _Sleep(50) Then Return False
	Local $directory = @ScriptDir & "\imgxml\Resources\SuperXP\Find"
	Local $result = multiMatchesPixelOnly($directory, 0, "FV", "FV", "", 0, 1000, 554, 120, 639, $g_iGAME_HEIGHT)
	If $g_bDebugSX Then SetDebugLog("SX|IGPF|$result=" & $result)
	If StringLen($result) < 3 And StringInStr($result, "|") = 0 Then
		If $g_bDebugSX Then SetDebugLog("SX|IGPF|Return False")
		Return False
	EndIf

	Local $ToReturn = ""
	If StringInStr($result, "|") > 0 Then
		$ToReturn = StringSplit(StringSplit($result, "|", 2)[0], ",", 2)
	Else
		$ToReturn = StringSplit($result, ",", 2)
	EndIf

	$ToReturn[0] += 560 ;was 554
	$ToReturn[1] += 125 ;was 120
	If $g_bDebugSX Then SetDebugLog("SX|IGPF Return $ToReturn[2] = [0]=" & $ToReturn[0] & ",[1]=" & $ToReturn[1])
	Return $ToReturn
EndFunc   ;==>IsGoblinPicnicFound

Func DragToEndSinglePlayer()
	If $g_bDebugSX Then SetDebugLog("SX|DragToEndSinglePlayer", $COLOR_PURPLE)
	Local $rColCheckEnd = _ColorCheck(_GetPixelColor(670, 695, True,"DragToEndSinglePlayer"), Hex(0x393224, 6), 20)
	Local $Counter = 0
	While $rColCheckEnd = False
		If $g_bDebugSX Then SetDebugLog("SX|DTESP|Loop #" & $Counter)
		ClickDrag(500, 635 + $g_iMidOffsetY, 500, 60 + $g_iMidOffsetY, 100)
		$rColCheckEnd = _ColorCheck(_GetPixelColor(670, 695, True,"DragToEndSinglePlayer"), Hex(0x393224, 6), 20)
		$Counter += 1
		If $Counter = 15 Then ExitLoop
	WEnd
	If $Counter = 15 Then
		If $g_bDebugSX Then SetDebugLog("SX|DTESP|Return False")
		Return False
	EndIf
	If $g_bDebugSX Then SetDebugLog("SX|DTESP|Return True")
	Return True
EndFunc   ;==>DragToEndSinglePlayer

Func GetPositionInSinglePlayer()
	If $g_bDebugSX Then SetDebugLog("SX|GetPositionInSinglePlayer", $COLOR_PURPLE)
	ClickP($aAway, 2, 0, "#0346") ;Click Away To Hide Available Loot Info

	Local $Counter = 0
	While _ColorCheck(_GetPixelColor(621, 665, True, "GetPositionInSinglePlayer"), Hex(0xFFFFFF, 6), 10) And _ColorCheck(_GetPixelColor(663, 662, True), Hex(0xFFFFFF, 6), 10)
		If _Sleep(50) Then ExitLoop
		ClickP($aAway, 2, 0, "#0346") ;Click Away To Hide Available Loot Info
		$Counter += 1
		If $Counter > 100 Then
			If $g_bDebugSX Then SetDebugLog("SX|GPISP|Available Loot Not Hidden, Returning")
			ExitLoop
		EndIf
	WEnd

	Local $rColCheckEnd = _ColorCheck(_GetPixelColor(517, 729, True, "GetPositionInSinglePlayer CheckEnd"), Hex(0x3B3426, 6), 10) ; Safe Corrdinates To Avoid Conflict With Stars Color - October Update
	If $rColCheckEnd Then
		If $g_bDebugSX Then SetDebugLog("SX|GPISP|Return END")
		Return "END"
	Else
		Local $rColCheckFirst = _ColorCheck(_GetPixelColor(510, 4, True, "GetPositionInSinglePlayer CheckFirst/Middle"), Hex(0x373022, 6), 10) ;Old Corrdinates Was Conflicting with star - October Update
		If $rColCheckFirst Then
			If $g_bDebugSX Then SetDebugLog("SX|GPISP|Return FIRST")
			Return "FIRST"
		Else
			If $g_bDebugSX Then SetDebugLog("SX|GPISP|Return MIDDLE")
			Return "MIDDLE"
		EndIf
	EndIf
EndFunc   ;==>GetPositionInSinglePlayer

Func OpenSinglePlayerPage()
	If $g_bDebugSX Then SetDebugLog("SX|OpenSinglePlayerPage", $COLOR_PURPLE)

	If Not WaitForMain(True, 50, 300) Then
		If $g_bDebugSX Then SetDebugLog("SX|MainPage Not Displayed to Open SingleP")
		Return False
	EndIf

	SetLog("Going to Gain XP...", $COLOR_BLUE)

	If IsMainPage() Then

		If $g_bUseRandomClick = 0 Then
			ClickP($aAttackButton, 1, 0, "#0149") ; Click Attack Button
		Else
			ClickR($aAttackButtonRND, $aAttackButton[0], $aAttackButton[1], 1, 0)
		EndIf
	EndIf
	If _Sleep(70) Then Return

	Local $j = 0
	While Not _ColorCheck(_GetPixelColor(606, 33, True), Hex(0xFFFFFF, 6), 10) And Not _ColorCheck(_GetPixelColor(804, 32, True), Hex(0xFFFFFF, 6), 10)
		If _Sleep(70) Then Return
		$j += 1
		If $j > 214 Then ExitLoop
	WEnd
	If $j > 214 Then
		SetLog("Launch attack Page Fail", $COLOR_RED)
		checkMainScreen()
		Return False
	Else
		Return True
	EndIf

EndFunc   ;==>OpenSinglePlayerPage

Func WaitForMain($clickAway = True, $DELAYEachCheck = 50, $maxRetry = 100)
	If $clickAway Then ClickP($aAway, 2, 0, "#0346") ;Click Away

	Local $Counter = 0
	While Not (IsMainPage())
		If _Sleep($DELAYEachCheck) Then Return True
		If $clickAway Then ClickP($aAway, 2, 0, "#0346") ;Click Away
		$Counter += 1
		If $Counter > $maxRetry Then
			Return False
		EndIf
	WEnd

	Return True
EndFunc   ;==>WaitForMain
