; #FUNCTION# ====================================================================================================================
; Name ..........: SM MOD Debug GUI Control
; Description ...: This file is used for SM MOD Debug GUI functions of debug will be here.
; Author ........: Fahid.Mahmood
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================


Func btnTestHeroBoostOCR()
	SetLog("Test Hero Time OCR Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState

	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True

	checkMainScreen()
	getArmyHeroCount(True, True) ;Check If HeroUpgrading Status
	CheckHeroBoost()

	;Reset to orignal state
	$g_bRunState = $wasRunState

	SetLog("Test Hero Time OCR Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestHeroBoostOCR

Func btnTestBuilderTimeOCR()
	SetLog("Test Builder Time OCR Started", $COLOR_DEBUG)

	Local $wasTotalBuilderCount = $g_iTotalBuilderCount
	Local $wasFreeBuilderCount = $g_iFreeBuilderCount
	Local $wasRunState = $g_bRunState

	;For Debug Purpose set these values temporarily
	$g_iTotalBuilderCount = 1
	$g_iFreeBuilderCount = 0
	$g_bRunState = True

	checkMainScreen()
	getBuilderTime()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_iTotalBuilderCount = $wasTotalBuilderCount
	$g_iFreeBuilderCount = $wasFreeBuilderCount

	SetLog("Test Builder Time OCR Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestBuilderTimeOCR

Func btnTestGlobalChatBot()
	SetLog("Test Global Chat Bot Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasChkChatGlobal = $g_bChatGlobal
	Local $wasChkChatClan = $g_bChatClan
	;For Debug Purpose set these values temporarily
	$g_bRunState = True
	$g_bChatGlobal = True
	$g_bChatClan = False

	ChatbotMessage()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_bChatGlobal = $wasChkChatGlobal
	$g_bChatClan = $wasChkChatClan

	SetLog("Test Global Chat Bot Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestGlobalChatBot


Func btnTestClanChatBot()
	SetLog("Test Global Chat Bot Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasChkChatGlobal = $g_bChatGlobal
	Local $wasChkChatClan = $g_bChatClan
	Local $wasClanAlwaysMsg = $g_bClanAlwaysMsg
	;For Debug Purpose set these values temporarily
	$g_bRunState = True
	$g_bChatGlobal = False
	$g_bChatClan = True
	$g_bClanAlwaysMsg = True

	ChatbotMessage()

	;Reset to orignal state
	$g_bClanAlwaysMsg = $wasClanAlwaysMsg
	$g_bRunState = $wasRunState
	$g_bChatGlobal = $wasChkChatGlobal
	$g_bChatClan = $wasChkChatClan

	SetLog("Test Global Chat Bot Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestClanChatBot



Func btnTestWardenMode()
	SetLog("Test Grand Warden Mode Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasCheckWardenMode = $g_bCheckWardenMode
	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bCheckWardenMode = True

	checkMainScreen()
	CheckWardenMode(True, True)

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_bCheckWardenMode = $wasCheckWardenMode

	SetLog("Test Grand Warden Mode Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestWardenMode

Func btnTestTNRQT()
	SetLog("Test TNRQT Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasSmartQueueSystem = $g_bSmartQueueSystem
	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bSmartQueueSystem = True

	TNRQT(False, True, True, True)

	;Reset to orignal state
	$g_bSmartQueueSystem = $wasSmartQueueSystem
	$g_bRunState = $wasRunState

	SetLog("Test TNRQT Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestTNRQT

Func btnTestCheckOneGem()
	SetLog("Test Check One Gem Boost Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasFirstStart = $g_bFirstStart
	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bFirstStart = True

	checkMainScreen()
	OneGemBoost()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_bFirstStart = $wasFirstStart

	SetLog("Test Check One Gem Boost Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestCheckOneGem

Func btnTestBotHumanization()
	SetLog("Test Bot Humanization Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasUseBotHumanization = $g_bUseBotHumanization
	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bUseBotHumanization = True

	BotHumanization()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_bUseBotHumanization = $wasUseBotHumanization

	SetLog("Test Bot Humanization Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestBotHumanization

Func btnTestGoblinXP()
	SetLog("Test GoblinXP Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasFirstStart = $g_bFirstStart
	Local $wasEnableSuperXP = $g_bEnableSuperXP
	Local $wasSXTraining = $g_irbSXTraining
	Local $wasDebugSX = $g_bDebugSX
	Local $waschkSXBK = $g_bSXBK
	Local $waschkSXAQ = $g_bSXAQ
	Local $waschkSXGW = $g_bSXGW

	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bFirstStart = True
	$g_bEnableSuperXP = True
	$g_irbSXTraining = 2
	$g_bDebugSX = True

	$g_bSXBK = $eHeroKing
	$g_bSXAQ = $eHeroQueen
	$g_bSXGW = $eHeroWarden

	MainSuperXPHandler()

	;Reset to orignal state

	$g_bFirstStart = $wasFirstStart
	$g_bEnableSuperXP = $wasEnableSuperXP
	$g_irbSXTraining = $wasSXTraining
	$g_bDebugSX = $wasDebugSX

	$g_bSXBK = $waschkSXBK
	$g_bSXAQ = $waschkSXAQ
	$g_bSXGW = $waschkSXGW
	$g_bRunState = $wasRunState

	SetLog("Test GoblinXP Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestGoblinXP

Func btnForceStopBot()
	SetLog("Going to force stop the bot.", $COLOR_DEBUG)
	If $g_bRunState Then
		SetLog("Sucessfully Stopped The BOT", $COLOR_SUCCESS)
		; always invoked in MyBot.run.au3!ø
		$g_bRunState = False ; Exit BotStart()
	Else
		SetLog("Sorry, BOT is already Stopped", $COLOR_ERROR)
	EndIf
	$g_iBotAction = $eBotStop
EndFunc   ;==>btnForceStopBot

Func btnDragNDropQueue()
	SetLog("Test DragNDropQueue Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasSmartQueueSystem = $g_bSmartQueueSystem
	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bSmartQueueSystem = True

	DragNDropQueue()

	;Reset to orignal state
	$g_bSmartQueueSystem = $wasSmartQueueSystem
	$g_bRunState = $wasRunState

	SetLog("Test DragNDropQueue Ended", $COLOR_DEBUG)

EndFunc   ;==>btnDragNDropQueue

Func btnTestLabUpgrade()
	SetLog("Test Laboratory Upgrade Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasLabCheck = $g_iLabCheck

	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_iLabCheck = 1

	checkMainScreen()
	If _Sleep(2000) Then Return
	GetLabLevel(True)
	Laboratory()

	;Reset to orignal state
	$g_bRunState = $wasRunState
	$g_iLabCheck = $wasLabCheck

	EnableGuiControls(True)
	SetLog("Test Laboratory Upgrade Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestLabUpgrade


Func btnTestBuilderBaseAtk()
	SetLog("Test Builder Base Attack Started", $COLOR_DEBUG)

	Local $bBuilderBase = True
	Local $wasRunState = $g_bRunState
	Local $wasChkBB_DropTrophies = $g_bChkBB_DropTrophies
	Local $wasTxtBB_DropTrophies = $g_iTxtBB_DropTrophies
	Local $wasRestart = $g_bRestart

	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bChkBB_DropTrophies = True
	$g_iTxtBB_DropTrophies = 1
	$g_bRestart = False

	If Not isOnBuilderBase(True) Then ; Check if already on Builder base
		ClickP($aAway, 1, 0, "#0332") ;Click Away
		If Not SwitchBetweenBases($bBuilderBase) Then Return ; Switching to Builders Base
	Else
		checkMainScreen(True, $bBuilderBase)
	EndIf

	If IsMainPageBuilderBase() Then ; Double Check to see if Bot is on builder base
		BuilderBaseReport()
		BB_DropTrophies()
	Else
		SetLog("Unable to detect Builder Base", $COLOR_ERROR)
	EndIf

	;Reset to orignal state
	$g_iTxtBB_DropTrophies = $wasTxtBB_DropTrophies
	$g_bChkBB_DropTrophies = $wasChkBB_DropTrophies
	$g_bRunState = $wasRunState
	$g_bRestart = $wasRestart
	SetLog("Test Builder Base Attack Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestBuilderBaseAtk


Func btnTestBuilderBaseObs()
	SetLog("Test Builder Base Remove Obstacles Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasCleanYardBB = $g_bChkCleanYardBB
	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bChkCleanYardBB = True

	CleanYardBB() ;

	;Reset to orignal state
	$g_bChkCleanYardBB = $wasCleanYardBB
	$g_bRunState = $wasRunState

	SetLog("Test Builder Base Remove Obstacles Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestBuilderBaseObs


Func btnTestGTFO()
	SetLog("Test GTFO Started", $COLOR_DEBUG)

	Local $wasRunState = $g_bRunState
	Local $wasUseGTFO = $g_bChkUseGTFO
	;For Debug Purpose set run state to true temporarily
	$g_bRunState = True
	$g_bChkUseGTFO = True

	MainGTFO()

	;Reset to orignal state
	$g_bChkUseGTFO = $wasUseGTFO
	$g_bRunState = $wasRunState

	SetLog("Test GTFO Ended", $COLOR_DEBUG)

EndFunc   ;==>btnTestGTFO
