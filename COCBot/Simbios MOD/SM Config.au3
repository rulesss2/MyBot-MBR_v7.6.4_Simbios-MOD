; #FUNCTION# ====================================================================================================================
; Name ..........: SM Config
; Description ...: This file Read/Save/Apply SM MODs settings
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: by SM MOD
; Modified ......:
; RemaSMs .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================

Func ReadConfig_SMMod()

	; ================================================== CSV SPEED - Added by SM MOD ================================ ;

	IniReadS($g_iCmbCSVSpeed[$LB], $g_sProfileConfigPath, "SM CSV Speed", "cmbCSVSpeed[LB]", $g_iCmbCSVSpeed[$LB], "Int")
	IniReadS($g_iCmbCSVSpeed[$DB], $g_sProfileConfigPath, "SM CSV Speed", "cmbCSVSpeed[DB]", $g_iCmbCSVSpeed[$DB], "Int")

	; ================================================== Auto Dock, Hide Emulator & Bot - Added by SM MOD ============================  ;

	IniReadS($g_bEnableAuto, $g_sProfileConfigPath, "general", "EnableAuto", $g_bEnableAuto, "Bool")
	IniReadS($g_bChkAutoDock, $g_sProfileConfigPath, "general", "AutoDock", $g_bChkAutoDock, "Bool")
	IniReadS($g_bChkAutoHideEmulator, $g_sProfileConfigPath, "general", "AutoHide", $g_bChkAutoHideEmulator, "Bool")
	IniReadS($g_bChkAutoMinimizeBot, $g_sProfileConfigPath, "general", "AutoMinimize", $g_bChkAutoMinimizeBot, "Bool")

	; ================================================== Drop Empty Siege Machines - Added by SM MOD ====================== ;

	IniReadS($g_bChkEnableDropEmptySiege, $g_sProfileConfigPath, "search", "ChkEnableDropEmptySiege", $g_bChkEnableDropEmptySiege, "Bool")
	IniReadS($g_bChkLBDropEmptySiege, $g_sProfileConfigPath, "search", "ChkLBDropEmptySiege", $g_bChkLBDropEmptySiege, "Bool")
	IniReadS($g_bChkDBDropEmptySiege, $g_sProfileConfigPath, "search", "ChkDBDropEmptySiege", $g_bChkDBDropEmptySiege, "Bool")

	; ================================================== Super XP - Added by SM MOD ==================================== ;

	IniReadS($g_bEnableSuperXP, $g_sProfileConfigPath, "SM GoblinXP", "EnableSuperXP", $g_bEnableSuperXP, "Bool")
	IniReadS($g_bSkipZoomOutXP, $g_sProfileConfigPath, "SM GoblinXP", "SkipZoomOutXP", $g_bSkipZoomOutXP, "Bool")
	IniReadS($g_bFastGoblinXP, $g_sProfileConfigPath, "SM GoblinXP", "FastGoblinXP", $g_bFastGoblinXP, "Bool")
	IniReadS($g_irbSXTraining, $g_sProfileConfigPath, "SM GoblinXP", "SXTraining", $g_irbSXTraining, "int")
	IniReadS($g_iTxtMaxXPtoGain, $g_sProfileConfigPath, "SM GoblinXP", "MaxXptoGain", $g_iTxtMaxXPtoGain, "int")
	IniReadS($g_bSXBK, $g_sProfileConfigPath, "SM GoblinXP", "SXBK", $eHeroNone)
	IniReadS($g_bSXAQ, $g_sProfileConfigPath, "SM GoblinXP", "SXAQ", $eHeroNone)
	IniReadS($g_bSXGW, $g_sProfileConfigPath, "SM GoblinXP", "SXGW", $eHeroNone)

	;================================================== Forecast - by SM MOD ================================= ;

	IniReadS($g_bForecastBoost, $g_sProfileConfigPath, "SM Forecast", "chkForecastBoost", False, "Bool")
	IniReadS($g_iTxtForecastBoost, $g_sProfileConfigPath, "SM Forecast", "txtForecastBoost", $g_iTxtForecastBoost, "Int")
	IniReadS($g_bForecastPause, $g_sProfileConfigPath, "SM Forecast", "chkForecastPause", False, "Bool")
	IniReadS($g_iTxtForecastPause, $g_sProfileConfigPath, "SM Forecast", "txtForecastPause", $g_iTxtForecastPause, "Int")
	IniReadS($g_bForecastHopingSwitchMax, $g_sProfileConfigPath, "SM Forecast", "chkForecastHopingSwitchMax", False, "Bool")
	IniReadS($g_iCmbForecastHopingSwitchMax, $g_sProfileConfigPath, "SM Forecast", "cmbForecastHopingSwitchMax", $g_iCmbForecastHopingSwitchMax, "Int")
	IniReadS($g_iTxtForecastHopingSwitchMax, $g_sProfileConfigPath, "SM Forecast", "txtForecastHopingSwitchMax", $g_iTxtForecastHopingSwitchMax, "Int")
	IniReadS($g_bForecastHopingSwitchMin, $g_sProfileConfigPath, "SM Forecast", "chkForecastHopingSwitchMin", False, "Bool")
	IniReadS($g_iCmbForecastHopingSwitchMin, $g_sProfileConfigPath, "SM Forecast", "cmbForecastHopingSwitchMin", $g_iCmbForecastHopingSwitchMin, "Int")
	IniReadS($g_iTxtForecastHopingSwitchMin, $g_sProfileConfigPath, "SM Forecast", "txtForecastHopingSwitchMin", $g_iTxtForecastHopingSwitchMin, "Int")
	IniReadS($g_iCmbSwLang, $g_sProfileConfigPath, "SM Forecast", "cmbSwLang", $g_iCmbSwLang, "int")

	;================================================== Move the Request CC Troops - Added by SM MOD =================== ;

	IniReadS($g_bReqCCFirst, $g_sProfileConfigPath, "planned", "ReqCCFirst", $g_bReqCCFirst, "Bool")

	;================================================== Stop For War - Added by SM MOD ==================== ;

	IniReadS($g_bStopForWar, $g_sProfileConfigPath, "war preparation", "Enable", False, "Bool")
	IniReadS($g_iStopTime, $g_sProfileConfigPath, "war preparation", "Stop Time", 0, "Int")
	IniReadS($g_iReturnTime, $g_sProfileConfigPath, "war preparation", "Return Time", 0, "Int")
	IniReadS($g_bTrainWarTroop, $g_sProfileConfigPath, "war preparation", "Train War Troop", False, "Bool")
	IniReadS($g_bUseQuickTrainWar, $g_sProfileConfigPath, "war preparation", "QuickTrain War Troop", False, "Bool")
	IniReadS($g_aChkArmyWar[0], $g_sProfileConfigPath, "war preparation", "QuickTrain War Army1", False, "Bool")
	IniReadS($g_aChkArmyWar[1], $g_sProfileConfigPath, "war preparation", "QuickTrain War Army2", False, "Bool")
	IniReadS($g_aChkArmyWar[2], $g_sProfileConfigPath, "war preparation", "QuickTrain War Army3", False, "Bool")

	For $i = 0 To $eTroopCount - 1
		IniReadS($g_aiWarCompTroops[$i], $g_sProfileConfigPath, "war preparation", $g_asTroopShortNames[$i], 0, "Int")
	Next
	For $j = 0 To $eSpellCount - 1
		IniReadS($g_aiWarCompSpells[$j], $g_sProfileConfigPath, "war preparation", $g_asSpellShortNames[$j], 0, "Int")
	Next

	IniReadS($g_bRequestCCForWar, $g_sProfileConfigPath, "war preparation", "RequestCC War", False, "Bool")
	$g_sTxtRequestCCForWar = IniRead($g_sProfileConfigPath, "war preparation", "RequestCC War Text", "War troop please")

	;================================================== Bot Humanization - Added by SM MOD ==================== ;

	IniReadS($g_bUseBotHumanization, $g_sProfileConfigPath, "Bot Humanization", "chkUseBotHumanization", $g_bUseBotHumanization, "Bool")
	IniReadS($g_bUseAltRClick, $g_sProfileConfigPath, "Bot Humanization", "chkUseAltRClick", $g_bUseAltRClick, "Bool")
	IniReadS($g_bCollectAchievements, $g_sProfileConfigPath, "Bot Humanization", "chkCollectAchievements", $g_bCollectAchievements, "Bool")
	IniReadS($g_bLookAtRedNotifications, $g_sProfileConfigPath, "Bot Humanization", "chkLookAtRedNotifications", $g_bLookAtRedNotifications, "Bool")
	For $i = 0 To 12
		IniReadS($g_iacmbPriority[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbPriority[" & $i & "]", $g_iacmbPriority[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbMaxSpeed[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbMaxSpeed[" & $i & "]", $g_iacmbMaxSpeed[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iacmbPause[$i], $g_sProfileConfigPath, "Bot Humanization", "cmbPause[" & $i & "]", $g_iacmbPause[$i], "int")
	Next
	For $i = 0 To 1
		IniReadS($g_iahumanMessage[$i], $g_sProfileConfigPath, "Bot Humanization", "humanMessage[" & $i & "]", $g_iahumanMessage[$i])
	Next
	IniReadS($g_iCmbMaxActionsNumber, $g_sProfileConfigPath, "Bot Humanization", "cmbMaxActionsNumber", $g_iCmbMaxActionsNumber, "int")
	IniReadS($g_iTxtChallengeMessage, $g_sProfileConfigPath, "Bot Humanization", "challengeMessage", $g_iTxtChallengeMessage)

	;================================================== ; Switch Profile - Added by SM MOD ==================== ;

	IniReadS($g_bChkGoldSwitchMax, $g_sProfileConfigPath, "profiles", "GoldSwitchMax", $g_bChkGoldSwitchMax, "Bool")
	IniReadS($g_iCmbGoldMaxProfile, $g_sProfileConfigPath, "profiles", "GoldMaxProfile", $g_iCmbGoldMaxProfile, "int")
	IniReadS($g_iTxtMaxGoldAmount, $g_sProfileConfigPath, "profiles", "MaxGoldAmount", $g_iTxtMaxGoldAmount, "int")
	IniReadS($g_bChkGoldSwitchMin, $g_sProfileConfigPath, "profiles", "GoldSwitchMin", $g_bChkGoldSwitchMin, "Bool")
	IniReadS($g_iCmbGoldMinProfile, $g_sProfileConfigPath, "profiles", "GoldMinProfile", $g_iCmbGoldMinProfile, "int")
	IniReadS($g_iTxtMinGoldAmount, $g_sProfileConfigPath, "profiles", "MinGoldAmount", $g_iTxtMinGoldAmount, "int")

	IniReadS($g_bChkElixirSwitchMax, $g_sProfileConfigPath, "profiles", "ElixirSwitchMax", $g_bChkElixirSwitchMax, "Bool")
	IniReadS($g_iCmbElixirMaxProfile, $g_sProfileConfigPath, "profiles", "ElixirMaxProfile", $g_iCmbElixirMaxProfile, "int")
	IniReadS($g_iTxtMaxElixirAmount, $g_sProfileConfigPath, "profiles", "MaxElixirAmount", $g_iTxtMaxElixirAmount, "int")
	IniReadS($g_bChkElixirSwitchMin, $g_sProfileConfigPath, "profiles", "ElixirSwitchMin", $g_bChkElixirSwitchMin, "Bool")
	IniReadS($g_iCmbElixirMinProfile, $g_sProfileConfigPath, "profiles", "ElixirMinProfile", $g_iCmbElixirMinProfile, "int")
	IniReadS($g_iTxtMinElixirAmount, $g_sProfileConfigPath, "profiles", "MinElixirAmount", $g_iTxtMinElixirAmount, "int")

	IniReadS($g_bChkDESwitchMax, $g_sProfileConfigPath, "profiles", "DESwitchMax", $g_bChkDESwitchMax, "Bool")
	IniReadS($g_iCmbDEMaxProfile, $g_sProfileConfigPath, "profiles", "DEMaxProfile", $g_iCmbDEMaxProfile, "Bool")
	IniReadS($g_iTxtMaxDEAmount, $g_sProfileConfigPath, "profiles", "MaxDEAmount", $g_iTxtMaxDEAmount, "int")
	IniReadS($g_bChkDESwitchMin, $g_sProfileConfigPath, "profiles", "DESwitchMin", $g_bChkDESwitchMin, "Bool")
	IniReadS($g_iCmbDEMinProfile, $g_sProfileConfigPath, "profiles", "DEMinProfile", $g_iCmbDEMinProfile, "int")
	IniReadS($g_iTxtMinDEAmount, $g_sProfileConfigPath, "profiles", "MinDEAmount", $g_iTxtMinDEAmount, "int")

	IniReadS($g_bChkTrophySwitchMax, $g_sProfileConfigPath, "profiles", "TrophySwitchMax", $g_bChkTrophySwitchMax, "Bool")
	IniReadS($g_iCmbTrophyMaxProfile, $g_sProfileConfigPath, "profiles", "TrophyMaxProfile", $g_iCmbTrophyMaxProfile, "int")
	IniReadS($g_iTxtMaxTrophyAmount, $g_sProfileConfigPath, "profiles", "MaxTrophyAmount", $g_iTxtMaxTrophyAmount, "int")
	IniReadS($g_bChkTrophySwitchMin, $g_sProfileConfigPath, "profiles", "TrophySwitchMin", $g_bChkTrophySwitchMin, "Bool")
	IniReadS($g_iCmbTrophyMinProfile, $g_sProfileConfigPath, "profiles", "TrophyMinProfile", $g_iCmbTrophyMinProfile, "int")
	IniReadS($g_iTxtMinTrophyAmount, $g_sProfileConfigPath, "profiles", "MinTrophyAmount", $g_iTxtMinTrophyAmount, "int")

	; ================================================== NEW ChatBot - by SM MOD ================================= ;

	IniReadS($g_bChatGlobal, $g_sProfileConfigPath, "Chatbot", "ChkChatGlobal", False, "Bool")
	IniReadS($g_bScrambleGlobal, $g_sProfileConfigPath, "Chatbot", "ChkScrambleGlobal", False, "Bool")
	IniReadS($g_bDelayTime, $g_sProfileConfigPath, "Chatbot", "ChkDelayTime", False, "Bool")
	IniReadS($g_iTxtDelayTime, $g_sProfileConfigPath, "Chatbot", "TxtDelayTime", $g_iTxtDelayTime)
	IniReadS($g_bSwitchLang, $g_sProfileConfigPath, "Chatbot", "ChkSwitchLang", False, "Bool")
	IniReadS($g_iCmbLang, $g_sProfileConfigPath, "Chatbot", "CmbLang", $g_iCmbLang, "int")
	IniReadS($g_bRusLang, $g_sProfileConfigPath, "Chatbot", "ChkRusLang", False, "Bool")
	IniReadS($g_bChatClan, $g_sProfileConfigPath, "Chatbot", "ChkChatClan", False, "Bool")
	IniReadS($g_bClanUseResponses, $g_sProfileConfigPath, "Chatbot", "ChkUseResponses", False, "Bool")
	IniReadS($g_bClanAlwaysMsg, $g_sProfileConfigPath, "Chatbot", "ChkUseGeneric", False, "Bool")
	IniReadS($g_bCleverbot, $g_sProfileConfigPath, "Chatbot", "ChkCleverbot", False, "Bool")
	IniReadS($g_bUseNotify, $g_sProfileConfigPath, "Chatbot", "ChkChatNotify", False, "Bool")
	IniReadS($g_bPbSendNew, $g_sProfileConfigPath, "Chatbot", "ChkPbSendNewChats", False, "Bool")

	; ==================================================  Upgrade Management - Added by SM MOD ==================== ;

	IniReadS($g_ibUpdateNewUpgradesOnly, $g_sProfileConfigPath, "upgrade", "UpdateNewUpgradesOnly", $g_ibUpdateNewUpgradesOnly, "int")
	IniReadS($g_bSmartSwitchUpgrade, $g_sProfileConfigPath, "upgrade", "SmartSwitchUpgrade", $g_bSmartSwitchUpgrade, "Bool")

EndFunc   ;==>ReadConfig_SMMod

Func SaveConfig_SMMod() ; due to mini mode no guitCtrols Reads in this function
	ApplyConfig_SMMod(GetApplyConfigSaveAction())

	; ================================================== CSV SPEED - Added by SM MOD =============================== ;

	_Ini_Add("SM CSV Speed", "cmbCSVSpeed[LB]", $g_iCmbCSVSpeed[$LB])
	_Ini_Add("SM CSV Speed", "cmbCSVSpeed[DB]", $g_iCmbCSVSpeed[$DB])

	; ==================================================  Auto Dock, Hide Emulator & Bot - Added by SM MOD ============================  ;

	_Ini_Add("general", "EnableAuto", $g_bEnableAuto ? True : False)
	_Ini_Add("general", "AutoDock", $g_bChkAutoDock ? True : False)
	_Ini_Add("general", "AutoHide", $g_bChkAutoHideEmulator ? True : False)
	_Ini_Add("general", "AutoMinimize", $g_bChkAutoMinimizeBot ? True : False)

	; ================================================== Drop Empty Siege Machines - Added by SM MOD ====================== ;

	_Ini_Add("search", "ChkEnableDropEmptySiege", $g_bChkEnableDropEmptySiege ? True : False)
	_Ini_Add("search", "ChkLBDropEmptySiege", $g_bChkLBDropEmptySiege ? True : False)
	_Ini_Add("search", "ChkDBDropEmptySiege", $g_bChkDBDropEmptySiege ? True : False)

	; ================================================== Super XP - Added by SM MOD ================================ ;

	_Ini_Add("SM GoblinXP", "EnableSuperXP", $g_bEnableSuperXP ? True : False)
	_Ini_Add("SM GoblinXP", "SkipZoomOutXP", $g_bSkipZoomOutXP ? True : False)
	_Ini_Add("SM GoblinXP", "FastGoblinXP", $g_bFastGoblinXP ? True : False)
	_Ini_Add("SM GoblinXP", "SXTraining", $g_irbSXTraining)
	_Ini_Add("SM GoblinXP", "SXBK", $g_bSXBK)
	_Ini_Add("SM GoblinXP", "SXAQ", $g_bSXAQ)
	_Ini_Add("SM GoblinXP", "SXGW", $g_bSXGW)
	_Ini_Add("SM GoblinXP", "MaxXptoGain", GUICtrlRead($g_hTxtMaxXPtoGain))

	; ================================================== Forecast - by SM MOD  ============================== ;

	_Ini_Add("SM Forecast", "chkForecastBoost", $g_bForecastBoost ? True : False)
	_Ini_Add("SM Forecast", "txtForecastBoost", $g_iTxtForecastBoost)
	_Ini_Add("SM Forecast", "chkForecastPause", $g_bForecastPause ? True : False)
	_Ini_Add("SM Forecast", "txtForecastPause", $g_iTxtForecastPause)
	_Ini_Add("SM Forecast", "chkForecastHopingSwitchMax", $g_bForecastHopingSwitchMax ? True : False)
	_Ini_Add("SM Forecast", "cmbForecastHopingSwitchMax", _GUICtrlComboBox_GetCurSel($g_hCmbForecastHopingSwitchMax))
	_Ini_Add("SM Forecast", "txtForecastHopingSwitchMax", $g_iTxtForecastHopingSwitchMax)
	_Ini_Add("SM Forecast", "chkForecastHopingSwitchMin", $g_bForecastHopingSwitchMin ? True : False)
	_Ini_Add("SM Forecast", "cmbForecastHopingSwitchMin", _GUICtrlComboBox_GetCurSel($g_hCmbForecastHopingSwitchMin))
	_Ini_Add("SM Forecast", "txtForecastHopingSwitchMin", $g_iTxtForecastHopingSwitchMin)
	_Ini_Add("SM Forecast", "cmbSwLang", _GUICtrlComboBox_GetCurSel($g_hCmbSwLang))

	;================================================== Move the Request CC Troops - Added by SM MOD ==================== ;

	_Ini_Add("planned", "ReqCCFirst", $g_bReqCCFirst)

	;================================================== Stop For War - Added by SM MOD ==================== ;

	_Ini_Add("war preparation", "Enable", $g_bStopForWar ? 1 : 0)
	_Ini_Add("war preparation", "Stop Time", $g_iStopTime)
	_Ini_Add("war preparation", "Return Time", $g_iReturnTime)
	_Ini_Add("war preparation", "Train War Troop", $g_bTrainWarTroop ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Troop", $g_bUseQuickTrainWar ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army1", $g_aChkArmyWar[0] ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army2", $g_aChkArmyWar[1] ? 1 : 0)
	_Ini_Add("war preparation", "QuickTrain War Army3", $g_aChkArmyWar[2] ? 1 : 0)
	For $i = 0 To $eTroopCount - 1
		_Ini_Add("war preparation", $g_asTroopShortNames[$i], $g_aiWarCompTroops[$i])
	Next
	For $j = 0 To $eSpellCount - 1
		_Ini_Add("war preparation", $g_asSpellShortNames[$j], $g_aiWarCompSpells[$j])
	Next
	_Ini_Add("war preparation", "RequestCC War", $g_bRequestCCForWar ? 1 : 0)
	_Ini_Add("war preparation", "RequestCC War Text", $g_sTxtRequestCCForWar)

	;================================================== Bot Humanization - Added by SM MOD ==================== ;

	_Ini_Add("Bot Humanization", "chkUseBotHumanization", $g_bUseBotHumanization ? True : False)
	_Ini_Add("Bot Humanization", "chkUseAltRClick", $g_bUseAltRClick ? True : False)
	_Ini_Add("Bot Humanization", "chkCollectAchievements", $g_bCollectAchievements ? True : False)
	_Ini_Add("Bot Humanization", "chkLookAtRedNotifications", $g_bLookAtRedNotifications ? True : False)
	For $i = 0 To 12
		_Ini_Add("Bot Humanization", "cmbPriority[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbPriority[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "cmbMaxSpeed[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbMaxSpeed[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "cmbPause[" & $i & "]", _GUICtrlComboBox_GetCurSel($g_acmbPause[$i]))
	Next
	For $i = 0 To 1
		_Ini_Add("Bot Humanization", "humanMessage[" & $i & "]", GUICtrlRead($g_ahumanMessage[$i]))
	Next
	_Ini_Add("Bot Humanization", "cmbMaxActionsNumber", _GUICtrlComboBox_GetCurSel($g_hCmbMaxActionsNumber))
	_Ini_Add("Bot Humanization", "challengeMessage", GUICtrlRead($g_hChallengeMessage))

	; ================================================ Switch Profile - Added by SM MOD ======================================== ;

	_Ini_Add("profiles", "GoldSwitchMax", $g_bChkGoldSwitchMax ? True : False)
	_Ini_Add("profiles", "GoldMaxProfile", $g_iCmbGoldMaxProfile)
	_Ini_Add("profiles", "MaxGoldAmount", $g_iTxtMaxGoldAmount)
	_Ini_Add("profiles", "GoldSwitchMin", $g_bChkGoldSwitchMin ? True : False)
	_Ini_Add("profiles", "GoldMinProfile", $g_iCmbGoldMinProfile)
	_Ini_Add("profiles", "MinGoldAmount", $g_iTxtMinGoldAmount)

	_Ini_Add("profiles", "ElixirSwitchMax", $g_bChkElixirSwitchMax ? True : False)
	_Ini_Add("profiles", "ElixirMaxProfile", $g_iCmbElixirMaxProfile)
	_Ini_Add("profiles", "MaxElixirAmount", $g_iTxtMaxElixirAmount)
	_Ini_Add("profiles", "ElixirSwitchMin", $g_bChkElixirSwitchMin ? True : False)
	_Ini_Add("profiles", "ElixirMinProfile", $g_iCmbElixirMinProfile)
	_Ini_Add("profiles", "MinElixirAmount", $g_iTxtMinElixirAmount)

	_Ini_Add("profiles", "DESwitchMax", $g_bChkDESwitchMax ? True : False)
	_Ini_Add("profiles", "DEMaxProfile", $g_iCmbDEMaxProfile)
	_Ini_Add("profiles", "MaxDEAmount", $g_iTxtMaxDEAmount)
	_Ini_Add("profiles", "DESwitchMin", $g_bChkDESwitchMin ? True : False)
	_Ini_Add("profiles", "DEMinProfile", $g_iCmbDEMinProfile)
	_Ini_Add("profiles", "MinDEAmount", $g_iTxtMinDEAmount)

	_Ini_Add("profiles", "TrophySwitchMax", $g_bChkTrophySwitchMax ? True : False)
	_Ini_Add("profiles", "TrophyMaxProfile", $g_iCmbTrophyMaxProfile)
	_Ini_Add("profiles", "MaxTrophyAmount", $g_iTxtMaxTrophyAmount)
	_Ini_Add("profiles", "TrophySwitchMin", $g_bChkTrophySwitchMin ? True : False)
	_Ini_Add("profiles", "TrophyMinProfile", $g_iCmbTrophyMinProfile)
	_Ini_Add("profiles", "MinTrophyAmount", $g_iTxtMinTrophyAmount)

	; ================================================== NEW ChatBot - by SM MOD ================================= ;

	_Ini_Add("Chatbot", "ChkChatGlobal", $g_bChatGlobal ? True : False)
	_Ini_Add("Chatbot", "ChkScrambleGlobal", $g_bScrambleGlobal ? True : False)
	_Ini_Add("Chatbot", "ChkDelayTime", $g_bDelayTime ? True : False)
	_Ini_Add("Chatbot", "TxtDelayTime", $g_iTxtDelayTime)
	_Ini_Add("Chatbot", "ChkSwitchLang", $g_bSwitchLang ? True : False)
	_Ini_Add("Chatbot", "CmbLang", _GUICtrlComboBox_GetCurSel($g_hCmbLang))
	_Ini_Add("Chatbot", "ChkRusLang", $g_bRusLang ? True : False)
	_Ini_Add("Chatbot", "ChkChatClan", $g_bChatClan ? True : False)

	_Ini_Add("Chatbot", "ChkUseResponses", $g_bClanUseResponses ? True : False)
	_Ini_Add("Chatbot", "ChkUseGeneric", $g_bClanAlwaysMsg ? True : False)
	_Ini_Add("Chatbot", "ChkCleverbot", $g_bCleverbot ? True : False)
	_Ini_Add("Chatbot", "ChkChatNotify", $g_bUseNotify ? True : False)
	_Ini_Add("Chatbot", "ChkPbSendNewChats", $g_bPbSendNew ? True : False)

	_Ini_Add("Chatbot", "globalMsg1", $glb1)
	_Ini_Add("Chatbot", "globalMsg2", $glb2)
	_Ini_Add("Chatbot", "genericMsgClan", $cGeneric)
	_Ini_Add("Chatbot", "responseMsgClan", $cResp)

	; ================================================== Upgrade Management - Added by SM MOD ================================== ;

	_Ini_Add("upgrade", "UpdateNewUpgradesOnly", $g_ibUpdateNewUpgradesOnly ? 1 : 0)
	_Ini_Add("upgrade", "SmartSwitchUpgrade", $g_bSmartSwitchUpgrade ? True : False)

EndFunc   ;==>SaveConfig_SMMod

Func ApplyConfig_SMMod($TypeReadSave)

	Switch $TypeReadSave

		Case "Save"

			; ================================================== CSV SPEED - Added by SM MOD ========================= ;

			$g_iCmbCSVSpeed[$LB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$LB])
			$g_iCmbCSVSpeed[$DB] = _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$DB])

			; ==================================================  Auto Dock, Hide Emulator & Bot - Added by SM MOD ============================  ;

			$g_bEnableAuto = (GUICtrlRead($g_hChkEnableAuto) = $GUI_CHECKED)
			$g_bChkAutoDock = (GUICtrlRead($g_hChkAutoDock) = $GUI_CHECKED)
			$g_bChkAutoHideEmulator = (GUICtrlRead($g_hChkAutoHideEmulator) = $GUI_CHECKED)
			$g_bChkAutoMinimizeBot = (GUICtrlRead($g_hChkAutoMinimizeBot) = $GUI_CHECKED)

			; ================================================== Drop Empty Siege Machines - Added by SM MOD ====================== ;

			$g_bChkEnableDropEmptySiege = (GUICtrlRead($g_hChkEnableDropEmptySiege) = $GUI_CHECKED)
			$g_bChkLBDropEmptySiege = (GUICtrlRead($g_hChkLBDropEmptySiege) = $GUI_CHECKED)
			$g_bChkDBDropEmptySiege = (GUICtrlRead($g_hChkDBDropEmptySiege) = $GUI_CHECKED)

			; ================================================== Super XP - Added by SM MOD ========================== ;

			$g_bEnableSuperXP = (GUICtrlRead($g_hChkEnableSuperXP) = $GUI_CHECKED)
			$g_bSkipZoomOutXP = (GUICtrlRead($g_hChkSkipZoomOutXP) = $GUI_CHECKED)
			$g_bFastGoblinXP = (GUICtrlRead($g_hChkFastGoblinXP) = $GUI_CHECKED)
			$g_irbSXTraining = GUICtrlRead($rbSXTraining) = $GUI_CHECKED ? 1 : 2
			$g_bSXBK = (GUICtrlRead($g_hChkSXBK) = $GUI_CHECKED) ? $eHeroKing : $eHeroNone
			$g_bSXAQ = (GUICtrlRead($g_hChkSXAQ) = $GUI_CHECKED) ? $eHeroQueen : $eHeroNone
			$g_bSXGW = (GUICtrlRead($g_hChkSXGW) = $GUI_CHECKED) ? $eHeroWarden : $eHeroNone
			$g_iTxtMaxXPtoGain = GUICtrlRead($g_hTxtMaxXPtoGain)

			; ================================================== Forecast - by SM MOD =========================== ;

			$g_bForecastBoost = (GUICtrlRead($g_hChkForecastBoost) = $GUI_CHECKED)
			$g_iTxtForecastBoost = GUICtrlRead($g_hTxtForecastBoost)
			$g_bForecastPause = (GUICtrlRead($g_hChkForecastPause) = $GUI_CHECKED)
			$g_iTxtForecastPause = GUICtrlRead($g_hTxtForecastPause)
			$g_bForecastHopingSwitchMax = (GUICtrlRead($g_hChkForecastHopingSwitchMax) = $GUI_CHECKED)
			$g_iCmbForecastHopingSwitchMax = _GUICtrlComboBox_GetCurSel($g_hCmbForecastHopingSwitchMax)
			$g_iTxtForecastHopingSwitchMax = GUICtrlRead($g_hTxtForecastHopingSwitchMax)
			$g_bForecastHopingSwitchMin = (GUICtrlRead($g_hChkForecastHopingSwitchMin) = $GUI_CHECKED)
			$g_iCmbForecastHopingSwitchMin = _GUICtrlComboBox_GetCurSel($g_hCmbForecastHopingSwitchMin)
			$g_iTxtForecastHopingSwitchMin = GUICtrlRead($g_hTxtForecastHopingSwitchMin)
			$g_iCmbSwLang = _GUICtrlComboBox_GetCurSel($g_hCmbSwLang)

			; =============================================== Move the Request CC Troops - Added by SM MOD =================== ;

			$g_bReqCCFirst = (GUICtrlRead($g_hChkReqCCFirst) = $GUI_CHECKED)

			;================================================== Stop For War - Added by SM MOD ==================== ;

			$g_bStopForWar = GUICtrlRead($g_hChkStopForWar) = $GUI_CHECKED
			$g_iStopTime = _GUICtrlComboBox_GetCurSel($g_hCmbStopTime)
			If _GUICtrlComboBox_GetCurSel($g_hCmbStopBeforeBattle) = 0 Then $g_iStopTime = $g_iStopTime * -1
			$g_iReturnTime = _GUICtrlComboBox_GetCurSel($g_hCmbReturnTime)
			$g_bTrainWarTroop = GUICtrlRead($g_hChkTrainWarTroop) = $GUI_CHECKED
			$g_bUseQuickTrainWar = GUICtrlRead($g_hChkUseQuickTrainWar) = $GUI_CHECKED
			$g_aChkArmyWar[0] = GUICtrlRead($g_ahChkArmyWar[0]) = $GUI_CHECKED
			$g_aChkArmyWar[1] = GUICtrlRead($g_ahChkArmyWar[1]) = $GUI_CHECKED
			$g_aChkArmyWar[2] = GUICtrlRead($g_ahChkArmyWar[2]) = $GUI_CHECKED
			For $i = 0 To $eTroopCount - 1
				$g_aiWarCompTroops[$i] = GUICtrlRead($g_ahTxtTrainWarTroopCount[$i])
			Next
			For $j = 0 To $eSpellCount - 1
				$g_aiWarCompSpells[$j] = GUICtrlRead($g_ahTxtTrainWarSpellCount[$j])
			Next
			$g_bRequestCCForWar = GUICtrlRead($g_hChkRequestCCForWar) = $GUI_CHECKED
			$g_sTxtRequestCCForWar = GUICtrlRead($g_hTxtRequestCCForWar)

			;==================================================  Bot Humanization - Added by SM MOD ==================== ;

			$g_bUseBotHumanization = (GUICtrlRead($g_hChkUseBotHumanization) = $GUI_CHECKED)
			$g_bUseAltRClick = (GUICtrlRead($g_hChkUseAltRClick) = $GUI_CHECKED)
			$g_bCollectAchievements = (GUICtrlRead($g_hChkCollectAchievements) = $GUI_CHECKED)
			$g_bLookAtRedNotifications = (GUICtrlRead($g_hChkLookAtRedNotifications) = $GUI_CHECKED)
			For $i = 0 To 12
				$g_iacmbPriority[$i] = _GUICtrlComboBox_GetCurSel($g_acmbPriority[$i])
			Next
			For $i = 0 To 1
				$g_iacmbMaxSpeed[$i] = _GUICtrlComboBox_GetCurSel($g_acmbMaxSpeed[$i])
			Next
			For $i = 0 To 1
				$g_iacmbPause[$i] = _GUICtrlComboBox_GetCurSel($g_acmbPause[$i])
			Next
			For $i = 0 To 1
				$g_iahumanMessage[$i] = GUICtrlRead($g_ahumanMessage[$i])
			Next
			$g_iCmbMaxActionsNumber = _GUICtrlComboBox_GetCurSel($g_iCmbMaxActionsNumber)
			$g_iTxtChallengeMessage = GUICtrlRead($g_hChallengeMessage)

			; ================================================ Switch Profile - Added by SM MOD ======================================== ;

			$g_bChkGoldSwitchMax = (GUICtrlRead($g_hChkGoldSwitchMax) = $GUI_CHECKED)
			$g_iCmbGoldMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbGoldMaxProfile)
			$g_iTxtMaxGoldAmount = GUICtrlRead($g_hTxtMaxGoldAmount)
			$g_bChkGoldSwitchMin = (GUICtrlRead($g_hChkGoldSwitchMin) = $GUI_CHECKED)
			$g_iCmbGoldMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbGoldMinProfile)
			$g_iTxtMinGoldAmount = GUICtrlRead($g_hTxtMinGoldAmount)

			$g_bChkElixirSwitchMax = (GUICtrlRead($g_hChkElixirSwitchMax) = $GUI_CHECKED)
			$g_iCmbElixirMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbElixirMaxProfile)
			$g_iTxtMaxElixirAmount = GUICtrlRead($g_hTxtMaxElixirAmount)
			$g_bChkElixirSwitchMin = (GUICtrlRead($g_hChkElixirSwitchMin) = $GUI_CHECKED)
			$g_iCmbElixirMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbElixirMinProfile)
			$g_iTxtMinElixirAmount = GUICtrlRead($g_hTxtMinElixirAmount)

			$g_bChkDESwitchMax = (GUICtrlRead($g_hChkDESwitchMax) = $GUI_CHECKED)
			$g_iCmbDEMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbDEMaxProfile)
			$g_iTxtMaxDEAmount = GUICtrlRead($g_hTxtMaxDEAmount)
			$g_bChkDESwitchMin = (GUICtrlRead($g_hChkDESwitchMin) = $GUI_CHECKED)
			$g_iCmbDEMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbDEMinProfile)
			$g_iTxtMinDEAmount = GUICtrlRead($g_hTxtMinDEAmount)

			$g_bChkTrophySwitchMax = (GUICtrlRead($g_hChkTrophySwitchMax) = $GUI_CHECKED)
			$g_iCmbTrophyMaxProfile = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyMaxProfile)
			$g_iTxtMaxTrophyAmount = GUICtrlRead($g_hTxtMaxTrophyAmount)
			$g_bChkTrophySwitchMin = (GUICtrlRead($g_hChkTrophySwitchMin) = $GUI_CHECKED)
			$g_iCmbTrophyMinProfile = _GUICtrlComboBox_GetCurSel($g_hCmbTrophyMinProfile)
			$g_iTxtMinTrophyAmount = GUICtrlRead($g_hTxtMinTrophyAmount)

			; ================================================== NEW ChatBot - by SM MOD ================================= ;

			$g_bChatGlobal = (GUICtrlRead($g_hChkGlobalChat) = $GUI_CHECKED)
			$g_bScrambleGlobal = (GUICtrlRead($g_hChkGlobalScramble) = $GUI_CHECKED)
			$g_bDelayTime = (GUICtrlRead($g_hChkDelayTime) = $GUI_CHECKED)
			$g_iTxtDelayTime = GUICtrlRead($g_hTxtDelayTime)
			$g_bSwitchLang = (GUICtrlRead($g_hChkSwitchLang) = $GUI_CHECKED)
			$g_iCmbLang = _GUICtrlComboBox_GetCurSel($g_hCmbLang)
			$g_bRusLang = (GUICtrlRead($g_hChkRusLang) = $GUI_CHECKED)
			$g_bChatClan = (GUICtrlRead($g_hChkClanChat) = $GUI_CHECKED)
			$g_bClanUseResponses = (GUICtrlRead($g_hChkUseResponses) = $GUI_CHECKED)
			$g_bClanAlwaysMsg = (GUICtrlRead($g_hChkUseGeneric) = $GUI_CHECKED)
			$g_bCleverbot = (GUICtrlRead($g_hChkCleverbot) = $GUI_CHECKED)
			$g_bUseNotify = (GUICtrlRead($g_hChkChatNotify) = $GUI_CHECKED)
			$g_bPbSendNew = (GUICtrlRead($g_hChkPbSendNewChats) = $GUI_CHECKED)

			; ================================================== Upgrade Management - Added by SM MOD ============================= ;

			$g_ibUpdateNewUpgradesOnly = GUICtrlRead($g_hChkUpdateNewUpgradesOnly) = $GUI_CHECKED ? 1 : 0
			$g_bSmartSwitchUpgrade = (GUICtrlRead($g_hChkSmartSwitchUpgrade) = $GUI_CHECKED)

		Case "Read"


			; ================================================== CSV SPEED - Added by SM MOD ============================  ;

			_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$LB], $g_iCmbCSVSpeed[$LB])
			_GUICtrlComboBox_SetCurSel($g_hCmbCSVSpeed[$DB], $g_iCmbCSVSpeed[$DB])

			; ==================================================  Auto Dock, Hide Emulator & Bot - Added by SM MOD ============================  ;

			GUICtrlSetState($g_hChkEnableAuto, $g_bEnableAuto = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkEnableAuto()
			GUICtrlSetState($g_hChkAutoDock, $g_bChkAutoDock = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkAutoHideEmulator, $g_bChkAutoHideEmulator = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			btnEnableAuto()
			GUICtrlSetState($g_hChkAutoMinimizeBot, $g_bChkAutoMinimizeBot = True ? $GUI_CHECKED : $GUI_UNCHECKED)

			; ================================================== Drop Empty Siege Machines - Added by SM MOD ====================== ;

			GUICtrlSetState($g_hChkEnableDropEmptySiege, $g_bChkEnableDropEmptySiege = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkEnableDropEmptySiege()
			GUICtrlSetState($g_hChkLBDropEmptySiege, $g_bChkLBDropEmptySiege = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDBDropEmptySiege, $g_bChkDBDropEmptySiege = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkDropEmptySiege()

			; ================================================== Super XP - Added by SM MOD ============================== ;

			GUICtrlSetState($g_hChkEnableSuperXP, $g_bEnableSuperXP ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkEnableSuperXP()
			GUICtrlSetState($g_hChkSkipZoomOutXP, $g_bSkipZoomOutXP ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkFastGoblinXP, $g_bFastGoblinXP ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($rbSXTraining, ($g_irbSXTraining = 1) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($rbSXIAttacking, ($g_irbSXTraining = 2) ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtMaxXPtoGain, $g_iTxtMaxXPtoGain)
			GUICtrlSetState($g_hChkSXBK, $g_bSXBK = $eHeroKing ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSXAQ, $g_bSXAQ = $eHeroQueen ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkSXGW, $g_bSXGW = $eHeroWarden ? $GUI_CHECKED : $GUI_UNCHECKED)

			; ================================================== Forecast - by SM MOD ================================ ;

			GUICtrlSetState($g_hChkForecastBoost, $g_bForecastBoost ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtForecastBoost, $g_iTxtForecastBoost)
			chkForecastBoost()
			GUICtrlSetState($g_hChkForecastPause, $g_bForecastPause ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtForecastPause, $g_iTxtForecastPause)
			chkForecastPause()
			GUICtrlSetState($g_hChkForecastHopingSwitchMax, $g_bForecastHopingSwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbForecastHopingSwitchMax, $g_iCmbForecastHopingSwitchMax)
			GUICtrlSetData($g_hTxtForecastHopingSwitchMax, $g_iTxtForecastHopingSwitchMax)
			chkForecastHopingSwitchMax()
			GUICtrlSetState($g_hChkForecastHopingSwitchMin, $g_bForecastHopingSwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbForecastHopingSwitchMin, $g_iCmbForecastHopingSwitchMin)
			GUICtrlSetData($g_hTxtForecastHopingSwitchMin, $g_iTxtForecastHopingSwitchMin)
			chkForecastHopingSwitchMin()
			_GUICtrlComboBox_SetCurSel($g_hCmbSwLang, $g_iCmbSwLang)

			; ================================================== Move the Request CC Troops - Added by SM MOD ================== ;

			GUICtrlSetState($g_hChkReqCCFirst, $g_bReqCCFirst = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkReqCCFirst()

			;================================================== Stop For War - Added by SM MOD ==================== ;

			GUICtrlSetState($g_hChkStopForWar, $g_bStopForWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbStopTime, Abs($g_iStopTime))
			_GUICtrlComboBox_SetCurSel($g_hCmbStopBeforeBattle, $g_iStopTime < 0 ? 0 : 1)
			_GUICtrlComboBox_SetCurSel($g_hCmbReturnTime, $g_iReturnTime)
			GUICtrlSetState($g_hChkTrainWarTroop, $g_bTrainWarTroop ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseQuickTrainWar, $g_bUseQuickTrainWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[0], $g_aChkArmyWar[0] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[1], $g_aChkArmyWar[1] ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_ahChkArmyWar[2], $g_aChkArmyWar[2] ? $GUI_CHECKED : $GUI_UNCHECKED)
			For $i = 0 To $eTroopCount - 1
				GUICtrlSetData($g_ahTxtTrainWarTroopCount[$i], $g_aiWarCompTroops[$i])
			Next
			For $j = 0 To $eSpellCount - 1
				GUICtrlSetData($g_ahTxtTrainWarSpellCount[$j], $g_aiWarCompSpells[$j])
			Next
			GUICtrlSetState($g_hChkRequestCCForWar, $g_bRequestCCForWar ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtRequestCCForWar, $g_sTxtRequestCCForWar)
			ReadConfig_600_52_2()
			ChkStopForWar()

			;================================================== Bot Humanization - Added by SM MOD ==================== ;

			GUICtrlSetState($g_hChkUseBotHumanization, $g_bUseBotHumanization ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseAltRClick, $g_bUseAltRClick ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkCollectAchievements, $g_bCollectAchievements ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkLookAtRedNotifications, $g_bLookAtRedNotifications ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUseBotHumanization()
			For $i = 0 To 12
				_GUICtrlComboBox_SetCurSel($g_acmbPriority[$i], $g_iacmbPriority[$i])
			Next
			For $i = 0 To 1
				_GUICtrlComboBox_SetCurSel($g_acmbMaxSpeed[$i], $g_iacmbMaxSpeed[$i])
			Next
			For $i = 0 To 1
				_GUICtrlComboBox_SetCurSel($g_acmbPause[$i], $g_iacmbPause[$i])
			Next
			For $i = 0 To 1
				GUICtrlSetData($g_ahumanMessage[$i], $g_iahumanMessage[$i])
			Next
			_GUICtrlComboBox_SetCurSel($g_hCmbMaxActionsNumber, $g_iCmbMaxActionsNumber)
			GUICtrlSetData($g_hChallengeMessage, $g_iTxtChallengeMessage)
			cmbStandardReplay()
			cmbWarReplay()

			; ================================================  Switch Profile - Added by SM MOD ======================================== ;

			GUICtrlSetState($g_hChkGoldSwitchMax, $g_bChkGoldSwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGoldMaxProfile, $g_iCmbGoldMaxProfile)
			GUICtrlSetData($g_hTxtMaxGoldAmount, $g_iTxtMaxGoldAmount)
			chkGoldSwitchMax()

			GUICtrlSetState($g_hChkGoldSwitchMin, $g_bChkGoldSwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbGoldMinProfile, $g_iCmbGoldMinProfile)
			GUICtrlSetData($g_hTxtMinGoldAmount, $g_iTxtMinGoldAmount)
			chkGoldSwitchMin()

			GUICtrlSetState($g_hChkElixirSwitchMax, $g_bChkElixirSwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbElixirMaxProfile, $g_iCmbElixirMaxProfile)
			GUICtrlSetData($g_hTxtMaxElixirAmount, $g_iTxtMaxElixirAmount)
			chkElixirSwitchMax()

			GUICtrlSetState($g_hChkElixirSwitchMin, $g_bChkElixirSwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbElixirMinProfile, $g_iCmbElixirMinProfile)
			GUICtrlSetData($g_hTxtMinElixirAmount, $g_iTxtMinElixirAmount)
			chkElixirSwitchMin()

			GUICtrlSetState($g_hChkDESwitchMax, $g_bChkDESwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDEMaxProfile, $g_iCmbDEMaxProfile)
			GUICtrlSetData($g_hTxtMaxDEAmount, $g_iTxtMaxDEAmount)
			chkDESwitchMax()

			GUICtrlSetState($g_hChkDESwitchMin, $g_bChkDESwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbDEMinProfile, $g_iCmbDEMinProfile)
			GUICtrlSetData($g_hTxtMinDEAmount, $g_iTxtMinDEAmount)
			chkDESwitchMin()

			GUICtrlSetState($g_hChkTrophySwitchMax, $g_bChkTrophySwitchMax ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyMaxProfile, $g_iCmbTrophyMaxProfile)
			GUICtrlSetData($g_hTxtMaxTrophyAmount, $g_iTxtMaxTrophyAmount)
			chkTrophySwitchMax()

			GUICtrlSetState($g_hChkTrophySwitchMin, $g_bChkTrophySwitchMin ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbTrophyMinProfile, $g_iCmbTrophyMinProfile)
			GUICtrlSetData($g_hTxtMinTrophyAmount, $g_iTxtMinTrophyAmount)
			chkTrophySwitchMin()

			; ================================================== NEW ChatBot - by SM MOD ======================================== ;

			GUICtrlSetState($g_hChkGlobalChat, $g_bChatGlobal ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkGlobalScramble, $g_bScrambleGlobal ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkDelayTime, $g_bDelayTime ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetData($g_hTxtDelayTime, $g_iTxtDelayTime)
			GUICtrlSetState($g_hChkSwitchLang, $g_bSwitchLang ? $GUI_CHECKED : $GUI_UNCHECKED)
			_GUICtrlComboBox_SetCurSel($g_hCmbLang, $g_iCmbLang)
			GUICtrlSetState($g_hChkRusLang, $g_bRusLang ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkClanChat, $g_bChatClan ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseResponses, $g_bClanUseResponses ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkUseGeneric, $g_bClanAlwaysMsg ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkCleverbot, $g_bCleverbot ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkChatNotify, $g_bUseNotify ? $GUI_CHECKED : $GUI_UNCHECKED)
			GUICtrlSetState($g_hChkPbSendNewChats, $g_bPbSendNew ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkRusLang()
			chkGlobalChat()
			chkGlobalScramble()
			chkCleverbot()
			chkSwitchLang()
			chkClanChat()
			chkUseResponses()
			chkUseGeneric()
			chkChatNotify()
			chkPbSendNewChats()
			ChatGuiEditUpdate()
			chkDelayTime()

			; ==================================================  Upgrade Management - Added by SM MOD ======================================== ;

			GUICtrlSetState($g_hChkUpdateNewUpgradesOnly, $g_ibUpdateNewUpgradesOnly = 1 ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkUpdateNewUpgradesOnly()
			GUICtrlSetState($g_hChkSmartSwitchUpgrade, $g_bSmartSwitchUpgrade = True ? $GUI_CHECKED : $GUI_UNCHECKED)
			chkSmartSwitchUpgrade()

	EndSwitch

EndFunc   ;==>ApplyConfig_SMMod
