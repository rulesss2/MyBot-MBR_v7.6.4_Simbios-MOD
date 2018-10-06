; #FUNCTION# ====================================================================================================================
; Name ..........: BoostAllWithMagicSpell, BoostWhitC
; Description ...:
; Syntax ........:
; Parameters ....:
; Return values .: None
; Author ........: Demen, bld
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func BoostAllWithMagicSpell()
	Local $bBoosted = False
	Local $asHero[3] = ["king", "queen", "warden"]
	Local $aHeroPos[3][2] = [[$g_aiKingAltarPos[0], $g_aiKingAltarPos[1]], [$g_aiQueenAltarPos[0], $g_aiQueenAltarPos[1]], [$g_aiWardenAltarPos[0], $g_aiWardenAltarPos[1]]]

	Local $directory = @ScriptDir & "\imgxml\boost"

	; Verifying existent Variables to run this routine
	If Not $g_iChkBoostBMagic Then Return
	If AllowBoosting("All using magic spell", $g_iCmbBoostBrMagic) = False Then Return

	SetLog("Boost all with magic spell...")

	Static $iAvailableHero = -1 ; -1 = No hero available, 0|1|2 = King|Queen|Warden
	Static $iHeroWithBadLocation = -1

	If OpenArmyOverview(True, "BoostWithMagicSpell()") Then
		; check hero status
		If _Sleep($DELAYCHECKARMYCAMP5) Then Return
		If $iAvailableHero >= 0 And $aHeroPos[$iAvailableHero][0] <> "" And $aHeroPos[$iAvailableHero][0] <> -1 Then
			; Already have data
			SetDebugLog("already have $iAvailableHero: " & $iAvailableHero & ": " & $g_asHeroShortNames[$iAvailableHero])
		Else
			$iAvailableHero = -1
			For $i = $eHeroBarbarianKing To $eHeroGrandWarden
				SetDebugLog("Checking " & $g_asHeroShortNames[$i])
				If $i = $iHeroWithBadLocation Then ContinueLoop
				If $aHeroPos[$i][0] = "" Or $aHeroPos[$i][0] = -1 Then ContinueLoop ; hero not yet located, skip to check another hero.
				Local $sResult = ArmyHeroStatus($i)
				If StringInStr($sResult, $asHero[$i], $STR_NOCASESENSEBASIC) Or StringInStr($sResult, "heal", $STR_NOCASESENSEBASIC) Then
					$iAvailableHero = $i
					SetDebugLog("Found $iAvailableHero: " & $iAvailableHero & ": " & $g_asHeroShortNames[$iAvailableHero])
					ExitLoop ; found 1 hero available, quit checking the rest.
				EndIf
				SetDebugLog($g_asHeroShortNames[$i] & " is upgrading (" & $sResult & ")")
			Next
		EndIf

		; check boost status
		If OpenTroopsTab(True, "BoostWithMagicSpell()") Then
			If _ColorCheck(_GetPixelColor(825, 320, True), Hex(0xA0A09B, 6), 30) Then
				SetLog("Already boosted!")
				$bBoosted = True
			EndIf
		EndIf
		ClickP($aAway, 1, 0, "#0000") ;Click Away
		If _Sleep($DELAYCHECKARMYCAMP4) Then Return
		If $bBoosted Then Return
	EndIf

	Local $bCanBoost = False
	; boosting with Hero Location
	If $iAvailableHero >= 0 Then
		SetDebugLog("first try with hero altar: " & $iAvailableHero & ": " & $g_asHeroShortNames[$iAvailableHero])
		; click hero
		Local $aPos[2] = [$aHeroPos[$iAvailableHero][0], $aHeroPos[$iAvailableHero][1]]
		BuildingClickP($aPos)
		SetDebugLog("1. Click: " & $g_asHeroShortNames[$iAvailableHero])
		If _Sleep($DELAYBOOSTHEROES2) Then Return
		ForceCaptureRegion()
		Local $aResult = BuildingInfo(242, 520 + $g_iBottomOffsetY)
		If $aResult[0] > 1 Then
			If StringInStr($aResult[1], $g_asHeroShortNames[$iAvailableHero], $STR_NOCASESENSEBASIC) > 0 Then
				SetDebugLog("Boost all using " & $g_asHeroShortNames[$iAvailableHero] & " located at " & $aPos[0] & ", " & $aPos[1])
				If $iHeroWithBadLocation = $iAvailableHero Then $iHeroWithBadLocation = -1
				$bCanBoost = True
			Else
				SetDebugLog("This location (" & $aPos[0] & ", " & $aPos[1] & ") is " & $aResult[1] & ", not " & $g_asHeroShortNames[$iAvailableHero] & " as expected")
				$iHeroWithBadLocation = $iAvailableHero
				$iAvailableHero = -1 ; reset due to bad location
			EndIf
		Else
			SetDebugLog("Error reading building info of: " & $g_asHeroShortNames[$iAvailableHero])
		EndIf

		; boost
		If $bCanBoost Then
			If QuickMIS("BC1", $directory, 350, 650, 565, 675) Then
				Click(350 + $g_iQuickMISX, 650 + $g_iQuickMISY)
				SetDebugLog("2. Click Magic Spell: " & 390 + $g_iQuickMISX & ", " & 650 + $g_iQuickMISY)
				If _Sleep($DELAYBOOSTHEROES2) Then Return
				If _ColorCheck(_GetPixelColor(400, 440, True), Hex(0x7D8BFF, 6), 30) Then ; click violet OK button
					Click(400, 440)
					SetDebugLog("3. Click Use training potion 400, 440")
					$bBoosted = True ; done!
				Else
					SetLog("Cannot find 'Training Potion' button")
				EndIf
			Else
				SetLog("Cannot find 'BoostAll'")
			EndIf
		EndIf

		If Not $bBoosted Then ClickP($aAway, 1, 0, "#0000")
	Else
		SetLog("No hero available or located")
		ClickP($aAway, 1, 0, "#0000")
	EndIf

	; boosting with Clan Castle Location
	$bCanBoost = False
	If Not $bBoosted And $g_aiClanCastlePos[0] <> "" And $g_aiClanCastlePos[0] <> -1 Then
		SetDebugLog("Try boosting from Clan castle, " & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1])
		; click CC
		BuildingClickP($g_aiClanCastlePos)
		SetDebugLog("1. Click Clan Castle: " & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1])
		If _Sleep($DELAYBOOSTHEROES2) Then Return
		ForceCaptureRegion()
		Local $aResult = BuildingInfo(242, 520 + $g_iBottomOffsetY)
		If $aResult[0] > 1 Then
			If StringInStr($aResult[1], "Castle", $STR_NOCASESENSEBASIC) > 0 Then
				SetDebugLog("Boost all using Clan Castle located at " & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1])
				$bCanBoost = True
			Else
				SetDebugLog("This location (" & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1] & ") is " & $aResult[1] & ", not the Clan Castle as expected")
			EndIf
		Else
			SetDebugLog("Error reading building info of clan castle")
		EndIf

		; boost
		If $bCanBoost Then
			If QuickMIS("BC1", $directory, 475, 650, 630, 675) Then
				Click(475 + $g_iQuickMISX, 650 + $g_iQuickMISY)
				SetDebugLog("2. Click Magic Items: " & 475 + $g_iQuickMISX & ", " & 650 + $g_iQuickMISY)
				If _Sleep($DELAYBOOSTHEROES2) Then Return
                If QuickMIS("BC1", $directory, 163, 226, 694, 480) Then
					Click(136 + $g_iQuickMISX, 226 + $g_iQuickMISY)
					SetDebugLog("3. Click Training Potion at: " & 136 + $g_iQuickMISX & ", " & 226 + $g_iQuickMISY)
					If _Sleep($DELAYBOOSTHEROES2) Then Return
                    If _ColorCheck(_GetPixelColor(200, 565, True), Hex(0x8CD136, 6), 30) Then
                        Click(200, 565)
                        SetDebugLog("4. Click Use Training Potion 200, 565")
                        If _Sleep($DELAYBOOSTHEROES2) Then Return
                        If _ColorCheck(_GetPixelColor(400, 440, True), Hex(0x7D8BFF, 6), 30) Then ; click violet OK button
                            Click(400, 440)
                            SetDebugLog("5. Click confirm Use training potion 400, 440")
                            $bBoosted = True ; done!
                        Else
                            SetLog("Cannot find 'Training Potion' confirmed button")
                        EndIf					
					Else
						SetLog("Cannot find 'Use' button to boost")
					EndIf
				Else
					SetLog("Cannot find Training Potion available")
				EndIf
			Else
				SetLog("Cannot find 'Magic Items' Button")
			EndIf
		EndIf
		If Not $bBoosted Then ClickP($aAway, 1, 0, "#0000")

	ElseIf Not $bBoosted Then
		SetLog("Clan Castle is not located")
		ClickP($aAway, 1, 0, "#0000")
		Return
	EndIf

	If $bBoosted Then
		If $g_iCmbBoostBrMagic >= 1 And $g_iCmbBoostBrMagic <= 5 Then
			$g_iCmbBoostBrMagic -= 1
			SetLog("BoostAll completed with Magic Spell. Remaining iterations: " & $g_iCmbBoostBrMagic, $COLOR_SUCCESS)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostBrMagic, $g_iCmbBoostBrMagic)
		ElseIf $g_iCmbBoostBrMagic = 6 Then
			SetLog("BoostAll completed with Magic Spell. Remaining iterations: Unlimited", $COLOR_SUCCESS)
		EndIf
	Else
		SetLog("Cannot 'BoostAll' with Magic Spell")
	EndIf

	If _Sleep($DELAYBOOSTBARRACKS3) Then Return
	Return $bBoosted

EndFunc   ;==>BoostAllWithMagicSpell
; ========================================================================================================================================
Func BoostWhitC($g_iXCollect = 0, $g_iYCollect = 0)

	Local $bBoosted = False
	Local $directory = @ScriptDir & "\imgxml\boost\BoostC"
	Local $bBoostedImg = @ScriptDir & "\imgxml\boost\BoostC\BoostCCheck"
	Local $BoostCCollect = @ScriptDir & "\imgxml\boost\BoostC\BoostCCollect"
	
	; Verify that it takes at least one day to proceed.
	Local $iSTime[3] = [@MDAY, @HOUR, @MIN]
	If $iSTime[0] <= $g_iLastTime[0] And $iSTime[1] <= $g_iLastTime[1] And $iSTime[2] <= $g_iLastTime[2] Then Return

	If $g_iXCollect = 0 Or $g_iYCollect = 0 Then Return
	
	; Verifying existent Variables to run this routine
	If Not $g_iChkBoostCMagic Then Return
	If AllowBoosting("All using magic spell", $g_iCmbBoostClMagic) = False Then Return

	SetLog("Boost collectors with magic spell...")

		Click($g_iXCollect, $g_iYCollect + 29)
		_Sleep(500)
		ForceCaptureRegion()
		Local $aResult = BuildingInfo(242, 520 + $g_iBottomOffsetY)
		If $aResult[0] > 1 Then
			If StringInStr($aResult[1], "Mine", $STR_NOCASESENSEBASIC) > 0 Then
				Local $bCanBoost = True
				SetDebugLog("Mine True")
			Else
				SetDebugLog("Mine False")
			EndIf
		Else
			SetDebugLog("Error reading building info of Mine")
		EndIf

		_Sleep(500)
		If QuickMis("BC1", $bBoostedImg, 136, 609, 726, 711) Then
				$bBoosted = True	
				$g_iLastTime[0] = @MDAY
				$g_iLastTime[1] = @HOUR
				$g_iLastTime[2] = @MIN

			SetDebugLog("$bBoosted" & " " & $bBoosted)
		EndIf
		
		; boosting with Mine
		Local $bCanBoost = False
		If $bBoosted Then Return
		
			_Sleep(500)
			If QuickMis("BC1", $BoostCCollect, 136, 609, 726, 711) Then
               Click(136 + $g_iQuickMISX, 609 + $g_iQuickMISY)
				_Sleep(750)
                If _ColorCheck(_GetPixelColor(400, 440, True), Hex(0x7D8BFF, 6), 30) Then ; click violet OK button
                      Click(400, 440)
                      SetDebugLog("Click confirm Use collectors potion 400, 440")
						$bBoosted = True ; done!
						$g_iLastTime[0] = @MDAY
						$g_iLastTime[1] = @HOUR
						$g_iLastTime[2] = @MIN
					Else
                    SetLog("Cannot find 'Collectors Potion' confirmed button")
					$bBoosted = False
                  EndIf					
            EndIf					

			ClickP($aAway, 1, 0, "#0000") ;Click Away
			
	; boosting with Clan Castle Location
	$bCanBoost = False
	If Not $bBoosted And $g_aiClanCastlePos[0] <> "" And $g_aiClanCastlePos[0] <> -1 Then
		SetDebugLog("Try boosting from Clan castle, " & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1])
		; click CC
		BuildingClickP($g_aiClanCastlePos)
		SetDebugLog("1. Click Clan Castle: " & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1])
		If _Sleep($DELAYBOOSTHEROES2) Then Return
		ForceCaptureRegion()
		Local $aResult = BuildingInfo(242, 520 + $g_iBottomOffsetY)
		If $aResult[0] > 1 Then
			If StringInStr($aResult[1], "Castle", $STR_NOCASESENSEBASIC) > 0 Then
				SetDebugLog("Boost all using Clan Castle located at " & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1])
				$bCanBoost = True
			Else
				SetDebugLog("This location (" & $g_aiClanCastlePos[0] & ", " & $g_aiClanCastlePos[1] & ") is " & $aResult[1] & ", not the Clan Castle as expected")
			EndIf
		Else
			SetDebugLog("Error reading building info of clan castle")
		EndIf

		; boost
		If $bCanBoost Then
			If QuickMIS("BC1", $directory, 475, 650, 630, 675) Then
				Click(475 + $g_iQuickMISX, 650 + $g_iQuickMISY)
				SetDebugLog("2. Click Magic Items: " & 475 + $g_iQuickMISX & ", " & 650 + $g_iQuickMISY)
				If _Sleep($DELAYBOOSTHEROES2) Then Return
                If QuickMIS("BC1", $directory, 163, 226, 694, 480) Then
					Click(136 + $g_iQuickMISX, 226 + $g_iQuickMISY)
					SetDebugLog("3. Click Training Potion at: " & 136 + $g_iQuickMISX & ", " & 226 + $g_iQuickMISY)
					If _Sleep($DELAYBOOSTHEROES2) Then Return
                    If _ColorCheck(_GetPixelColor(200, 565, True), Hex(0x8CD136, 6), 30) Then
                        Click(200, 565)
                        SetDebugLog("4. Click Use Training Potion 200, 565")
                        If _Sleep($DELAYBOOSTHEROES2) Then Return
                        If _ColorCheck(_GetPixelColor(400, 440, True), Hex(0x7D8BFF, 6), 30) Then ; click violet OK button
                            Click(400, 440)
                            SetDebugLog("5. Click confirm Use training potion 400, 440")
                            $bBoosted = True ; done!
							$g_iLastTime[0] = @MDAY
							$g_iLastTime[1] = @HOUR
							$g_iLastTime[2] = @MIN
                        Else
                            SetLog("Cannot find 'Training Potion' confirmed button")
                        EndIf					
					Else
						SetLog("Cannot find 'Use' button to boost")
					EndIf
				Else
					SetLog("Cannot find Training Potion available")
				EndIf
			Else
				SetLog("Cannot find 'Magic Items' Button")
			EndIf
		EndIf
		If Not $bBoosted Then ClickP($aAway, 1, 0, "#0000")

	ElseIf Not $bBoosted Then
		SetLog("Clan Castle is not located")
		ClickP($aAway, 1, 0, "#0000")
		Return
	EndIf

	If $bBoosted Then
		If $g_iCmbBoostClMagic >= 1 And $g_iCmbBoostClMagic <= 5 Then
			$g_iCmbBoostClMagic -= 1
			SetLog("BoostAll completed with Magic Spell. Remaining iterations: " & $g_iCmbBoostClMagic, $COLOR_SUCCESS)
			_GUICtrlComboBox_SetCurSel($g_hCmbBoostClMagic, $g_iCmbBoostClMagic)
		ElseIf $g_iCmbBoostClMagic = 6 Then
			SetLog("BoostAll completed with Magic Spell. Remaining iterations: Unlimited", $COLOR_SUCCESS)
		EndIf
	Else
		SetLog("Cannot 'BoostAll' with Magic Spell")
	EndIf

	If _Sleep($DELAYBOOSTBARRACKS3) Then Return
	Return $bBoosted

EndFunc   ;==>BoostWhitC


;_----------------------------
;BuildingClickP($g_aiClanCastlePos)
;_Sleep(500)
;        If QuickMIS("BC1", $g_sImgLibr, 136, 609, 726, 711) Then
;        Click(136 + $g_iQuickMISX, 609 + $g_iQuickMISY)
;Endif
;_Sleep(500)
;        If QuickMIS("BC1", $g_sImgBboost, 163, 226, 694, 480) Then
;        Click(136 + $g_iQuickMISX, 226 + $g_iQuickMISY)
;endif
;_Sleep(500)
;        If QuickMIS("BC1", $g_sImgCboost, 163, 226, 694, 480) Then
;        Click(136 + $g_iQuickMISX, 226 + $g_iQuickMISY)
;endif

; $g_sImgBboost
; $g_sImgCboost        
; $g_sImgLibr 
;_----------------------------

;Func BoostWhitC($g_iXCollect = -1, $g_iYCollect = -1)
;If $g_iXCollect = -1 or $g_iYCollect = -1 then return
;Click($g_iXCollect - 5, $g_iYCollect + 10)
;_Sleep(500)
;Global $g_sImgCollectors = @ScriptDir & "\imgxml\Boost\BoostC"
;If QuickMis("BC1", $g_sImgCollectors, 136, 609, 726, 711) Then
;$g_bCanBoostC = False
;Else 
;$g_bCanBoostC = True
;EndIf
;EndFunc
