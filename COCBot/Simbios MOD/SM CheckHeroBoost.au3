; #FUNCTION# ====================================================================================================================
; Name ..........: Check Hero Time Boost
; Description ...: 
; Author ........: Ahsan Iqbal
; Modified ......: Fahid.Mahmood
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Local $sHeroTime[3] = ["", "", ""]

Func CheckHeroBoost()
	SetLog("Checking Hero's Boost Time", $COLOR_INFO)

	Local $sHeroName[3] = ["King", "Queen", "Warden"]
	Local $bIsBoostedImg = @ScriptDir & "\imgxml\boost\BoostC\BoostCCheck"
	Local $bHeroTimeOCRImgs = @ScriptDir & "\imgxml\HeroTime"

	For $index = 0 To 2

		If $g_iHeroUpgrading[$index] == 1 Then
			SetLog($sHeroName[$index] & " is on upgrade skip it's boost time check.", $COLOR_INFO)
			ContinueLoop
		EndIf

		Local $i_heroTime = ($HeroTime[$g_iCurAccount][$index] - (_DateDiff("n", $HeroTimeRem[$g_iCurAccount][$index], _NowCalc())))

		If $g_bFirstStart Or $i_heroTime < 0 Or $HeroTimeRem[$g_iCurAccount][$index] = "" Then

			If $index = 0 Then
				If $g_aiKingAltarPos[0] = "" Or $g_aiKingAltarPos[0] = -1 Then
					SetLog("Please Locate " & $sHeroName[$index], $COLOR_ERROR)
					ContinueLoop
				EndIf
			ElseIf $index = 1 Then
				If $g_aiQueenAltarPos[0] = "" Or $g_aiQueenAltarPos[0] = -1 Then
					SetLog("Please Locate " & $sHeroName[$index], $COLOR_ERROR)
					ContinueLoop
				EndIf
			ElseIf $index = 2 Then
				If $g_aiWardenAltarPos[0] = "" Or $g_aiWardenAltarPos[0] = -1 Then
					SetLog("Please Locate " & $sHeroName[$index], $COLOR_ERROR)
					ContinueLoop
				EndIf
			EndIf

			If _DateIsValid($HeroTime[$g_iCurAccount][$index]) Then

			EndIf

			If $index = 0 Then BuildingClickP($g_aiKingAltarPos, "#0462")
			If $index = 1 Then BuildingClickP($g_aiQueenAltarPos, "#0462")
			If $index = 2 Then BuildingClickP($g_aiWardenAltarPos, "#0462")

			_Sleep($DELAYBOOSTHEROES1)

			If $index = 0 Or $index = 1 Then
				If $g_bDebugSetlog Then SetLog("In Index " & $index, $COLOR_INFO)

				If QuickMis("BC1", $bIsBoostedImg, 365, 640, 365 + 40, 640 + 38) Then ;When King OR Queen Has 4 Buttons Check if boosted then Do OCR
					$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 350, 675, 350 + 65, 675 + 18, True)
				ElseIf QuickMis("BC1", $bIsBoostedImg, 320, 640, 320 + 40, 640 + 38) Then ;When King OR Queen Has 5 Buttons(When Has Boost Spell) Check if boosted then Do OCR
					$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 300, 675, 300 + 70, 675 + 18, True)
				ElseIf QuickMis("BC1", $bIsBoostedImg, 415, 640, 415 + 40, 640 + 38) Then ;When King OR Queen Has 3 Buttons(When Hero Are Maxed) Check if boosted then Do OCR
					$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 395, 675, 395 + 70, 675 + 18, True)
				EndIf
			EndIf
			If $index = 2 Then
				If $g_bDebugSetlog Then SetLog("In Index " & $index, $COLOR_INFO)

				If QuickMis("BC1", $bIsBoostedImg, 320, 640, 320 + 40, 640 + 38) Then ;When Warden Has 5 Buttons Check if boosted then Do OCR
					$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 300, 675, 300 + 70, 675 + 18, True)
				ElseIf QuickMis("BC1", $bIsBoostedImg, 270, 640, 270 + 40, 640 + 38) Then ;When Warden Has 6 Buttons(When Has Boost Spell) Check if boosted then Do OCR
					$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 250, 675, 250 + 70, 675 + 18, True)
				ElseIf QuickMis("BC1", $bIsBoostedImg, 365, 640, 365 + 40, 640 + 38) Then ;When Warden Has 4 Buttons(Warden Is Maxed) Check if boosted then Do OCR
					$sHeroTime[$index] = QuickMIS("OCR", $bHeroTimeOCRImgs, 350, 675, 350 + 65, 675 + 18, True)
				EndIf
			EndIf

			If $sHeroTime[$index] <> "none" And $sHeroTime[$index] <> "" Then ;Sometime quickmis returning empty value
				If $g_bDebugSetlog Then setLog("inside ConvertOCRLongTime : " & $sHeroTime[$index], $COLOR_INFO)
				$HeroTimeRem[$g_iCurAccount][$index] = _NowCalc()
				$HeroTime[$g_iCurAccount][$index] = ConvertOCRLongTime("Hero Time", $sHeroTime[$index], False)
				SetDebugLog("$sResult QuickMIS OCR: " & $sHeroTime[$index] & " (" & Round($HeroTime[$g_iCurAccount][$index], 2) & " minutes)")
				SetLog($sHeroName[$index] & " Boost Time Left = " & $sHeroTime[$index], $COLOR_SUCCESS)
			Else
				SetLog($sHeroName[$index] & " not boosted skip it's boost time check.", $COLOR_INFO)
			EndIf

			If $g_bDebugSetlog Then
				SetLog("$HeroTimeRem[" & $index & "] = " & $HeroTimeRem[$g_iCurAccount][$index], $COLOR_INFO)
				SetLog("$HeroTime[$g_iCurAccount][" & $index & "] = " & $HeroTime[$g_iCurAccount][$index], $COLOR_INFO)
			EndIf

			If $g_bDebugSetlog Then SetLog("-------------------------------------------", $COLOR_INFO)
		Else
			If $g_bDebugSetlog Then
				SetLog("$HeroTime[$g_iCurAccount] = " & $HeroTime[$g_iCurAccount][$index], $COLOR_ERROR)
				SetLog("$HeroTimeRem[" & $index & "] = " & $HeroTimeRem[$g_iCurAccount][$index], $COLOR_ERROR)
				SetLog("Time Diff HeroTime = " & $i_heroTime, $COLOR_ERROR)
			EndIf
		EndIf
	Next
	ClickP($aAway, 2, 0, "#0000") ;Click Away
EndFunc   ;==>CheckHeroBoost

Func HeroBoostTimeDiv($aResultHeroes, $i)
	Local $iheroTime = ($HeroTime[$g_iCurAccount][$i] - (_DateDiff("n", $HeroTimeRem[$g_iCurAccount][$i], _NowCalc())))

	If $HeroTime[$g_iCurAccount][$i] <> "" Or $HeroTime[$g_iCurAccount][$i] <> 0 Then

		If $g_bDebugSetlog Then
			SetLog("$aResultHeroes = " & $aResultHeroes, $COLOR_INFO)
			SetLog("$HeroTime[$g_iCurAccount] = " & $HeroTime[$g_iCurAccount][$i], $COLOR_INFO)
			SetLog("$HeroTimeRem[" & $i & "] = " & $HeroTimeRem[$g_iCurAccount][$i], $COLOR_INFO)
			SetLog("Time Diff HeroTime = " & $iheroTime, $COLOR_INFO)
		EndIf

		If $iheroTime > 0 Then
			If ($aResultHeroes - ($iheroTime * 4)) < 0 Then
				$aResultHeroes /= 4
				If $g_bDebugSetlog Then SetLog("$aResultHeroes /= 4 ---> " & $aResultHeroes, $COLOR_INFO)
			ElseIf ($aResultHeroes - ($iheroTime * 4)) > 0 Then
				$aResultHeroes = ($aResultHeroes - ($iheroTime * 4)) + ($aResultHeroes / 4)
				If $g_bDebugSetlog Then SetLog("$aResultHeroes = $aResultHeroes - ($iheroTime * 4) ---> " & $aResultHeroes, $COLOR_INFO)
			EndIf
		EndIf
		Return $aResultHeroes
	Else
		Return $aResultHeroes
	EndIf
EndFunc   ;==>HeroBoostTimeDiv


