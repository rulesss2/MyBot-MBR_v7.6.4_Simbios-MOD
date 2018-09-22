; #FUNCTION# ====================================================================================================================
; Name ..........: NEW Chatbot by SM MOD
; Description ...:
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: by SM MOD
; Modified ......: Fahid.Mahmood (14-09-2018)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================

#include <Process.au3>
#include <Array.au3>
#include <WinAPIEx.au3>
#include <EditConstants.au3>

Func ChatbotReadSettings()
	$g_iChkClanMessages = StringSplit(IniRead($g_sProfileConfigPath, "Chatbot", "genericMsgClan", "Testing on Chat|Hey all"), "|", 2)
	$g_iChkClanResponses0 = StringSplit(IniRead($g_sProfileConfigPath, "Chatbot", "responseMsgClan", "keyword:Response|hello:Hi, Welcome to the clan|hey:Hey, how's it going?"), "|", 2)
	Global $g_iChkClanResponses1[UBound($g_iChkClanResponses0)][2] ;
	For $a = 0 To UBound($g_iChkClanResponses0) - 1
		$TmpResp = StringSplit($g_iChkClanResponses0[$a], ":", 2)
		If UBound($TmpResp) > 0 Then
			$g_iChkClanResponses1[$a][0] = $TmpResp[0]
		Else
			$g_iChkClanResponses1[$a][0] = "<invalid>"
		EndIf
		If UBound($TmpResp) > 1 Then
			$g_iChkClanResponses1[$a][1] = $TmpResp[1]
		Else
			$g_iChkClanResponses1[$a][1] = "<undefined>"
		EndIf
	Next

	$g_iChkClanResponses = $g_iChkClanResponses1

	$g_iChkGlobalMessages1 = StringSplit(IniRead($g_sProfileConfigPath, "Chatbot", "globalMsg1", "War Clan Recruiting|Active War Clan accepting applications"), "|", 2)
	$g_iChkGlobalMessages2 = StringSplit(IniRead($g_sProfileConfigPath, "Chatbot", "globalMsg2", "Join now|Apply now"), "|", 2)

	;due using this function _StringRemoveBlanksFromSplit we need to update new values to gui
	GUICtrlSetData($g_hTxtEditGlobalMessages1, _ArrayToString($g_iChkGlobalMessages1, @CRLF))
	GUICtrlSetData($g_hTxtEditGlobalMessages2, _ArrayToString($g_iChkGlobalMessages2, @CRLF))
	GUICtrlSetData($g_hTxtEditResponses, _ArrayToString($g_iChkClanResponses, ":", -1, -1, @CRLF))
	GUICtrlSetData($g_hTxtEditGeneric, _ArrayToString($g_iChkClanMessages, @CRLF))
EndFunc   ;==>ChatbotReadSettings


Func chkGlobalChat()
	$g_bChatGlobal = True
	If GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkGlobalScramble, $GUI_ENABLE)
		GUICtrlSetState($g_hChkDelayTime, $GUI_ENABLE)
		GUICtrlSetState($g_hChkSwitchLang, $GUI_ENABLE)
		GUICtrlSetState($g_hCmbLang, $GUI_SHOW)
		GUICtrlSetState($g_hChkRusLang, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtEditGlobalMessages1, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtEditGlobalMessages2, $GUI_ENABLE)
	Else
		$g_bChatGlobal = False
		GUICtrlSetState($g_hChkGlobalScramble, $GUI_DISABLE)
		GUICtrlSetState($g_hChkDelayTime, $GUI_DISABLE)
		GUICtrlSetState($g_hChkSwitchLang, $GUI_DISABLE)
		GUICtrlSetState($g_hCmbLang, $GUI_INDETERMINATE)
		GUICtrlSetState($g_hChkRusLang, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtEditGlobalMessages1, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtEditGlobalMessages2, $GUI_DISABLE)
	EndIf
	If GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED And GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
		GUICtrlSetState($g_hCmbLang, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hCmbLang, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkGlobalChat

Func chkDelayTime()
	GUICtrlSetState($g_hTxtDelayTime, GUICtrlRead($g_hChkDelayTime) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkDelayTime

Func chkGlobalScramble()
	If GUICtrlRead($g_hChkGlobalScramble) = $GUI_CHECKED Then
		$g_bScrambleGlobal = True
	Else
		$g_bScrambleGlobal = False
	EndIf
EndFunc   ;==>chkGlobalScramble

Func chkSwitchLang()
	If GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
		$g_bSwitchLang = True
	Else
		$g_bSwitchLang = False
	EndIf
	If GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED Then
		GUICtrlSetState($g_hCmbLang, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hCmbLang, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkSwitchLang

Func chkClanChat()
	$g_bChatClan = True
	If GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED Then
		GUICtrlSetState($g_hChkUseResponses, $GUI_ENABLE)
		GUICtrlSetState($g_hChkUseGeneric, $GUI_ENABLE)
		GUICtrlSetState($g_hChkChatNotify, $GUI_ENABLE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_ENABLE)
		GUICtrlSetState($g_hChkCleverbot, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtEditResponses, $GUI_ENABLE)
		GUICtrlSetState($g_hTxtEditGeneric, $GUI_ENABLE)
	Else
		$g_bChatClan = False
		GUICtrlSetState($g_hChkUseResponses, $GUI_DISABLE)
		GUICtrlSetState($g_hChkUseGeneric, $GUI_DISABLE)
		GUICtrlSetState($g_hChkChatNotify, $GUI_DISABLE)
		GUICtrlSetState($g_hChkPbSendNewChats, $GUI_DISABLE)
		GUICtrlSetState($g_hChkCleverbot, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtEditResponses, $GUI_DISABLE)
		GUICtrlSetState($g_hTxtEditGeneric, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkClanChat

Func chkUseResponses()
	If GUICtrlRead($g_hChkUseResponses) = $GUI_CHECKED Then
		$g_bClanUseResponses = True
	Else
		$g_bClanUseResponses = False
	EndIf
EndFunc   ;==>chkUseResponses

Func chkUseGeneric()
	If GUICtrlRead($g_hChkUseGeneric) = $GUI_CHECKED Then
		$g_bClanAlwaysMsg = True
	Else
		$g_bClanAlwaysMsg = False
	EndIf
EndFunc   ;==>chkUseGeneric

Func chkChatNotify()
	If GUICtrlRead($g_hChkChatNotify) = $GUI_CHECKED Then
		$g_bUseNotify = True
	Else
		$g_bUseNotify = False
	EndIf
EndFunc   ;==>chkChatNotify

Func chkPbSendNewChats()
	If GUICtrlRead($g_hChkPbSendNewChats) = $GUI_CHECKED Then
		$g_bPbSendNew = True
	Else
		$g_bPbSendNew = False
	EndIf
EndFunc   ;==>chkPbSendNewChats

Func chkCleverbot()
	If GUICtrlRead($g_hChkCleverbot) = $GUI_CHECKED Then
		$g_bCleverbot = True
	Else
		$g_bCleverbot = False
	EndIf
EndFunc   ;==>chkCleverbot

Func chkRusLang()
	If GUICtrlRead($g_hChkRusLang) = $GUI_CHECKED Then
		$g_bRusLang = True
	Else
		$g_bRusLang = False
	EndIf
EndFunc   ;==>chkRusLang

Func ChatGuiEditUpdate()

	; how 2 be lazy 101 =======
	$glb1 = StringReplace(GUICtrlRead($g_hTxtEditGlobalMessages1), @CRLF, "|")
	$glb2 = StringReplace(GUICtrlRead($g_hTxtEditGlobalMessages2), @CRLF, "|")

	$cResp = StringReplace(GUICtrlRead($g_hTxtEditResponses), @CRLF, "|")
	$cGeneric = StringReplace(GUICtrlRead($g_hTxtEditGeneric), @CRLF, "|")

	_StringRemoveBlanksFromSplit($glb1) ; Clean empty messages to avoid chat bot to slect empty msg
	_StringRemoveBlanksFromSplit($glb2)
	_StringRemoveBlanksFromSplit($cResp)
	_StringRemoveBlanksFromSplit($cGeneric)

	;Need to save live changes into config.
	IniWrite($g_sProfileConfigPath, "Chatbot", "globalMsg1", $glb1)
	IniWrite($g_sProfileConfigPath, "Chatbot", "globalMsg2", $glb2)
	IniWrite($g_sProfileConfigPath, "Chatbot", "genericMsgClan", $cGeneric)
	IniWrite($g_sProfileConfigPath, "Chatbot", "responseMsgClan", $cResp)
	;	; =========================
	ChatbotReadSettings()
EndFunc   ;==>ChatGuiEditUpdate

; FUNCTIONS ================================================
; All of the following return True if the script should
; continue running, and false otherwise
Func ChatbotChatOpen() ; open the chat area
	ClickP($aAway, 1, 0, "#0000") ;Click Away to prevent any pages on top
	If _Sleep(300) Then Return ;Add Small delay if any thing is on top of main page will be gone.
	ForceCaptureRegion()
	If _CheckColorPixel($g_aButtonChatWindowOpen[2], $g_aButtonChatWindowOpen[3], $g_aButtonChatWindowOpen[4], $g_aButtonChatWindowOpen[5], $g_bCapturePixel, "ChatbotChatOpen") Then ;Check if Chat Button Exists
		Click($g_aButtonChatWindowOpen[0], $g_aButtonChatWindowOpen[1], 1) ;Click on chat button
		If _Wait4Pixel($g_aButtonChatWindowClose[2], $g_aButtonChatWindowClose[3], $g_aButtonChatWindowClose[4], $g_aButtonChatWindowClose[5], 2000) = False Then ;Wait for chat to be open if it is not opened in 2000 sec show error
			SetLog("Chatbot: Sorry, Chat Window Did Not Opened.", $COLOR_ERROR)
			Return False
		EndIf
		SetLog("Chatbot: Chat Window Opened.", $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Unable To Find Chat Button In MainScreen.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotChatOpen

Func ChatbotSelectClanChat() ; select clan tab
	Click($g_aButtonChatSelectTabClan[0], $g_aButtonChatSelectTabClan[1], 1) ; switch to Clan chat
	If _Wait4Pixel($g_aButtonChatSelectTabClan[2], $g_aButtonChatSelectTabClan[3], $g_aButtonChatSelectTabClan[4], $g_aButtonChatSelectTabClan[5], 2000) = False Then ;Wait for clan chat tab to be selected if it is not opened in 2000 sec show error
		SetLog("Chatbot: Sorry, Clan Chat Tab Not Selected.", $COLOR_ERROR)
		Return False
	Else
		SetLog("Chatbot: Clan Chat Tab Selected.", $COLOR_SUCCESS)
		Return True
	EndIf
EndFunc   ;==>ChatbotSelectClanChat

Func ChatbotCheckIfUserIsInClan() ; check if user is in a clan before doing chat
	If _Wait4Pixel($g_aButtonChatJoinClan[0], $g_aButtonChatJoinClan[1], $g_aButtonChatJoinClan[2], $g_aButtonChatJoinClan[3], 1000) = True Then ;Wait for 500ms to check if user is in clan or not
		SetLog("Chatbot: Sorry, You Are Not In A Clan You Can't Chat.", $COLOR_ERROR)
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>ChatbotCheckIfUserIsInClan

Func ChatbotSelectGlobalChat() ; select global tab
	Click($g_aButtonChatSelectTabGlobal[0], $g_aButtonChatSelectTabGlobal[1], 1) ; switch to global
	If _Wait4Pixel($g_aButtonChatSelectTabGlobal[2], $g_aButtonChatSelectTabGlobal[3], $g_aButtonChatSelectTabGlobal[4], $g_aButtonChatSelectTabGlobal[5], 2000) = False Then ;Wait for global tab to be selected if it is not opened in 2000 sec show error
		SetLog("Chatbot: Sorry, Global Tab Not Selected.", $COLOR_ERROR)
		Return False
	Else
		SetLog("Chatbot: Global Tab Selected.", $COLOR_SUCCESS)
		Return True
	EndIf
EndFunc   ;==>ChatbotSelectGlobalChat

Func ChatbotChatClose() ; close chat area
	_Sleep(1500) ;Delay Added Just For User To See Bot Typed the msg. Else This Delay Is Not Needed
	Click($g_aButtonChatWindowClose[0], $g_aButtonChatWindowClose[1], 1) ; close chat
	If _Wait4PixelGone($g_aButtonChatWindowClose[2], $g_aButtonChatWindowClose[3], $g_aButtonChatWindowClose[4], $g_aButtonChatWindowClose[5], 2000) Then ;Wait for chat dialog to be disappear if it is not disappeared in 2000 sec show error
		SetLog("Chatbot: Close Chat Window.", $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Unable To Close The Chat.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotChatClose


Func ChatbotSelectChatInput($fromTab) ; select the textbox for global chat or Clan Chat
	Click($g_aButtonChatSelectTextBox[0], $g_aButtonChatSelectTextBox[1], 1) ; select the textbox
	If _Wait4Pixel($g_aButtonChatSelectTextBox[2], $g_aButtonChatSelectTextBox[3], $g_aButtonChatSelectTextBox[4], $g_aButtonChatSelectTextBox[5], 2000) = False Then ;Wait for Textbox to be appear if it is not opened in 2000 sec show error
		SetLog("Chatbot: Sorry, " & $fromTab & " Chat TextBox Is Not Opened.", $COLOR_ERROR)
		Return False
	Else
		SetLog("Chatbot: " & $fromTab & " Chat TextBox Appeared.", $COLOR_SUCCESS)
		Return True
	EndIf
EndFunc   ;==>ChatbotSelectChatInput

;============================================
;+++++++++++++Kychera Modified +++++++++++++++
Func ChatbotChatInput($g_sMessage)
	SetLog("Chatbot: Type MSG : " & $g_sMessage, $COLOR_SUCCESS)
	If _Sleep(1000) Then Return
	Click(33, 707, 1)
	If $g_bRusLang = True Then
		SetLog("Chat Send In Russia", $COLOR_BLUE)
		AutoItWinSetTitle('MyAutoItTitle')
		_WinAPI_SetKeyboardLayout(WinGetHandle(AutoItWinGetTitle()), 0x0419)
		_Sleep(500)
		ControlFocus($g_hAndroidWindow, "", "")
		SendKeepActive($g_hAndroidWindow)
		_Sleep(500)
		;Opt("SendKeyDelay", 1000)
		AutoItSetOption("SendKeyDelay", 50)
		_SendExEx($g_sMessage)
		SendKeepActive("")
	Else
		_Sleep(500)
		SendText($g_sMessage)
	EndIf
	Return True
EndFunc   ;==>ChatbotChatInput
;+++++++++++++++++++++++++++++++++++++++++++++
;Support for the Russian language.
;=============================================

Func ChatbotSendChat($fromTab) ; click send for global or clan chat
	Click($g_aButtonChatSendButton[0], $g_aButtonChatSendButton[1], 1) ; send
	If _Wait4PixelGone($g_aButtonChatSendButton[2], $g_aButtonChatSendButton[3], $g_aButtonChatSendButton[4], $g_aButtonChatSendButton[5], 2000) Then ;Wait for Textbox to be disappear if it is not gone in 2000 sec show error
		Return True
	Else
		SetLog("Chatbot: Sorry, " & $fromTab & " Chat Send Button Not Clicked.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSendChat

Func ChatbotStartTimer()
	$ChatbotStartTime = TimerInit()
EndFunc   ;==>ChatbotStartTimer

Func ChatbotIsInterval()
	Local $Time_Difference = TimerDiff($ChatbotStartTime)
	If $Time_Difference > $ChatbotReadInterval * 1000 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>ChatbotIsInterval

Func ChatbotIsLastChatNew() ; returns true if the last chat was not by you, false otherwise
	_CaptureRegion()
	For $x = 38 To 261
		If _ColorCheck(_GetPixelColor($x, 129), Hex(0x78BC10, 6), 5) Then Return True ; detect the green menu button
	Next
	Return False
EndFunc   ;==>ChatbotIsLastChatNew

Func ChatbotNotifySendChat()
	If Not $g_bUseNotify Then Return

	Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
	Local $Time = @HOUR & "." & @MIN & "." & @SEC
	_CaptureRegion(0, 0, 320, 675)
	Local $ChatFile = $Date & "__" & $Time & ".jpg" ; separator __ is need  to not have conflict with saving other files if $TakeSS = 1 and $chkScreenshotLootInfo = 0
	_GDIPlus_ImageSaveToFile($g_hBitmap, $g_sProfileLootsPath & $ChatFile)
	_GDIPlus_ImageDispose($g_hBitmap)
	;push the file
	SetLog("Chatbot: Sent chat image", $COLOR_GREEN)
	;========Modified Kychera===========
	NotifyPushFileToTelegram($ChatFile, "Loots", "image/jpeg", $g_sNotifyOrigin & " | Last Clan Chats" & "\n" & $ChatFile)
	;===================
	;wait a second and then delete the file
	If _Sleep($DELAYPUSHMSG2) Then Return
	Local $iDelete = FileDelete($g_sProfileLootsPath & $ChatFile)
	If Not ($iDelete) Then SetLog("Chatbot: Failed to delete temp file", $COLOR_RED)
EndFunc   ;==>ChatbotNotifySendChat

Func ChatbotNotifyQueueChat($Chat)
	If Not $g_bUseNotify Then Return
	_ArrayAdd($ChatbotQueuedChats, $Chat)
EndFunc   ;==>ChatbotNotifyQueueChat

Func ChatbotNotifyQueueChatRead()
	If Not $g_bUseNotify Then Return
	$ChatbotReadQueued = True
EndFunc   ;==>ChatbotNotifyQueueChatRead

Func ChatbotNotifyStopChatRead()
	If Not $g_bUseNotify Then Return
	$ChatbotReadInterval = 0
	$ChatbotIsOnInterval = False
EndFunc   ;==>ChatbotNotifyStopChatRead

Func ChatbotNotifyIntervalChatRead($Interval)
	If Not $g_bUseNotify Then Return
	$ChatbotReadInterval = $Interval
	$ChatbotIsOnInterval = True
	ChatbotStartTimer()
EndFunc   ;==>ChatbotNotifyIntervalChatRead


; ======================================== LANGUAGE CHANGE LOGIC STARTS========================================

Func ChangeLanguageLifeCycle($lButtonLanguage, $lngMsg) ;Call this function when wants to change language
	If Not ChatbotSettingOpen() Then Return ;First Open Setting
	If Not ChatbotClickLanguageButton() Then ;Second Click Language Button
		ChatbotSettingClose()
		Return
	EndIf

	If Not ChangeLanguageForChatBot($lButtonLanguage, $lngMsg) Then ;Third Select Language Which You Want To Switch
		ChatbotSettingClose()
		Return
	EndIf

	If Not ChangeLanguagePressOk($lngMsg) Then ; Fourth Press OK On Lanugage Select Dialog
		ClickP($aAway, 1, 0, "#0000") ;If Dialog unable to be clicked on means something bad happened press away
		Return
	Else
		Sleep(3000)
		waitMainScreen()
	EndIf
EndFunc   ;==>ChangeLanguageLifeCycle

Func ChatbotSettingOpen() ; Open the Settings
	ClickP($aAway, 1, 0, "#0000") ;Click Away to prevent any pages on top
	If _Sleep(300) Then Return ;Add Small delay if any thing is on top of main page will be gone.
	ForceCaptureRegion()
	If _CheckColorPixel($g_aButtonLangSetting[2], $g_aButtonLangSetting[3], $g_aButtonLangSetting[4], $g_aButtonLangSetting[5], $g_bCapturePixel, "ChatbotSettingOpen") Then ;Check if Setting Button Exists
		Click($g_aButtonLangSetting[0], $g_aButtonLangSetting[1], 1) ;Click on Setting button
		If _Wait4Pixel($g_aButtonLangSettingClose[2], $g_aButtonLangSettingClose[3], $g_aButtonLangSettingClose[4], $g_aButtonLangSettingClose[5], 2000) = False Then ;Wait for Settings button to open if it is not opened in 2000 sec show error
			SetLog("Chatbot: Sorry, Settings Did Not Opened.", $COLOR_ERROR)
			Return False
		EndIf
		SetLog("Chatbot: Main Settings Opened.", $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Unable To Find Settings Button In MainScreen.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSettingOpen

Func ChatbotClickLanguageButton() ; Click on language button in settings
	Click($g_aButtonLangSettingSelectLang[0], $g_aButtonLangSettingSelectLang[1], 1) ; Click on language button in settings
	If _Wait4Pixel($g_aButtonLangSettingBackLang[2], $g_aButtonLangSettingBackLang[3], $g_aButtonLangSettingBackLang[4], $g_aButtonLangSettingBackLang[5], 2000) = False Then ;Wait for language page to be opened it is not opened in 2000 sec show error
		SetLog("Chatbot: Sorry, Language Screen Not Opened.", $COLOR_ERROR)
		Return False
	Else
		SetLog("Chatbot: Language Settings Opened", $COLOR_SUCCESS)
		Return True
	EndIf
EndFunc   ;==>ChatbotClickLanguageButton

Func ChatbotSettingClose() ; close settings
	_Sleep(1000) ;Delay Added Just For User To See Bot Did Ok. Else This Delay Is Not Needed
	Click($g_aButtonLangSettingClose[0], $g_aButtonLangSettingClose[1], 1) ; close chat
	If _Wait4PixelGone($g_aButtonLangSettingClose[2], $g_aButtonLangSettingClose[3], $g_aButtonLangSettingClose[4], $g_aButtonLangSettingClose[5], 2000) Then ;Wait for setting dialog to be disappear if it is not disappeared in 2000 sec show error
		SetLog("Chatbot: Close Language Settings Window.", $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Unable To Close The Settings.", $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChatbotSettingClose

Func ChangeLanguageForChatBot($lButtonLanguage, $lngMsg) ; Select Language Which You Want To Switch and click on that
	SetLog("Chatbot: Switching language " & $lngMsg, $COLOR_GREEN)
	If $lngMsg == "EN" Then
		If _Sleep(500) Then Return
		ClickDrag(775, 180, 775, 440)
		If _Sleep(1500) Then Return
	EndIf
	Click($lButtonLanguage[0], $lButtonLanguage[1], 1) ; Click on language button in settings
	If _Wait4Pixel($g_aButtonLangSettingOk[2], $g_aButtonLangSettingOk[3], $g_aButtonLangSettingOk[4], $g_aButtonLangSettingOk[5], 2000) = False Then ;Wait for language Dialog to be appear in 2000 sec show error
		SetLog("Chatbot: Sorry, Lanugage Change Dialog Does Not Appear May Be You Are Already In : " & $lngMsg, $COLOR_ERROR)
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>ChangeLanguageForChatBot

Func ChangeLanguagePressOk($lngMsg) ;Press OK On Lanugage Select Dialog
	Click($g_aButtonLangSettingOk[0], $g_aButtonLangSettingOk[1], 1) ; Click on language button in settings
	If _Wait4PixelGone($g_aButtonLangSettingOk[2], $g_aButtonLangSettingOk[3], $g_aButtonLangSettingOk[4], $g_aButtonLangSettingOk[5], 2000) Then ;Wait for language Dialog to be appear in 2000 sec show error
		SetLog("Chatbot: Language Successfully Changed To : " & $lngMsg, $COLOR_SUCCESS)
		Return True
	Else
		SetLog("Chatbot: Sorry, Unable To Change Language : " & $lngMsg, $COLOR_ERROR)
		Return False
	EndIf
EndFunc   ;==>ChangeLanguagePressOk



; ======================================== LANGUAGE CHANGE LOGIC END ========================================

; ======================================== MAIN SCRIPT ========================================

Func DelayTime($chatType)
	If $chatType = "GLOBAL" Then
		If $g_sGlobalChatLastMsgSentTime = "" Then ;If GlobalLastMsgSentTime sent time is empty means it's first time sms allow it
			Return True
		Else
			Local $sDateTimeDiffOfLastMsgInMin = _DateDiff("s", $g_sGlobalChatLastMsgSentTime, _NowCalc()) / 60 ;For getting float value of minutes(s) we divided the diffsec by 60
			SetDebugLog("$g_iTxtDelayTime = " & $g_iTxtDelayTime)
			SetDebugLog("$g_sGlobalChatLastMsgSentTime = " & $g_sGlobalChatLastMsgSentTime & ", $sDateTimeDiffOfLastMsgInMin = " & $sDateTimeDiffOfLastMsgInMin)
			If $sDateTimeDiffOfLastMsgInMin > $g_iTxtDelayTime Then ;If GlobalLastMsgSentTime sent time is empty means it's first time sms
				Return True
			Else
				;----------- LOGIC JUST FOR BEAUTIFUL TIME LOG -------------------
				Local $hour = 0, $min = 0, $sec = 0
				Local $sDateTimeDiffOfLastMsgInSec = _DateDiff("s", _NowCalc(), _DateAdd('n', $g_iTxtDelayTime, $g_sGlobalChatLastMsgSentTime))
				SetDebugLog("$sDateTimeDiffOfLastMsgInSec = " & $sDateTimeDiffOfLastMsgInSec)
				_TicksToTime($sDateTimeDiffOfLastMsgInSec * 1000, $hour, $min, $sec)
				;----------- LOGIC JUST FOR BEAUTIFUL TIME LOG -------------------

				SetLog("Chatbot: Skip sending chats to global chat", $COLOR_INFO)
				SetLog("Delay Time " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec) & " left before sending new msg.", $COLOR_INFO)
				Return False
			EndIf
		EndIf
	EndIf

EndFunc   ;==>DelayTime

Func ChatbotMessage() ; run the chatbot

	If $g_bDelayTime = False And $g_bChatGlobal Then
		ChatGlobal()
	EndIf

	If $g_bDelayTime = True And $g_bChatGlobal Then
		Local $iSendChatGlobalDelay = DelayTime("GLOBAL")
		If $iSendChatGlobalDelay = True Then
			ChatGlobal()
			$g_sGlobalChatLastMsgSentTime = _NowCalc() ;Store msg sent time
		EndIf
	EndIf

	If $g_bChatClan Then
		If Not ChatbotChatOpen() Then Return
		SetLog("Chatbot: Sending chats to clan", $COLOR_GREEN)
		If Not ChatbotSelectClanChat() Then
			ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
			Return
		EndIf
		If Not ChatbotCheckIfUserIsInClan() Then
			ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
			Return
		EndIf
		Local $SentClanChat = False
		_Sleep(2000)
		If $ChatbotReadQueued Then
			ChatbotNotifySendChat()
			$ChatbotReadQueued = False
			$SentClanChat = True
		ElseIf $ChatbotIsOnInterval Then
			If ChatbotIsInterval() Then
				ChatbotStartTimer()
				ChatbotNotifySendChat()
				$SentClanChat = True
			EndIf
		EndIf

		If UBound($ChatbotQueuedChats) > 0 Then
			SetLog("Chatbot: Sending Notify chats", $COLOR_GREEN)

			For $a = 0 To UBound($ChatbotQueuedChats) - 1
				Local $ChatToSend = $ChatbotQueuedChats[$a]
				If Not ChatbotSelectChatInput("Clan") Then
					ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
					Return
				EndIf
				;===Modified Kychera=====
				If Not ChatbotChatInput(_Encoding_JavaUnicodeDecode($ChatToSend)) Then
					ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
					Return
				EndIf
				;========================
				If Not ChatbotSendChat("Clan") Then
					ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
					Return
				EndIf
			Next

			Dim $Tmp[0] ; clear queue
			$ChatbotQueuedChats = $Tmp
			_Sleep(2000)
			ChatbotNotifySendChat()

			If Not ChatbotChatClose() Then Return
			SetLog("Chatbot: Done", $COLOR_GREEN)
			Return
		EndIf

		If Not ChatbotIsLastChatNew() Then
			; get text of the latest message
			Local $sLastChat = ReadChat()
			Local $ChatMsg = StringStripWS($sLastChat, 7)
			SetLog("Found chat message: " & $ChatMsg, $COLOR_GREEN)
			Local $SentMessage = False

			If $ChatMsg = "" Or $ChatMsg = " " Then
				If $g_bClanAlwaysMsg Then
					If Not ChatbotSelectChatInput("Clan") Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
					If Not ChatbotChatInput($g_iChkClanMessages[Random(0, UBound($g_iChkClanMessages) - 1, 1)]) Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
					If Not ChatbotSendChat("Clan") Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
					$SentMessage = True
				EndIf
			EndIf

			If $g_bClanUseResponses And Not $SentMessage Then
				For $a = 0 To UBound($g_iChkClanResponses) - 1
					If StringInStr($ChatMsg, $g_iChkClanResponses[$a][0]) Then
						Local $Response = $g_iChkClanResponses[$a][1]
						SetLog("Sending response: " & $Response, $COLOR_GREEN)
						If Not ChatbotSelectChatInput("Clan") Then
							ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
							Return
						EndIf
						If Not ChatbotChatInput($Response) Then
							ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
							Return
						EndIf
						If Not ChatbotSendChat("Clan") Then
							ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
							Return
						EndIf
						$SentMessage = True
						ExitLoop
					EndIf
				Next
			EndIf

			If ($g_bCleverbot = 1) And Not $SentMessage Then
				Local $Response = runHelper($ChatMsg, $g_bCleverbot)
				If Not $Response = False Or Not $ChatMsg = "" Or Not $ChatMsg = " " Then
					;If Not _Encoding_JavaUnicodeDecode($sString) Then Return
					SetLog("Got cleverbot response: " & $Response, $COLOR_GREEN)
					If Not ChatbotSelectChatInput("Clan") Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
					If Not ChatbotChatInput($Response) Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
					If Not ChatbotSendChat("Clan") Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
					$SentMessage = True
				EndIf
			EndIf
			If Not $SentMessage Then
				If $g_bClanAlwaysMsg Then
					If Not ChatbotSelectChatInput("Clan") Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
					If Not ChatbotChatInput($g_iChkClanMessages[Random(0, UBound($g_iChkClanMessages) - 1, 1)]) Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
					If Not ChatbotSendChat("Clan") Then
						ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
						Return
					EndIf
				EndIf
			EndIf

			; send it via Notify if it's new
			; putting the code here makes sure the (cleverbot, specifically) response is sent as well :P
			If $g_bUseNotify And $g_bPbSendNew Then
				If Not $SentClanChat Then ChatbotNotifySendChat()
			EndIf
		ElseIf $g_bClanAlwaysMsg Then
			If Not ChatbotSelectChatInput("Clan") Then
				ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
				Return
			EndIf
			If Not ChatbotChatInput($g_iChkClanMessages[Random(0, UBound($g_iChkClanMessages) - 1, 1)]) Then
				ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
				Return
			EndIf
			If Not ChatbotSendChat("Clan") Then
				ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
				Return
			EndIf
		EndIf

		If Not ChatbotChatClose() Then Return
	EndIf
	If $g_bChatGlobal Then
		SetLog("Chatbot: Done chatting", $COLOR_GREEN)
	ElseIf $g_bChatClan Then
		SetLog("Chatbot: Done chatting", $COLOR_GREEN)
	EndIf
EndFunc   ;==>ChatbotMessage

Func ChatGlobal() ; run the chatbot
	If $g_bChatGlobal Then
		SetLog("Chatbot: Will Send Global Chat.", $COLOR_INFO)
	ElseIf $g_bChatClan Then
		SetLog("Chatbot: Will Send Clan Chat.", $COLOR_INFO)
	EndIf
	If $g_bChatGlobal Then
		;========================Kychera modified==========================================


		If $g_bSwitchLang = True Then
			Local $lButtonLanguage = $g_aButtonLanguageEN ;By default English Language.
			Local $lngMsg = GUICtrlRead($g_hCmbLang)
			Switch GUICtrlRead($g_hCmbLang) ; Just Slect Button Coridnates for language which you want to switch
				Case "FR"
					$lButtonLanguage = $g_aButtonLanguageFRA
				Case "DE"
					$lButtonLanguage = $g_aButtonLanguageDE
				Case "ES"
					$lButtonLanguage = $g_aButtonLanguageES
				Case "IT"
					$lButtonLanguage = $g_aButtonLanguageITA
				Case "NL"
					$lButtonLanguage = $g_aButtonLanguageNL
				Case "NO"
					$lButtonLanguage = $g_aButtonLanguageNO
				Case "PR"
					$lButtonLanguage = $g_aButtonLanguagePR
				Case "TR"
					$lButtonLanguage = $g_aButtonLanguageTR
				Case "RU"
					$lButtonLanguage = $g_aButtonLanguageRU
			EndSwitch
			ChangeLanguageLifeCycle($lButtonLanguage, $lngMsg) ;Switch Language
		EndIf
		;======================================================================================
		If Not ChatbotChatOpen() Then Return

		SetLog("Chatbot: Sending chats to global.", $COLOR_GREEN)
		; assemble a message
		Global $g_sMessage[2]
		$g_sMessage[0] = $g_iChkGlobalMessages1[Random(0, UBound($g_iChkGlobalMessages1) - 1, 1)]
		$g_sMessage[1] = $g_iChkGlobalMessages2[Random(0, UBound($g_iChkGlobalMessages2) - 1, 1)]
		If $g_bScrambleGlobal Then
			_ArrayShuffle($g_sMessage)
		EndIf
		; Send the message
		If Not ChatbotSelectGlobalChat() Then
			ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
			Return
		EndIf
		If Not ChatbotSelectChatInput("Global") Then
			ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
			Return
		EndIf
		If Not ChatbotChatInput(_ArrayToString($g_sMessage, " ")) Then
			ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
			Return
		EndIf
		If Not ChatbotSendChat("Global") Then
			ChatbotChatClose() ;Error Occurs Close Chat If Opened Before Returning
			Return
		EndIf
		If Not ChatbotChatClose() Then Return
		;==================kychera modified===============================================
		If $g_bSwitchLang = True Then
			ChangeLanguageLifeCycle($g_aButtonLanguageEN, "EN") ;Change Language Back To English
		EndIf
		;=================================================================================
	EndIf

EndFunc   ;==>ChatGlobal

; Returns the response from cleverbot or simsimi, if any
Func runHelper($msg, $g_iChkCleverbot) ; run a script to get a response from cleverbot.com or simsimi.com
	Local $command, $DOS, $HelperStartTime, $Time_Difference, $sString
	Dim $DOS, $g_sMessage = ''

	$command = ' /c "phantomjs.exe phantom-cleverbot-helper.js '

	$DOS = Run(@ComSpec & $command & $msg & '"', "", @SW_HIDE, 8)
	$HelperStartTime = TimerInit()
	SetLog("Waiting for chatbot helper...")
	While ProcessExists($DOS)
		ProcessWaitClose($DOS, 10)
		SetLog("Still waiting for chatbot helper...")
		$Time_Difference = TimerDiff($HelperStartTime)
		If $Time_Difference > 50000 Then
			SetLog("Chatbot helper is taking too long!", $COLOR_RED)
			ProcessClose($DOS)
			_RunDos("taskkill -f -im phantomjs.exe") ; force kill
			Return ""
		EndIf
	WEnd
	$g_sMessage = ''
	While 1
		$g_sMessage &= StdoutRead($DOS)
		If @error Then
			ExitLoop
		EndIf
	WEnd
	Return StringStripWS($g_sMessage, 7)
EndFunc   ;==>runHelper

;===========Addied kychera=================
; #FUNCTION# ====================================================================================================================
; Name ..........: _Encoding_JavaUnicodeDecode
; Description ...: Decode string from Java Unicode format.
; Syntax ........: _Encoding_JavaUnicodeDecode($sString)
; Parameters ....: $sString             - String to decode.
; Return values .: Decoded string.
; Author ........: amel27
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Encoding_JavaUnicodeDecode($sString)
	Local $iOld_Opt_EVS = Opt('ExpandVarStrings', 0)
	Local $iOld_Opt_EES = Opt('ExpandEnvStrings', 0)

	Local $sOut = "", $aString = StringRegExp($sString, "(\\\\|\\'|\\u[[:xdigit:]]{4}|[[:ascii:]])", 3)

	For $i = 0 To UBound($aString) - 1
		Switch StringLen($aString[$i])
			Case 1
				$sOut &= $aString[$i]
			Case 2
				$sOut &= StringRight($aString[$i], 1)
			Case 6
				$sOut &= ChrW(Dec(StringRight($aString[$i], 4)))
		EndSwitch
	Next

	Opt('ExpandVarStrings', $iOld_Opt_EVS)
	Opt('ExpandEnvStrings', $iOld_Opt_EES)

	Return $sOut
EndFunc   ;==>_Encoding_JavaUnicodeDecode
;============================================

