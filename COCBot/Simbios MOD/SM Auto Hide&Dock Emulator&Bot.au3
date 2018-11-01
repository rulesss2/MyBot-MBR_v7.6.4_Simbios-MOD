; #FUNCTION# ====================================================================================================================
; Name ..........: SM Auto Hide&Dock Emulator&Bot.au3
; Description ...: Auto Dock&Hide Emulator after Start bot & Restart Emulator
; Author ........: NguyenAnhHD
; Modified ......: Fahid.Mahmood (26-09-2018)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func autoHideAndDockEmulatorAndBot($isAutoMinimizeBotAllowed = True)
	If $g_bDebugSetlog Then SetDebugLog("inside autoHideAndDockEmulatorAndBot : " & $isAutoMinimizeBotAllowed, $COLOR_INFO)
	If $g_bEnableAuto = True Then
		If $g_bChkAutoDock Then
			If Not $g_bAndroidEmbedded Then
				SetLog("Bot Auto Dock to Emulator", $COLOR_INFO)
				btnEmbed()
			EndIf
		EndIf
		If $g_bChkAutoHideEmulator Then
			If Not $g_bIsHidden Then
				SetLog("Bot Auto Hide Emulator", $COLOR_INFO)
				btnHide()
				$g_bIsHidden = True
			EndIf
		EndIf
	EndIf

	If $g_bChkAutoMinimizeBot And $isAutoMinimizeBotAllowed Then
		SetLog("Bot Auto Minimize Bot", $COLOR_INFO)
		If $g_bUpdatingWhenMinimized Then
			If $g_bHideWhenMinimized Then
				WinMove2($g_hFrmBot, "", -32000, -32000, -1, -1, 0, $SWP_HIDEWINDOW, False)
				_WinAPI_SetWindowLong($g_hFrmBot, $GWL_EXSTYLE, BitOR(_WinAPI_GetWindowLong($g_hFrmBot, $GWL_EXSTYLE), $WS_EX_TOOLWINDOW))
			EndIf
			If _WinAPI_IsIconic($g_hFrmBot) Then WinSetState($g_hFrmBot, "", @SW_RESTORE)
			If _WinAPI_IsIconic($g_hAndroidWindow) Then WinSetState($g_hAndroidWindow, "", @SW_RESTORE)
			WinMove2($g_hFrmBot, "", -32000, -32000, -1, -1, 0, BitOR($SWP_SHOWWINDOW, $SWP_NOACTIVATE), False)
		Else
			If $g_bHideWhenMinimized Then
				WinMove2($g_hFrmBot, "", -1, -1, -1, -1, 0, $SWP_HIDEWINDOW, False)
				_WinAPI_SetWindowLong($g_hFrmBot, $GWL_EXSTYLE, BitOR(_WinAPI_GetWindowLong($g_hFrmBot, $GWL_EXSTYLE), $WS_EX_TOOLWINDOW))
			EndIf
			WinSetState($g_hFrmBot, "", @SW_MINIMIZE)
		EndIf
	EndIf
EndFunc   ;==>autoHideAndDockEmulatorAndBot

Func chkEnableAuto()
	If GUICtrlRead($g_hChkEnableAuto) = $GUI_CHECKED Then
		$g_bEnableAuto = True
		_GUI_Value_STATE("ENABLE", $g_hChkAutoDock & "#" & $g_hChkAutoHideEmulator)
	Else
		$g_bEnableAuto = False
		_GUI_Value_STATE("DISABLE", $g_hChkAutoDock & "#" & $g_hChkAutoHideEmulator)
	EndIf
EndFunc   ;==>chkEnableAuto

Func btnEnableAuto()
	If $g_bEnableAuto = True Then
		If GUICtrlRead($g_hChkAutoDock) = $GUI_CHECKED Then
			$g_bChkAutoDock = True
		EndIf
		If GUICtrlRead($g_hChkAutoHideEmulator) = $GUI_CHECKED Then
			$g_bChkAutoHideEmulator = True
		EndIf
	Else
		$g_bChkAutoDock = False
		$g_bChkAutoHideEmulator = False
	EndIf
EndFunc   ;==>btnEnableAuto

