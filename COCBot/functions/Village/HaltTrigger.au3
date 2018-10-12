; #FUNCTION# ====================================================================================================================
; Name ..........: HaltTrigger
; Description ...: Used for donating on Upgrading down time.
; Syntax ........: HaltTrigger()
; Parameters ....:
; Return values .: None
; Author ........: ÓÐINN of Simbios Mod
; Modified ......: 
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func HaltTrigger()

	If isGoldFull() And isElixirFull() And isDarkElixirFull() And ($g_iLabUpgradeProgress = 1 Or $g_iMaxCount = 32) And ($g_iTotalBuilderCount = 0 Or $g_iTotalBuilderCount = 5) And $g_iHaltTrigger = 0 Then
		$g_iHaltTrigger = 1
		Return True
	ElseIf (($g_hTxtSmartMinGold >= $g_hLblResultGoldNow) Or ($g_hTxtSmartMinElixir >= $g_hLblResultElixirNow) Or ($g_hTxtSmartMinDark >= $g_hLblResultDENow) Or ($g_iTotalBuilderCount > 0 Or $g_iTotalBuilderCount < 5)) And $g_iHaltTrigger = 1 Then
		$g_iHaltTrigger = 0
		Return False
	Else
		$g_iHaltTrigger = 0
		Return False
	EndIf
	
EndFunc