; #FUNCTION# ====================================================================================================================
; Name ..........: SM MOD Global Variables
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: ---
; Parameters ....: ---
; Return values .: ---
; Author ........: by SM MOD
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......: ---
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: ---
; ===============================================================================================================================

Global $g_sLastModversion = "" ;latest version from GIT
Global $g_sLastModmessage = "" ;message for last version
Global $g_sOldModversmessage = "" ;warning message for old bot

; ================================================== CSV SPEED - Added by SM MOD =========================================== ;

Global $g_hCmbCSVSpeed[2] = [$LB, $DB]
Global $g_iCmbCSVSpeed[2] = [2, 2]
Global $g_CSVSpeedDivider = 1

; ================================================== Auto Dock, Hide Emulator & Bot - Added by SM MOD ====================== ;

Global $g_bEnableAuto = False, $g_bChkAutoDock = False, $g_bChkAutoHideEmulator = True, $g_bChkAutoMinimizeBot = False

; ================================================== Drop Empty Siege Machines - Added by SM MOD ====================== ;

Global $g_bChkEnableDropEmptySiege = False, $g_bChkLBDropEmptySiege = False, $g_bChkDBDropEmptySiege = False

; ================================================== Goblin XP - Added by SM MOD =========================================== ;

;SuperXP / GoblinXP
Global $g_bEnableSuperXP = False, $g_bSkipZoomOutXP = False, $g_bFastGoblinXP = False, $g_irbSXTraining = 1, $g_bSXBK = False, $g_bSXAQ = False, $g_bSXGW = False, $g_iStartXP = 0, $g_iCurrentXP = 0, $g_iGainedXP = 0, $g_iGainedXPHour = 0, $g_iTxtMaxXPtoGain = 500
Global $g_bDebugSX = False

; [0] = Queen, [1] = Warden, [2] = Barbarian King
; [0][0] = X, [0][1] = Y, [0][2] = XRandomOffset, [0][3] = YRandomOffset
Global $g_DpGoblinPicnic[3][4] = [[300, 205, 5, 5], [340, 140, 5, 5], [290, 220, 5, 5]]
Global $g_BdGoblinPicnic[3] = [0, "5000-7000", "6000-8000"] ; [0] = Queen, [1] = Warden, [2] = Barbarian King
Global $g_ActivatedHeroes[3] = [False, False, False] ; [0] = Queen, [1] = Warden, [2] = Barbarian King , Prevent to click on them to Activate Again And Again
Global Const $g_minStarsToEnd = 1
Global $g_canGainXP = False

; ================================================ Forecast - Added by SM MOD =============== ;
Global Const $COLOR_DEEPPINK = 0xFF1493
Global Const $COLOR_DARKGREEN = 0x006400
Global $oIE = ObjCreate("Shell.Explorer.2")
Global $ieForecast
Global $dtStamps[0]
Global $lootMinutes[0]
Global $timeOffset = 0
Global $TimerForecast = 0
Global $lootIndexScaleMarkers
Global $g_iCurrentForecast
Global $g_bForecastBoost = 0, $g_iTxtForecastBoost = 6
Global $g_bForecastPause = 0, $g_iTxtForecastPause = 2
Global $g_bForecastHopingSwitchMax = 0, $g_iCmbForecastHopingSwitchMax = 0, $g_iTxtForecastHopingSwitchMax = 2
Global $g_bForecastHopingSwitchMin = 0, $g_iCmbForecastHopingSwitchMin = 0, $g_iTxtForecastHopingSwitchMin = 2
Global $g_iCmbSwLang = 0

; ================================================ First Request CC Troops - Added by SM MOD ======================================== ;

Global $g_bReqCCFirst = False


; ================================================ Stop For War - Added by SM MOD ======================================== ;
Global $g_bStopForWar
Global $g_iStopTime, $g_iReturnTime
Global $g_bTrainWarTroop, $g_bUseQuickTrainWar, $g_aChkArmyWar[3], $g_aiWarCompTroops[$eTroopCount], $g_aiWarCompSpells[$eSpellCount]
Global $g_bRequestCCForWar, $g_sTxtRequestCCForWar

; ================================================ Bot Humanization - Added by SM MOD ======================================== ;

Global $g_iacmbPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_iacmbMaxSpeed[2] = [1, 1]
Global $g_iacmbPause[2] = [0, 0]
Global $g_iahumanMessage[2] = ["Hello !", "Hello !"]
Global $g_iTxtChallengeMessage = "Can you beat my village?"

Global $g_iMinimumPriority, $g_iMaxActionsNumber, $g_iActionToDo
Global $g_aSetActionPriority[13] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

Global $g_sFrequenceChain = "Never|Sometimes|Frequently|Often|Very Often"
Global $g_sReplayChain = "1|2|4"
Global $g_bUseBotHumanization = False, $g_bUseAltRClick = False, $g_iCmbMaxActionsNumber = 1, $g_bCollectAchievements = False, $g_bLookAtRedNotifications = False

Global $g_aReplayDuration[2] = [0, 0] ; An array, [0] = Minute | [1] = Seconds
Global $g_bOnReplayWindow, $g_iReplayToPause

Global $g_iLastLayout = 0


; ================================================ Switch Profile - Added by SM MOD ======================================== ;

Global $profileString = ""
Global $g_bChkGoldSwitchMax = False, $g_iTxtMaxGoldAmount = 12000000, $g_iCmbGoldMaxProfile = 0, $g_bChkGoldSwitchMin = False, $g_iTxtMinGoldAmount = 10000000, $g_iCmbGoldMinProfile = 0
Global $g_bChkElixirSwitchMax = False, $g_iTxtMaxElixirAmount = 12000000, $g_iCmbElixirMaxProfile = 0, $g_bChkElixirSwitchMin = False, $g_iTxtMinElixirAmount = 10000000, $g_iCmbElixirMinProfile = 0
Global $g_bChkDESwitchMax = False, $g_iTxtMaxDEAmount = 200000, $g_iCmbDEMaxProfile = 0, $g_bChkDESwitchMin = False, $g_iTxtMinDEAmount = 10000, $g_iCmbDEMinProfile = 0
Global $g_bChkTrophySwitchMax = False, $g_iTxtMaxTrophyAmount = 3000, $g_iCmbTrophyMaxProfile = 0, $g_bChkTrophySwitchMin = False, $g_iTxtMinTrophyAmount = 1000, $g_iCmbTrophyMinProfile = 0


; ================================================ NEW ChatBot - by SM MOD ======================================== ;
; ScreenCoordinates - first 2 values store the region [x,y] that can click; values 3,4,5,6 is the color check pixel x,y,color,tolerance level for confirm the button exist if needed.

Global Const $g_aButtonChatWindowOpen[6] = [8, 355, 16, 400, 0xC55115, 20] ; main page, clan chat Button Open Chat Window
Global Const $g_aButtonChatWindowClose[6] = [321, 355, 330, 400, 0xC55115, 20] ; main page, clan chat Button Close Chat Window
Global Const $g_aButtonChatSelectTabGlobal[6] = [74, 23, 20, 10, 0x79755B, 20] ; color med gray Select Global Chat Tab
Global Const $g_aButtonChatSelectTabClan[6] = [222, 27, 170, 10, 0x79755B, 20] ; color med gray Select Clan Chat Tab
Global Const $g_aButtonChatSelectTextBox[6] = [277, 706, 100, 700, 0xFFFFFF, 20] ; color white Select Chat Textbox
Global Const $g_aButtonChatSendButton[6] = [840, 720, 840, 720, 0xFFFFFF, 20] ; color white Select Chat Textbox
Global Const $g_aButtonChatJoinClan[4] = [157, 510, 0x6CBB1F, 20] ; Green Join Button on Chat Tab when you are not in a Clan


Global Const $g_aButtonLangSetting[6] = [820, 585, 810, 584, 0xF5F5E0, 20] ; Main Screen Button
Global Const $g_aButtonLangSettingClose[6] = [777, 113, 777, 113, 0xFF8D8D, 20] ; On Setting screen close button
Global Const $g_aButtonLangSettingSelectLang[2] = [210, 420] ; On Setting screen select language button
Global Const $g_aButtonLangSettingBackLang[6] = [127, 121, 116, 117, 0xFFFFFF, 20] ; On Setting screen language screen back button
Global Const $g_aButtonLangSettingOk[6] = [513, 426, 460, 408, 0xE2F98A, 20] ; Language Selection Dialog Ok button

Global Const $g_aButtonLanguageEN[2] = [165, 180] ;English
Global Const $g_aButtonLanguageFRA[2] = [163, 230] ;Franch
Global Const $g_aButtonLanguageRU[2] = [173, 607] ;Russian
Global Const $g_aButtonLanguageDE[2] = [163, 273] ;DEUTCH
Global Const $g_aButtonLanguageES[2] = [163, 325] ;Ispanol
Global Const $g_aButtonLanguageITA[2] = [163, 375] ;ITALYA
Global Const $g_aButtonLanguageNL[2] = [163, 425] ;Nederlands
Global Const $g_aButtonLanguageNO[2] = [163, 475] ;NORSK
Global Const $g_aButtonLanguagePR[2] = [163, 525] ;PORTUGAL
Global Const $g_aButtonLanguageTR[2] = [163, 575] ;TURK

Global $g_bChatGlobal = False
Global $g_bScrambleGlobal = False
Global $g_bSwitchLang = False
Global $g_bChatClan = False
Global $g_bClanUseResponses = False
Global $g_bClanAlwaysMsg = False
Global $g_bUseNotify = False
Global $g_bPbSendNew = False
Global $g_bRusLang = False
Global $g_iCmbLang = 9
Global $g_bCleverbot = False
Global $g_bDelayTime = False
Global $g_iTxtDelayTime = 10
Global $g_iChkClanMessages = ""
Global $g_iChkClanResponses = ""
Global $g_iChkClanResponses0
Global $g_iChkGlobalMessages1 = ""
Global $g_iChkGlobalMessages2 = ""
Global $g_sGlobalChatLastMsgSentTime = ""
Global $glb1
Global $glb2
Global $cResp
Global $cGeneric
Global $ChatbotStartTime
Global $g_sMessage = ""

;=============================================== Russian Request - by SM MOD ======================================== ;

Global $g_bChkRusLang2 = False

;=============================================== Max logout time - by SM MOD ======================================== ;

Global $g_bTrainLogoutMaxTime = False, $g_iTrainLogoutMaxTime = 4

;=============================================== Request troops for defense - by SM MOD ============================== ;

Global $g_bRequestCCDefense, $g_sRequestCCDefenseText, $g_bRequestCCDefenseWhenPB, $g_iRequestDefenseTime

; ================================================== Boost for Magic Spell by SM MOD ================================= ;

Global $g_iChkBoostBMagic = 0, $g_iCmbBoostBrMagic = 0, $g_iChkBoostCMagic = 0, $g_iCmbBoostClMagic = 0
Global $g_iXCollect = 0, $g_iYCollect = 0, $g_bCanBoostC = False
Global $g_iLastTime[3] = [0, 0, 0]

; ================================================== Multi Finger - Added by SM MOD ======================================== ;

Global Enum $directionLeft, $directionRight
Global Enum $sideBottomRight, $sideTopLeft, $sideBottomLeft, $sideTopRight
Global Enum $mfRandom, $mfFFStandard, $mfFFSpiralLeft, $mfFFSpiralRight, $mf8FBlossom, $mf8FImplosion, $mf8FPinWheelLeft, $mf8FPinWheelRight

Global $g_iMultiFingerStyle = 1
Global Enum $eCCSpell = $eHaSpell + 1

; ================================================== Unit/Wave Factor  - Added by SM MOD ======================================== ;

Global $g_iChkUnitFactor = 0
Global $g_iTxtUnitFactor = 10
Global $g_iChkWaveFactor = 0
Global $g_iTxtWaveFactor = 100

; ================================================== Check Grand Warden Mode - Added by SM MOD ================================== ;

Global $g_bCheckWardenMode = False, $g_iCheckWardenMode = 0

; ================================================== Upgrade Management - Added by SM MOD ================================== ;

Global $g_ibUpdateNewUpgradesOnly = 0
Global Const $UP = True, $DOWN = False, $TILL_END = True


; ================================================== GTFO Mod ================================== ;

Global $g_bChkUseGTFO = False, $g_bChkUseKickOut = False, $g_bChkKickOutSpammers = False
Global $g_iTxtMinSaveGTFO_Elixir = 200000, $g_iTxtMinSaveGTFO_DE = 2000, _
		$g_iTxtDonatedCap = 8, $g_iTxtReceivedCap = 35, _
		$g_iTxtKickLimit = 6
Global $g_hTxtClanID, $g_sTxtClanID, $g_iTxtCyclesGTFO
Global $g_bChkGTFOClanHop = False, $g_bChkGTFOReturnClan = False
Global $g_iCycle = 0

; ================================================== Wall/Building Upgrading Priority/Management by SM MOD	======================================== ;

Global $g_iChkUpgrPriority = 0, $g_iCmbUpgrdPriority = 0
Global Const $g_iLimitBreakGE[12] = [2500, 7000, 100000, 500000, 1000000, 2000000, 4000000, 6000000, 8000000, 8500000, 10000000, 12000000] ;Gold And Elixir Town Hall Level max resource storages at 90%
Global Const $g_iLimitBreakDE[12] = [0, 0, 0, 0, 0, 0, 20000, 80000, 190000, 200000, 20000, 240000] ;Dark Elixir Town Hall Level max resource storage at 90%
Global $g_iLabUpgradeProgress = 0
Global $g_iWallWarden = 0

; ================================================== ; Return Home by Time - by SM MOD  ======================================== ;

Global $g_bReturnTimerEnable = False, $g_iTxtReturnTimer = 5

; ================================================== One Gem Boost by SM MOD ================================= ;

Global $g_bChkOneGemBoostBarracks = False, $g_bChkOneGemBoostSpells = False, $g_bChkOneGemBoostHeroes = False


; ================================================== SmartTrain - SM MOD (Demen) ======================================== ;

Global $g_bChkSmartTrain = False, $g_bChkPreciseArmyCamp = False, $g_bChkFillArcher = False, $g_bChkFillEQ = False, $g_iTxtFillArcher = 5
Global Enum $g_eFull, $g_eRemained, $g_eNoTrain
Global $g_bWrongTroop, $g_bWrongSpell, $g_sSmartTrainError = ""

; ================================================== ; Attack Priority - by SM MOD  ======================================== ;

Global $g_bChkAttackPriority = False

; ================================================== ; Hero Boost Time - by SM MOD  ======================================== ;

Global $HeroTimeRem[8][3] = [["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""]]
Global $HeroTime[8][3] = [["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""]]

; ================================================== ; Priority System - by SM MOD  ======================================== ;

Global $g_bSmartSwitchUpgrade = False
Global $g_bChkPrioritySystem = False, $g_iCmbPrioritySystem = 0
Global $g_iLabLevel = 0
Global $g_iLabCheck = 0
Global $g_iUpgradeLevel[32][4] = [ _
		["LevelTroop", "Barb", 8, 0], _
		["LevelTroop", "Arch", 8, 1], _
		["LevelTroop", "Giant", 9, 2], _
		["LevelTroop", "Gobl", 7, 3], _
		["LevelTroop", "Wall", 8, 4], _
		["LevelTroop", "Ball", 8, 5], _
		["LevelTroop", "Wiza", 9, 6], _
		["LevelTroop", "Heal", 5, 7], _
		["LevelTroop", "Drag", 7, 8], _
		["LevelTroop", "Pekk", 8, 9], _
		["LevelTroop", "BabyD", 6, 10], _
		["LevelTroop", "Mine", 6, 11], _
		["LevelTroop", "EDrag", 3, 12], _
		["LevelSpell", "LSpell", 7, 0], _
		["LevelSpell", "HSpell", 7, 1], _
		["LevelSpell", "RSpell", 5, 2], _
		["LevelSpell", "JSpell", 3, 3], _
		["LevelSpell", "FSpell", 7, 4], _
		["LevelSpell", "CSpell", 5, 5], _
		["LevelSpell", "PSpell", 5, 6], _
		["LevelSpell", "ESpell", 4, 7], _
		["LevelSpell", "HaSpell", 4, 8], _
		["LevelSpell", "SkSpell", 5, 9], _
		["LevelTroop", "Mini", 8, 13], _
		["LevelTroop", "Hogs", 8, 14], _
		["LevelTroop", "Valk", 7, 15], _
		["LevelTroop", "Gole", 8, 16], _
		["LevelTroop", "Witc", 4, 17], _
		["LevelTroop", "Lava", 5, 18], _
		["LevelTroop", "Bowl", 4, 19], _
		["LevelSiege", "WallW", 3, 0], _
		["LevelSiege", "BattleB", 3, 1]]

Global $g_iLabCost[32][11] = [ _
		[0, 50000, 150000, 500000, 1500000, 4500000, 6000000, 8000000, "Max", "Max", "Max"], _			 ;Barbarian
		[0, 50000, 250000, 750000, 2250000, 6000000, 7500000, 9000000, "Max", "Max", "Max"], _  		 ;Archer
		[0, 100000, 250000, 750000, 2250000, 5000000, 6000000, 9500000, 12000000, "Max", "Max"], _  	 ;Giant
		[0, 50000, 250000, 750000, 2250000, 4500000, 6750000, "Max", "Max", "Max", "Max"], _  			 ;Goblin
		[0, 100000, 250000, 750000, 2000000, 6000000, 9000000, 12000000, "Max", "Max", "Max"], _ 		 ;Wall Breaker
		[0, 150000, 450000, 1350000, 2500000, 6000000, 9500000, 12000000, "Max", "Max", "Max"], _  		 ;Balloon
		[0, 150000, 450000, 1350000, 2500000, 5000000, 7000000, 9000000, 11000000, "Max", "Max"], _ 	 ;Wizard
		[0, 750000, 1500000, 3000000, 9500000, "Max", "Max", "Max", "Max", "Max", "Max"], _  			 ;Healer
		[0, 2000000, 3000000, 5000000, 7000000, 9000000, 11000000, "Max", "Max", "Max", "Max"], _ 		 ;Dragon
		[0, 3000000, 5000000, 6000000, 7500000, 8500000, 10000000, 12000000, "Max", "Max", "Max"], _ 	 ;Pekka
		[0, 5000000, 6000000, 7000000, 8000000, 9000000, "Max", "Max", "Max", "Max", "Max"], _ 			 ;Baby Dragon
		[0, 6000000, 7000000, 8000000, 9500000, 11000000, "Max", "Max", "Max", "Max", "Max"], _ 		 ;Miner
		[0, 9000000, 11000000, "Max", "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _ 				 ;Electro Dragon
		[0, 200000, 500000, 1000000, 2000000, 6000000, 8000000, "Max", "Max", "Max", "Max"], _ 			 ;Lightning Spell
		[0, 300000, 600000, 1200000, 2000000, 4000000, 6000000, "Max", "Max", "Max", "Max"], _ 			 ;Healing Spell
		[0, 450000, 900000, 1800000, 3000000, "Max", "Max", "Max", "Max", "Max", "Max"], _  			 ;Rage Spell
		[0, 3000000, 6000000, "Max", "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _ 			 	 ;Jump Spell
		[0, 3000000, 4000000, 5000000, 7000000, 9500000, 11000000, "Max", "Max", "Max", "Max"], _  		 ;Freeze Spell
		[0, 4000000, 6000000, 8000000, 10000000, "Max", "Max", "Max", "Max", "Max", "Max"], _  			 ;Clone Spell
		[0, 25000, 50000, 75000, 150000, "Max", "Max", "Max", "Max", "Max", "Max"], _  					 ;Poison Spell
		[0, 30000, 60000, 90000, "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _ 					 ;Earthquake Spell
		[0, 40000, 80000, 100000, "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _ 					 ;Haste Spell
		[0, 50000, 75000, 100000, 125000, "Max", "Max", "Max", "Max", "Max", "Max"], _  				 ;Skeleton Spell
		[0, 10000, 20000, 30000, 40000, 100000, 140000, 180000, "Max", "Max", "Max"], _  				 ;Minion
		[0, 20000, 30000, 40000, 50000, 100000, 150000, 200000, "Max", "Max", "Max"], _  				 ;Hog Rider
		[0, 50000, 60000, 70000, 110000, 150000, 190000, "Max", "Max", "Max", "Max"], _ 				 ;Valkyrie
		[0, 60000, 70000, 80000, 90000, 150000, 200000, 200000, "Max", "Max", "Max"], _  				 ;Golem
		[0, 75000, 160000, 200000, "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _  				 ;Witch
		[0, 60000, 70000, 150000, 200000, "Max", "Max", "Max", "Max", "Max", "Max"], _ 					 ;Lavahound
		[0, 120000, 200000, 200000, "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _  				 ;Bowler
		[0, 6000000, 8000000, "Max", "Max", "Max", "Max", "Max", "Max", "Max", "Max"], _  				 ;Wall Wrecker
		[0, 6000000, 8000000, "Max", "Max", "Max", "Max", "Max", "Max", "Max", "Max"]] ;Battle Blimp


Global $iLabMax[32][11] = [ _
		[0, 2, 2, 3, 3, 4, 5, 6, 7, 8, 8], _ ;Barbarian
		[0, 2, 2, 3, 3, 4, 5, 6, 7, 8, 8], _ ;Archer
		[0, 0, 2, 2, 3, 4, 5, 6, 7, 8, 9], _ ;Giant
		[0, 2, 2, 3, 3, 4, 5, 6, 7, 7, 7], _ ;Goblin
		[0, 0, 2, 2, 3, 4, 5, 6, 6, 7, 8], _ ;Wall Breaker
		[0, 0, 2, 2, 3, 4, 5, 6, 6, 7, 8], _ ;Balloon
		[0, 0, 0, 2, 3, 4, 5, 6, 7, 8, 9], _ ;Wizard
		[0, 0, 0, 0, 0, 2, 3, 4, 4, 5, 5], _ ;Healer
		[0, 0, 0, 0, 0, 2, 3, 4, 5, 6, 7], _ ;Dragon
		[0, 0, 0, 0, 0, 0, 3, 4, 6, 7, 8], _ ;Pekka
		[0, 0, 0, 0, 0, 0, 0, 2, 4, 5, 6], _ ;Baby Dragon
		[0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 6], _ ;Miner
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3], _ ;Electro Dragon
		[0, 2, 3, 4, 4, 4, 5, 6, 7, 7, 7], _ ;Lightning Spell
		[0, 0, 2, 2, 3, 4, 5, 6, 7, 7, 7], _ ;Healing Spell
		[0, 0, 0, 2, 3, 4, 5, 5, 5, 5, 5], _ ;Rage Spell
		[0, 0, 0, 0, 0, 2, 2, 2, 3, 3, 3], _ ;Jump Spell
		[0, 0, 0, 0, 0, 0, 0, 0, 5, 6, 7], _ ;Freeze Spell
		[0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 5], _ ;Clone Spell
		[0, 0, 0, 0, 0, 0, 2, 3, 4, 5, 5], _ ;Poison Spell
		[0, 0, 0, 0, 0, 0, 2, 3, 4, 4, 4], _ ;Earthquake Spell
		[0, 0, 0, 0, 0, 0, 0, 2, 4, 4, 4], _ ;Haste Spell
		[0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 5], _ ;Skeleton Spell
		[0, 0, 0, 0, 0, 2, 4, 5, 6, 7, 8], _ ;Minion
		[0, 0, 0, 0, 0, 2, 4, 5, 6, 7, 8], _ ;Hog Rider
		[0, 0, 0, 0, 0, 0, 2, 4, 5, 6, 7], _ ;Valkyrie
		[0, 0, 0, 0, 0, 0, 2, 4, 5, 7, 8], _ ;Golem
		[0, 0, 0, 0, 0, 0, 0, 2, 2, 3, 4], _ ;Witch
		[0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 5], _ ;Lavahound
		[0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4], _ ;Bowler
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3], _ ;Wall Wrecker
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3]] ;Battle Blimp


; ================================================== ; TNRQT - by SM MOD  ======================================== ;

Global $TroopsQueueFull = False
Global $g_bSmartQueueSystem = False

; ======================== Builder Status - Add by SM MOD (Demen) ======================================== ;

Global $g_sNextBuilderReadyTime = ""
Global $g_asNextBuilderReadyTime[8] = ["", "", "", "", "", "", "", ""]


; ======================== Builder Base Drop Trophies - Add by SM MOD (ChacalGyn) ======================================== ;

Global $g_bChkBB_DropTrophies = False
Global $g_bChkBB_OnlyWithLoot = False
Global $g_iTxtBB_DropTrophies = 0

; ======================== Change Theme - Add by SM MOD ======================================== ;

Global $ThemeConfig
Global $hUSkinDLLHandle = -1
Global $ThemeName = StringRegExpReplace(IniRead(@ScriptDir & "\Themes\skin.ini", "skin", "skin", @ScriptDir & "\Themes\MyBot Default Skin.msstyles"), '^(?:.*\\)([^\\]*?)(?:\.[^.]+)?$', '\1')

; ======================== Farm Schedule - Add by SM MOD ======================================== ;
Global $sSwitchAccFile
Global $g_abChkSetFarm[8], _
		$g_aiCmbAction1[8], $g_aiCmbCriteria1[8], $g_aiTxtResource1[8], $g_aiCmbTime1[8], _
		$g_aiCmbAction2[8], $g_aiCmbCriteria2[8], $g_aiTxtResource2[8], $g_aiCmbTime2[8]

; ================================================== Pause GUI Enable - Added by SM MOD =========================================== ;

Global $g_iStartStop = 0