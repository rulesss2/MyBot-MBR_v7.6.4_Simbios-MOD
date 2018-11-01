; #FUNCTION# ====================================================================================================================
; Name ..........: BB_DropTrophies
; Description ...:
; Author ........: Chackal++
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func BB_DropTrophies()

	Local $i = 0
	Local $j = 0

	Local $cPixColor = ''
	Local $iSide = 1
	Local $cSideNames = "TR|TL"

	Local $bDegug = True
	Local $bContinue = True

	Local $aOkButtom[4] = [400, 495 + $g_iBottomOffsetY, 0xE2F98B, 20]
	Local $aOkButtomColor[2] = [0xE2F98B, 0xE2FA8C]
	Local $aOkBatleEnd[4] = [630, 400 + $g_iBottomOffsetY, 0xDDF685, 20]
	Local $aOkBatleEndColor[2] = [0xDDF685, 0xE2FA8C]
	Local $aOkWaitBattle[4] = [400, 500 + $g_iBottomOffsetY, 0xF0F0F0, 20]
	Local $aTroopSlot[4] = [40, 580 + $g_iBottomOffsetY, 0x404040, 20]
	Local $aSlotActive[8] = [0x4C92D3, 0x5198E0, 0x5298E0, 0x5498E0, 0x5598E0, 0x65ADEC, 0x66ADEC, 0x6AB4F1]
	Local $aSlotOff[2] = [0x464646, 0x454545]
	Local $iTroopsTo = 0
	Local $iWait64 = 64
	Local $iWait128 = 128
	Local $iWait256 = 256
	Local $bIsBMachineAvailable = False

	If $g_bChkBB_DropTrophies Then
		; Click attack button and find a match

		If $g_aiCurrentLootBB[$eLootTrophyBB] = 0 Then BuilderBaseReport() ; BB Trophy is 0 then check builderbase report - ADDED BY SM MOD

		If _Sleep($DELAYRESPOND) Then Return ; ADDED BY SM MOD

		If $g_iTxtBB_DropTrophies > 0 Then
			$i = $g_aiCurrentLootBB[$eLootTrophyBB] - $g_iTxtBB_DropTrophies
		EndIf
		If $i > 0 Then

			If _Sleep($DELAYRUNBOT1) Then Return

			If BB_PrepareAttack() Then

				If _Sleep($DELAYRUNBOT1 * 15) Then Return

				; Deploy All Troops From Slot's
				Setlog(" ====== BB Attack ====== ", $COLOR_INFO)
				SetLog("BB: Attacking on a single side", $COLOR_INFO)
				If QuickMIS("BC1", $g_sImgAttackBarBBDir, 25, 656, 25 + 535, 656 + 43) Then
					If $bDegug Then SetLog("BB: BM Available", $COLOR_DEBUG)
					$bIsBMachineAvailable = True
				Else
					If $bDegug Then SetLog("BB: BM Not Available", $COLOR_DEBUG)
				EndIf
				For $i = 0 To 5
					; Pos Next Slot
					If ($i > 0) Then $aTroopSlot[0] += 72

					$cPixColor = _GetPixelColor($aTroopSlot[0], $aTroopSlot[1] - 7, True, "Troop Slot") ; 633 Is the White Pixel When Slot Is Selected
					If Not _ColorCheck($cPixColor, Hex(0xFFFFFF, 6), 0) Then ; Check If Slot Is Already Selected
						If _Sleep($DELAYRUNBOT1) Then Return
						If BB_ColorCheck($aTroopSlot, $aSlotActive) Then
							If $bDegug Then SetLog("BB: Click Slot : [" & String($i + 1) & "], Color: " & $cPixColor, $COLOR_DEBUG) ; ADDED By SM MOD
							ClickP($aTroopSlot, 1, 0, "#0000")
						ElseIf $i > 0 Then
							If $bDegug Then SetLog("BB: Can't Find  Slot : [" & String($i + 1) & "], Color: " & $cPixColor, $COLOR_DEBUG) ; ADDED By SM MOD
							If Not BB_ColorCheck($aTroopSlot, $aSlotOff) Then
								$bContinue = False
							EndIf
						EndIf
					Else
						If $bDegug Then SetLog("BB: Slot : [" & String($i + 1) & "] Already Selected", $COLOR_DEBUG) ; ADDED By SM MOD
					EndIf
					If $bContinue Then
						$j = 0
						While Not BB_ColorCheck($aTroopSlot, $aSlotOff)
							If _Sleep($DELAYRUNBOT1) Then Return ; ADD Delay Before Reading Value So It would be make sure that it is clicked. - ADDED By SM MOD
							ClickP($aTroopSlot, 1, 0, "#0000")
							If $bIsBMachineAvailable Then ;After October Update When BMachine Present Troops Moves To Slightly Left
								$iTroopsTo = Number(getTroopCountBig($aTroopSlot[0], $aTroopSlot[1] - 7)) ; EDITED By SM MOD
								If $bDegug Then SetLog("BB: Troops Count [" & $iTroopsTo & "] In Slot : [" & String($i + 1) & "] at x,y " & $aTroopSlot[0] & "," & $aTroopSlot[1] - 7, $COLOR_DEBUG)
							Else
								$iTroopsTo = Number(getTroopCountBig($aTroopSlot[0] + 9, $aTroopSlot[1] - 7)) ; EDITED By SM MOD
								If $bDegug Then SetLog("BB: Troops Count [" & $iTroopsTo & "] In Slot : [" & String($i + 1) & "] at x:y " & $aTroopSlot[0] + 9 & "," & $aTroopSlot[1] - 7, $COLOR_DEBUG)
							EndIf
							If $bDegug Then SetLog("BB: Drop Troops - Slot : [" & String($i + 1) & "], Color: " & $cPixColor & ", Round : [" & String($j) & "], Troops Num : [" & $iTroopsTo & "]", $COLOR_DEBUG)
							BB_Attack($iSide, $cSideNames, $iTroopsTo)
							$j += 1
							If $j > 5 Then ExitLoop
							$cPixColor = _GetPixelColor($aTroopSlot[0], $aTroopSlot[1] - 7, True, "Troop Slot") ; 633 Is the White Pixel When Slot Is Selected
							If Not _ColorCheck($cPixColor, Hex(0xFFFFFF, 6), 0) Then ; Check If Slot Not Selected Exit
								If $bDegug Then SetLog("BB: Drop Troops - Slot : [" & String($i + 1) & "] All Troops Dropped.", $COLOR_DEBUG)
								If _Sleep($DELAYRUNBOT1) Then Return
								ExitLoop
							EndIf
						WEnd
						If _Sleep($DELAYRUNBOT1) Then Return
					EndIf
				Next

				; *-------------------------------------------------*
				; Battle Machine Deploy
				; *-------------------------------------------------*
				If $bIsBMachineAvailable Then
					BB_Mach_Deploy()
				EndIf

				; BB: Wait for Battle End
				Setlog("BB: Confirm Battle End [ok]", $COLOR_INFO)
				$j = 0
				While $j < $iWait64
					If _Sleep($DELAYRUNBOT1) Then Return
					$cPixColor = _GetPixelColor($aOkWaitBattle[0], $aOkWaitBattle[1], True)
					If _ColorCheck($cPixColor, Hex($aOkWaitBattle[2], 6), 20) Then $j = 32
					If _Sleep($DELAYRUNBOT1) Then Return
					$cPixColor = _GetPixelColor($aOkButtom[0], $aOkButtom[1], True)
					If _ColorCheck($cPixColor, Hex($aOkButtom[2], 6), 20) Then
						$j = $iWait64
					Else
						$j += 1
					EndIf
					BB_StatusMsg("Wait for Battle End" & " [ " & String($j) & " ]")
				WEnd

				If _Sleep($DELAYRUNBOT1) Then Return

				; If $aOkWaitBattle Exists
				$cPixColor = _GetPixelColor($aOkWaitBattle[0], $aOkWaitBattle[1], True)
				If _ColorCheck($cPixColor, Hex($aOkWaitBattle[2], 6), 20) Then
					If $bDegug Then SetLog("BB: Okay Buttom [no wait battle end], color: " & $cPixColor, $COLOR_DEBUG)
					ClickP($aOkWaitBattle, 1, 0, "#0000")
				EndIf

				If _Sleep($DELAYRUNBOT1) Then Return

				; wait $aOkButtom to appear
				$j = 0
				$cPixColor = _GetPixelColor($aOkButtom[0], $aOkButtom[1], True)
				While Not BB_ColorCheck($aOkButtom, $aOkButtomColor)
					If $bDegug Then BB_StatusMsg("Wait Okay Buttom. [Ok]. color: " & $cPixColor & " [ " & String($j) & " ]")
					If _Sleep($DELAYRUNBOT1) Then Return
					$j += 1
					If $j > $iWait128 Then ExitLoop
					$cPixColor = _GetPixelColor($aOkButtom[0], $aOkButtom[1], True)
				WEnd
				If $j < $iWait128 Then
					SetLog("BB: Click Buttom. [Ok]. color: " & $cPixColor & " [ " & String($j) & " ]", $COLOR_DEBUG)
					ClickP($aOkButtom, 1, 0, "#0000")
				Else
					SetLog("BB: Can't Find Buttom [Ok]. color: " & $cPixColor, $COLOR_ERROR)
				EndIf

				If _Sleep($DELAYRUNBOT1) Then Return

				; wait $aOkBatleEnd to appear
				If $j < $iWait64 Then
					$j = 0
					$cPixColor = _GetPixelColor($aOkBatleEnd[0], $aOkBatleEnd[1], True)
					While Not BB_ColorCheck($aOkBatleEnd, $aOkBatleEndColor)
						If $bDegug Then BB_StatusMsg("Wait Okay Buttom. [end]. color: " & $cPixColor & " [ " & String($j) & " ]")
						If _Sleep($DELAYRUNBOT1) Then Return
						$j += 1
						If $j > $iWait64 Then ExitLoop
						$cPixColor = _GetPixelColor($aOkBatleEnd[0], $aOkBatleEnd[1], True)
					WEnd
					If $j < $iWait64 Then
						SetLog("BB: Click Buttom [end], color: " & $cPixColor & " [ " & String($j) & " ]", $COLOR_DEBUG)
						ClickP($aOkBatleEnd, 1, 0, "#0000")
					Else
						SetLog("BB: Can't Find Buttom [End]. color: " & $cPixColor, $COLOR_ERROR)
					EndIf
				Else

					If _Sleep($DELAYRUNBOT1) Then Return
					ClickP($aAway, 1, 0, "#0000")

				EndIf

			EndIf

			If _Sleep($DELAYRUNBOT1) Then Return
			ClickP($aAway, 1, 0, "#0000")

		Else
			Setlog("Ignore BB Drop Trophies: [Not Needed] [ " & String($g_iTxtBB_DropTrophies) & " ]", $COLOR_INFO)
		EndIf
	Else
		Setlog("Ignore BB Drop Trophies [ Disabled ]", $COLOR_INFO)
	EndIf

	_Sleep($DELAYRUNBOT1)

EndFunc   ;==>BB_DropTrophies


; #FUNCTION# ====================================================================================================================
; Name ..........: BB_ColorCheck( $aInfo, $aColors )
; Description ...: Check an Array of Colors ( instead just one )
; Author ........: Chackal++
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func BB_ColorCheck($aInfo, $aColors)
	Local $i
	Local $cPixel
	Local $bResult = False
	Local $iLoop = UBound($aColors) - 1
	$cPixel = _GetPixelColor($aInfo[0], $aInfo[1], True, "BB_ColorCheck")
	For $i = 0 To $iLoop
		If _ColorCheck($cPixel, Hex($aColors[$i], 6), 20) Then
			$bResult = True
			ExitLoop
		EndIf
	Next
	Return $bResult
EndFunc   ;==>BB_ColorCheck

Func BB_StatusMsg($cTxt)
	_GUICtrlStatusBar_SetTextEx($g_hStatusBar, "BB Status: " & $cTxt)
EndFunc   ;==>BB_StatusMsg

Func ChkBB_DropTrophies()
	$g_bChkBB_DropTrophies = (GUICtrlRead($g_hChkBB_DropTrophies) = $GUI_CHECKED) ? 1 : 0
EndFunc   ;==>ChkBB_DropTrophies

Func TxtBB_DropTrophies()
	$g_iTxtBB_DropTrophies = GUICtrlRead($g_hTxtBB_DropTrophies)
EndFunc   ;==>TxtBB_DropTrophies

Func ChkBB_OnlyWithLoot()
	$g_bChkBB_OnlyWithLoot = (GUICtrlRead($g_hChkBB_OnlyWithLoot) = $GUI_CHECKED) ? 1 : 0
EndFunc   ;==>ChkBB_OnlyWithLoot
