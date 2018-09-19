; #FUNCTION# ====================================================================================================================
; Name ..........: Chatbot Text read (#-23)
; Description ...: This file is all related to READ CHAT
; Syntax ........:
; Parameters ....: ReadChat()
; Return values .: Last msg
; Author ........: Samikie (fragment of code.), rulesss and kychera (chatbot), boludoz (5/7/2018|17/7/2018)
; Modified ......: RK TEAM, boludoz (5/7/2018)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ReadChat()
; ===============================================================================================================================
Func ReadChat()
Local $g_iChatDebug = 0
Local $aButtonClanWindowOpen[9]   	    = [  8, 355,  28, 410,  16, 400, 0xC55115, 20, "=-= Open Chat Window"] ; main page, clan chat Button
Local $aButtonClanWindowClose[9]  	    = [321, 355, 342, 410, 330, 400, 0xC55115, 20, "=-= Close Chat Window"] ; main page, clan chat Button
Local $aButtonClanChatTab[9]    	  	    = [175,  14, 275,  30, 280,  30, 0x706C50, 20, "=-= Switch to Clan Channel"] ; Chat page, ClanChat Tab
Local $aButtonClanDonateScrollUp[9] 	    = [290, 100, 300, 112, 295, 100, 0xFFFFFF, 10, "=-= Donate Scroll Up"] ; Donate / Chat Page, Scroll up Button
Local $aButtonClanDonateScrollDown[9] 	= [290, 650, 300, 662, 295, 655, 0xFFFFFF, 10, "=-= Donate Scroll Down"] ; Donate / Chat Page, Scroll Down Button
Local $g_bChkExtraAlphabets = True, $g_bChkExtraChinese = True, $g_bChkExtraKorean = True; Russian, Chinese, Korean fix

	Setlog("Checking Clan Chat", $COLOR_INFO)


	Local $iLoopCount = 0
	Local $iCount = 0
	While 1
		;If Clan tab is selected.
		ForceCaptureRegion()
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(189, 24, False), Hex(0x706C50, 6), 20) Then ; color med gray
			ExitLoop
		EndIf
		;If Global tab is selected.
		If _ColorCheck(_GetPixelColor(189, 24, False), Hex(0x383828, 6), 20) Then ; Darker gray
			ClickP($aClanTab, 1, 0, "#0169") ; clicking clan tab
		EndIf
		;counter for time approx 3 sec max allowed for tab to open
		$iLoopCount += 1
		If $iLoopCount >= 5 Then ; allows for up to a sleep of 3000
			SetLog("Cannot switch to Clan Chat Tab")
			AndroidPageError("Chat read")
			Local $aButtonChatClose[4] = [330, 352 + $g_iMidOffsetY, 0xFFFFFF, 20]
			   If _ColorCheck(_GetPixelColor($aButtonChatClose[0], $aButtonChatClose[1], True), Hex($aButtonChatClose[2], 6), $aButtonChatClose[3]) Then
				  Click($aButtonChatClose[0], $aButtonChatClose[1], 1)
				  waitMainScreen()
			   EndIf
			Return False
		EndIf
		If _Sleep($DELAYDONATECC1) Then Return ; delay Allow 15x
	WEnd


		ForceCaptureRegion()
		_CaptureRegion2(260,85,272,624)
		Local $aLastResult[1][2]
		Local $sDirectory = @ScriptDir & "\imgxml\Chat\"
		Local $returnProps="objectpoints"
		Local $aCoor
		Local $aPropsValues
		Local $aCoorXY
		Local $result
		Local $sReturn = ""

		Local $iMax = 0
		Local $jMax = 0
		Local $i, $j, $k
		Local $ClanString

		Local $hHBitmapDivider = GetHHBitmapArea($g_hHBitmap2,0,0,10,539)

		Local $result = findMultiImage($hHBitmapDivider, $sDirectory ,"FV" ,"FV", 0, 0, 0 , $returnProps)
		If $hHBitmapDivider <> 0 Then GdiDeleteHBitmap($hHBitmapDivider)

		$iCount = 0
		If IsArray($result) then
			$iMax = UBound($result) -1
			For $i = 0 To $iMax
				$aPropsValues = $result[$i] ; should be return objectname,objectpoints,objectlevel
				If UBound($aPropsValues) = 1 then
					If $g_iChatDebug = 1 Then SetLog("$aPropsValues[0]: " & $aPropsValues[0], $COLOR_DEBUG)
					$aCoor = StringSplit($aPropsValues[0],"|",$STR_NOCOUNT) ; objectpoints, split by "|" to get multi coor x,y ; same image maybe can detect at different location.
					If IsArray($aCoor) Then
						For $j =  0 to UBound($aCoor) - 1
							$aCoorXY = StringSplit($aCoor[$j],",",$STR_NOCOUNT)
							ReDim $aLastResult[$iCount + 1][2]
							$aLastResult[$iCount][0] = Int($aCoorXY[0])
							$aLastResult[$iCount][1] = Int($aCoorXY[1]) + 82
							$iCount += 1
						Next
					EndIf
				EndIf
			Next
			If $iCount >= 1 Then
				_ArraySort($aLastResult, 1, 0, 0, 1) ; rearrange order by coor Y
				$iMax = UBound($aLastResult) -1
				If $g_iChatDebug = 1 Then SetLog("Total Chat Message: " & $iMax + 1, $COLOR_ERROR)
				_CaptureRegion2(0,0,287,732)
				For $i = 0 To $iMax
					If $g_bChkExtraAlphabets Then
						; Chat Request using "coc-latin-cyr" xml: Latin + Cyrillic derived alphabets / three paragraphs
						If $g_iChatDebug = 1 Then Setlog("Using OCR to read Latin and Cyrillic derived alphabets..", $COLOR_ACTION)
						$ClanString = ""
						$ClanString = getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 17, 280, 17, Default, Default, False)
						If $ClanString = "" Then
							$ClanString = getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 31, 280, 17, Default, Default, False)
						Else
							$ClanString &= " " & getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 31, 280, 17, Default, Default, False)
						EndIf
						If $ClanString = "" Or $ClanString = " " Then
							$ClanString = getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 44, 280, 17, Default, Default, False)
						Else
							$ClanString &= " " & getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 44, 280, 17, Default, Default, False)
						EndIf
						If _Sleep($DELAYDONATECC2) Then ExitLoop
					Else ; default
						; Chat Request using "coc-latinA" xml: only Latin derived alphabets / three paragraphs
						If $g_iChatDebug = 1 Then Setlog("Using OCR to read Latin derived alphabets..", $COLOR_ACTION)
						$ClanString = ""
						$ClanString = getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 17, 280, 17, Default, Default, False)
						If $ClanString = "" Then
							$ClanString = getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 31, 280, 17, Default, Default, False)
						Else
							$ClanString &= " " & getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 31, 280, 17, Default, Default, False)
						EndIf
						If $ClanString = "" Or $ClanString = " " Then
							$ClanString = getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 44, 280, 17, Default, Default, False)
						Else
							$ClanString &= " " & getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 44, 280, 17, Default, Default, False)
						EndIf
						If _Sleep($DELAYDONATECC2) Then ExitLoop
					EndIf
					; Chat Request using IMGLOC: Chinese alphabet / one paragraph
					If $g_bChkExtraChinese Then
						If $g_iChatDebug = 1 Then Setlog("Using OCR to read the Chinese alphabet..", $COLOR_ACTION)
						If $ClanString = "" Then
							$ClanString = getOcrAndCapture("chinese-bundle", 30, $aLastResult[$i][1] + 43, 160, 15, Default, True, False)
						Else
							$ClanString &= " " & getOcrAndCapture("chinese-bundle", 30, $aLastResult[$i][1] + 43, 160, 15, Default, True, False)
						EndIf
						If _Sleep($DELAYDONATECC2) Then ExitLoop
					EndIf
					; Chat Request using IMGLOC: Korean alphabet / one paragraph
					If $g_bChkExtraKorean Then
						If $g_iChatDebug = 1 Then Setlog("Using OCR to read the Korean alphabet..", $COLOR_ACTION)
						If $ClanString = "" Then
							$ClanString = getOcrAndCapture("korean-bundle", 30, $aLastResult[$i][1] + 43, 160, 15, Default, True, False)
						Else
							$ClanString &= " " & getOcrAndCapture("korean-bundle", 30, $aLastResult[$i][1] + 43, 160, 15, Default, True, False)
						EndIf
						If _Sleep($DELAYDONATECC2) Then ExitLoop
					EndIf
					; Chat Request using IMGLOC: Persian alphabet / one paragraph
					;If $g_bChkExtraPersian Then
					;	If $g_iChatDebug = 1 Then Setlog("Using OCR to read the Persian alphabet..", $COLOR_ACTION)
					;	If $ClanString = "" Then
					;		$ClanString = getChatStringPersianMod(30, $aLastResult[$i][1] + 36)
					;	Else
					;		$ClanString &= " " & getChatStringPersianMod(30, $aLastResult[$i][1] + 36)
					;	EndIf
					;	If _Sleep($DELAYDONATECC2) Then ExitLoop
					;EndIf
					;If $ichkEnableCustomOCR4CCRequest = 1 Then
					;	If $g_iChatDebug = 1 Then Setlog("Using custom OCR to read cc request message..", $COLOR_ACTION)
					;	Local $hHBitmapCustomOCR = GetHHBitmapArea($g_hHBitmap2,30, $aLastResult[$i][1] + 43, 190, $aLastResult[$i][1] + 43 + 15)
					;	If $ClanString = "" Then
					;		$ClanString = getMyOcr($hHBitmapCustomOCR, 30, $aLastResult[$i][1] + 43,160,15,"ccrequest",False,True)
					;	Else
					;		$ClanString &= " " & getMyOcr($hHBitmapCustomOCR, 30, $aLastResult[$i][1] + 43,160,15,"ccrequest",False,True)
					;	EndIf
;
					;	If $hHBitmapCustomOCR <> 0 Then GdiDeleteHBitmap($hHBitmapCustomOCR)
					;EndIf

					If $ClanString = "" Or $ClanString = " " Then
						If $g_iChatDebug = 1 Then SetLog("Unable to read Chat!", $COLOR_ERROR)
						ExitLoop
						Else
						SetLog("Chat: " & $ClanString)
						ExitLoop	
						EndIf
				Next
			EndIf
		Else
			If $g_iChatDebug = 1 Then SetLog("divide not found.", $COLOR_DEBUG)
		EndIf
		If $g_hHBitmap2 <> 0 Then GdiDeleteHBitmap($g_hHBitmap2)
		Return $ClanString
		EndFunc