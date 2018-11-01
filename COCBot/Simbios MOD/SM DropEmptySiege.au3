; #FUNCTION# ====================================================================================================================
; Name ..........: SM DropEmptySiege.au3
; Description ...: Drop empty wall wracker or blimp
; Author ........: Fahid.Mahmood
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func logicForAllowingDropEmptySeige($sAttBarRes)
	Local $allowEmptySeige = False
	If Not $g_bChkEnableDropEmptySiege Then $allowEmptySeige = False ; If Drop Empty Siege is unchecked do nothing
	If $g_bChkEnableDropEmptySiege And Not $g_bChkDBDropEmptySiege And Not $g_bChkLBDropEmptySiege Then $allowEmptySeige = False ;If both live,dead base drop empty siege is unchecked do nothing
	If $g_bChkEnableDropEmptySiege And $g_bChkDBDropEmptySiege And $g_iMatchMode = $DB Then $allowEmptySeige = True ;If attack mode is dead base attack and dead base drop empty seige is unchecked do nothing
	If $g_bChkEnableDropEmptySiege And $g_bChkLBDropEmptySiege And $g_iMatchMode = $LB Then $allowEmptySeige = True ;If attack mode is live base attack and live base drop empty seige is unchecked do nothing
	SetDebugLog("inside logicForAllowingDropEmptySeige $allowEmptySeige : " & $allowEmptySeige & " $g_iMatchMode : " & $g_iMatchMode)
	Local $beforeFilter = $sAttBarRes[0] ;
	SetDebugLog("beforeFilter : " & $beforeFilter)
	Local $afterFilter = filterDropEmptySeige($beforeFilter, $allowEmptySeige)
	SetDebugLog("afterFilter : " & $afterFilter)
	$sAttBarRes[0] = $afterFilter ;Update string
	Return $sAttBarRes
EndFunc   ;==>logicForAllowingDropEmptySeige

Func filterDropEmptySeige($sAttBarResFileNames, $allowEmptySeige)
	Local $aAttBarResFileNamesKeys = StringSplit($sAttBarResFileNames, "|", $STR_NOCOUNT)
	; Loop through the array
	Local $sCCSiege = ""
	Local $sEmptySiege = ""
	For $i = 0 To UBound($aAttBarResFileNamesKeys) - 1
		If Not $g_bRunState Then Return
		If $i < UBound($aAttBarResFileNamesKeys) Then ;Need to recheck from new size as we deleted some array elements
			If ((StringInStr($aAttBarResFileNamesKeys[$i], "BattleB") And StringInStr($aAttBarResFileNamesKeys[$i], ".png")) Or _
					(StringInStr($aAttBarResFileNamesKeys[$i], "WallW") And StringInStr($aAttBarResFileNamesKeys[$i], ".png"))) And Not $allowEmptySeige Then ;If empty seige not allowed remove it from array
				_ArrayDelete($aAttBarResFileNamesKeys, $i)
				ContinueLoop
			EndIf

			If ((StringInStr($aAttBarResFileNamesKeys[$i], "BattleB") And StringInStr($aAttBarResFileNamesKeys[$i], ".xml")) Or _
					(StringInStr($aAttBarResFileNamesKeys[$i], "WallW") And StringInStr($aAttBarResFileNamesKeys[$i], ".xml"))) And $allowEmptySeige Then ;If empty seige allowed and xml resource found we need to to remove it for avoiding douplicate as png also exists in this array
				$sCCSiege = $aAttBarResFileNamesKeys[$i]
				_ArrayDelete($aAttBarResFileNamesKeys, $i)
				ContinueLoop
			EndIf

			If ((StringInStr($aAttBarResFileNamesKeys[$i], "BattleB") And StringInStr($aAttBarResFileNamesKeys[$i], ".png")) Or _
					(StringInStr($aAttBarResFileNamesKeys[$i], "WallW") And StringInStr($aAttBarResFileNamesKeys[$i], ".png"))) And $allowEmptySeige Then
				$sEmptySiege = $aAttBarResFileNamesKeys[$i]
			EndIf
		EndIf
	Next
	If $sCCSiege <> "" Then
		If StringInStr($sCCSiege, "BattleB") Then SetLog("Found CC Battle Blimp. It will be used to drop in attack.", $COLOR_SUCCESS)
		If StringInStr($sCCSiege, "WallW") Then SetLog("Found CC Wall Wrecker. It will be used to drop in attack.", $COLOR_SUCCESS)
	ElseIf $sEmptySiege <> "" Then
		If StringInStr($sEmptySiege, "BattleB") Then SetLog("Found Empty Battle Blimp. It will be used to drop in attack.", $COLOR_SUCCESS)
		If StringInStr($sEmptySiege, "WallW") Then SetLog("Found Empty Wall Wracker. It will be used to drop in attack.", $COLOR_SUCCESS)
	EndIf
	$sAttBarResFileNames = _ArrayToString($aAttBarResFileNamesKeys, "|")
	Return $sAttBarResFileNames
EndFunc   ;==>filterDropEmptySeige

Func chkEnableDropEmptySiege()

	If GUICtrlRead($g_hChkEnableDropEmptySiege) = $GUI_CHECKED Then
		$g_bChkEnableDropEmptySiege = True
		_GUI_Value_STATE("ENABLE", $g_hChkLBDropEmptySiege & "#" & $g_hChkDBDropEmptySiege)
	Else
		$g_bChkEnableDropEmptySiege = False
		_GUI_Value_STATE("DISABLE", $g_hChkLBDropEmptySiege & "#" & $g_hChkDBDropEmptySiege)
	EndIf

EndFunc   ;==>chkEnableDropEmptySiege

Func chkDropEmptySiege()
	If $g_bChkEnableDropEmptySiege = True Then
		If GUICtrlRead($g_hChkLBDropEmptySiege) = $GUI_CHECKED Then
			$g_bChkLBDropEmptySiege = True
		Else
			$g_bChkLBDropEmptySiege = False
		EndIf

		If GUICtrlRead($g_hChkDBDropEmptySiege) = $GUI_CHECKED Then
			$g_bChkDBDropEmptySiege = True
		Else
			$g_bChkDBDropEmptySiege = False
		EndIf
	Else
		$g_bChkLBDropEmptySiege = False
		$g_bChkDBDropEmptySiege = False
	EndIf
EndFunc   ;==>chkDropEmptySiege


