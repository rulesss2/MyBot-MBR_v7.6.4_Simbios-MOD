
; #FUNCTION# ====================================================================================================================
; Name ..........: ProfileSwitch SM MOD
; Description ...: This file contains all functions of ProfileSwitch feature
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: ---
; Modified ......: 03/09/2016
; Remarks .......: This file is part of MyBotRun. Copyright 2016
;                  MyBotRun is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://www.mybot.run
; Example .......:  =====================================================================================================================

Func ProfileSwitch()
	If $g_bChkGoldSwitchMax = True Or $g_bChkGoldSwitchMin = True Or $g_bChkElixirSwitchMax = True Or $g_bChkElixirSwitchMin = True Or _
			$g_bChkDESwitchMax = True Or $g_bChkDESwitchMin = True Or $g_bChkTrophySwitchMax = True Or $g_bChkTrophySwitchMin = True Then
		Local $SwitchtoProfile = ""
		While True
			If $g_bChkGoldSwitchMax = True Then
				If Number($g_aiCurrentLoot[$eLootGold]) >= Number($g_iTxtMaxGoldAmount) Then
					$SwitchtoProfile = $g_iCmbGoldMaxProfile
					SetLog("Village Gold detected Above Gold Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_bChkGoldSwitchMin = True Then
				If Number($g_aiCurrentLoot[$eLootGold]) < Number($g_iTxtMinGoldAmount) And Number($g_aiCurrentLoot[$eLootGold]) > 1 Then
					$SwitchtoProfile = $g_iCmbGoldMinProfile
					Setlog("Village Gold detected Below Gold Profile Switch Conditions")
					Setlog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_bChkElixirSwitchMax = True Then
				If Number($g_aiCurrentLoot[$eLootElixir]) >= Number($g_iTxtMaxElixirAmount) Then
					$SwitchtoProfile = $g_iCmbElixirMaxProfile
					SetLog("Village Gold detected Above Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_bChkElixirSwitchMin = True Then
				If Number($g_aiCurrentLoot[$eLootElixir]) < Number($g_iTxtMinElixirAmount) And Number($g_aiCurrentLoot[$eLootElixir]) > 1 Then
					$SwitchtoProfile = $g_iCmbElixirMinProfile
					SetLog("Village Gold detected Below Elixir Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_bChkDESwitchMax = True Then
				If Number($g_aiCurrentLoot[$eLootDarkElixir]) >= Number($g_iTxtMaxDEAmount) Then
					$SwitchtoProfile = $g_iCmbDEMaxProfile
					SetLog("Village Dark Elixir detected Above Dark Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_bChkDESwitchMin = True Then
				If Number($g_aiCurrentLoot[$eLootDarkElixir]) < Number($g_iTxtMinDEAmount) And Number($g_aiCurrentLoot[$eLootDarkElixir]) > 1 Then
					$SwitchtoProfile = $g_iCmbDEMinProfile
					SetLog("Village Dark Elixir detected Below Dark Elixir Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_bChkTrophySwitchMax = True Then
				If Number($g_aiCurrentLoot[$eLootTrophy]) >= Number($g_iTxtMaxTrophyAmount) Then
					$SwitchtoProfile = $g_iCmbTrophyMaxProfile
					SetLog("Village Trophies detected Above Throphy Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			If $g_bChkTrophySwitchMin = True Then
				If Number($g_aiCurrentLoot[$eLootTrophy]) < Number($g_iTxtMinTrophyAmount) And Number($g_aiCurrentLoot[$eLootTrophy]) > 1 Then
					$SwitchtoProfile = $g_iCmbTrophyMinProfile
					SetLog("Village Trophies detected Below Trophy Profile Switch Conditions")
					SetLog("It's time to switch profile")
					ExitLoop
				EndIf
			EndIf
			ExitLoop
		WEnd

		If $SwitchtoProfile <> "" Then
			TrayTip(" Profile Switch Village Report!", "Gold: " & _NumberFormat($g_aiCurrentLoot[$eLootGold]) & "; Elixir: " & _NumberFormat($g_aiCurrentLoot[$eLootElixir]) & "; Dark: " & _NumberFormat($g_aiCurrentLoot[$eLootDarkElixir]) & "; Trophy: " & _NumberFormat($g_aiCurrentLoot[$eLootTrophy]), "", 0)
			If FileExists(@ScriptDir & "\Audio\SwitchingProfiles.wav") Then
				SoundPlay(@ScriptDir & "\Audio\SwitchingProfiles.wav", 1)
			ElseIf FileExists(@WindowsDir & "\media\tada.wav") Then
				SoundPlay(@WindowsDir & "\media\tada.wav", 1)
			EndIf

			_GUICtrlComboBox_SetCurSel($g_hCmbProfile, $SwitchtoProfile)
			cmbProfile()
			If _Sleep(2000) Then Return
			runBot()
		EndIf
	EndIf

EndFunc   ;==>ProfileSwitch

; ---------------------------------GUI Control ----------------------------------;

Func chkGoldSwitchMax()
    If GUICtrlRead($g_hChkGoldSwitchMax) = $GUI_CHECKED Then
        $g_bChkGoldSwitchMax = True
    Else
        $g_bChkGoldSwitchMax = False
    EndIf
EndFunc ;==>chkGoldSwitchMax

Func chkGoldSwitchMin()
    If GUICtrlRead($g_hChkGoldSwitchMin) = $GUI_CHECKED Then
        $g_bChkGoldSwitchMin = True
    Else
        $g_bChkGoldSwitchMin = False
    EndIf
EndFunc ;==>chkGoldSwitchMin

Func chkElixirSwitchMax()
    If GUICtrlRead($g_hChkElixirSwitchMax) = $GUI_CHECKED Then
        $g_bChkElixirSwitchMax = True
    Else
        $g_bChkElixirSwitchMax = False
    EndIf
EndFunc ;==>chkElixirSwitchMax

Func chkElixirSwitchMin()
    If GUICtrlRead($g_hChkElixirSwitchMin) = $GUI_CHECKED Then
        $g_bChkElixirSwitchMin = True
    Else
        $g_bChkElixirSwitchMin = False
    EndIf
EndFunc ;==>chkElixirSwitchMin

Func chkDESwitchMax()
    If GUICtrlRead($g_hChkDESwitchMax) = $GUI_CHECKED Then
        $g_bChkDESwitchMax = True
    Else
        $g_bChkDESwitchMax = False
    EndIf
EndFunc ;==>chkDESwitchMax

Func chkDESwitchMin()
    If GUICtrlRead($g_hChkDESwitchMin) = $GUI_CHECKED Then
        $g_bChkDESwitchMin = True
    Else
        $g_bChkDESwitchMin = False
    EndIf
EndFunc ;==>chkDESwitchMin

Func chkTrophySwitchMax()
    If GUICtrlRead($g_hChkTrophySwitchMax) = $GUI_CHECKED Then
        $g_bChkTrophySwitchMax = True
    Else
        $g_bChkTrophySwitchMax = False
    EndIf
EndFunc ;==>chkTrophySwitchMax

Func chkTrophySwitchMin()
    If GUICtrlRead($g_hChkTrophySwitchMin) = $GUI_CHECKED Then
        $g_bChkTrophySwitchMin = True
    Else
        $g_bChkTrophySwitchMin = False
    EndIf
EndFunc ;==>chkTrophySwitchMin

; Switch Profiles 
Func btnRecycle()
	FileDelete($g_sProfileConfigPath)
    saveConfig()
	SetLog("Profile " & $g_sProfileCurrentName & " was recycled with success", $COLOR_GREEN)
	SetLog("All unused settings were removed", $COLOR_GREEN)
EndFunc   ;==>btnRecycle

Func setupProfileComboBoxswitch()
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbGoldMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbGoldMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbGoldMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbGoldMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbElixirMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbElixirMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbElixirMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbElixirMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbDEMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbDEMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbDEMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbDEMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbTrophyMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbTrophyMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbTrophyMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbTrophyMinProfile, $profileString, "<No Profiles>")
EndFunc   ;==>setupProfileComboBoxswitch