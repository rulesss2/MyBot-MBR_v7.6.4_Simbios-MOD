; #FUNCTION# ====================================================================================================================
; Name ..........: SM Attack Now
; Description ...: This file creates the "Attack Now" tab under the "Deadbase & Activebase Attack" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Mr.Viper
; Modified ......: Fahid.Mahmood
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2018
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func AttackNowAB()
	; Assign the Live Bases attack
	SetLog("Begin Live Base Attack TEST", $COLOR_INFO)
	SetLog("NOTE: It will not attack on WAR Or Friendly Challenge Base.", $COLOR_INFO)

	$g_iMatchMode = $LB ; Select Live Base As Attack Type

	$g_aiAttackAlgorithm[$LB] = 1 ; Select Scripted Attack
	cmbCSVSpeed(); call After setting $g_iMatchMode & $g_aiAttackAlgorithm
	$g_sAttackScrScriptName[$LB] = GUICtrlRead($g_hCmbScriptNameAB) ; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button

	; Getting the Run state
	Local $tempbRunState = $g_bRunState
	$g_bRunState = True
	; Getting the Siege Machines
	Local $tempSieges = $g_aiCurrentSiegeMachines
	$g_aiCurrentSiegeMachines[$eSiegeWallWrecker] = 1
	$g_aiCurrentSiegeMachines[$eSiegeBattleBlimp] = 1


	SetLog("Script Name : " & $g_sAttackScrScriptName[$LB], $COLOR_INFO)

	; only one capture here, very important for consistent debug images, zombies, redline calc etc.
	ForceCaptureRegion()
	_CaptureRegion2()

	; Let's check the ZoomOut
	SetLog("Check ZoomOut...", $COLOR_INFO)
	If CheckZoomOut("VillageSearch", True, False) = False Then
		; check two more times, only required for snow theme (snow fall can make it easily fail), but don't hurt to keep it
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($DELAYPREPARESEARCH2) Then Return ; wait 500 ms
			ForceCaptureRegion()
			_CaptureRegion2()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, False)
		Until $bMeasured = True Or $i >= 2

		If Not $bMeasured Then
			SetLog("Screen Was Not Zoomed Out, Now It is Please try Now!", $COLOR_ERROR)
			;Rest to default State
			$g_bRunState = $tempbRunState
			$g_aiCurrentSiegeMachines = $tempSieges
			Return ; exit func
		EndIf
	EndIf

	; Reset the TH and Buildings detection Obj
	ResetTHsearch()
	_ObjDeleteKey($g_oBldgAttackInfo, "") ; Remove all keys from building dictionary

	FindTownhall(True)

	; Get attack bar , troops , spells etc
	PrepareAttack($g_iMatchMode)

	; Attack
	Attack()

	SetLog("Check Heroes Health and waiting battle for end.", $COLOR_INFO)
	While IsAttackPage() And ($g_bCheckKingPower Or $g_bCheckQueenPower Or $g_bCheckWardenPower)
		CheckHeroesHealth()
		If _Sleep(500) Then Return
	WEnd
	SetLog("End Live Base Attack TEST", $COLOR_INFO)
	;Rest to default State
	$g_bRunState = $tempbRunState
	$g_aiCurrentSiegeMachines = $tempSieges
EndFunc   ;==>AttackNowAB

Func AttackNowDB()
	; Assign the Dead Bases attack
	SetLog("Begin Dead Base Attack TEST", $COLOR_INFO)
	SetLog("NOTE: It will not attack on WAR Or Friendly Challenge Base.", $COLOR_INFO)

	$g_iMatchMode = $DB ; Select Dead Base As Attack Type

	$g_aiAttackAlgorithm[$DB] = 1 ; Select Scripted Attack
	cmbCSVSpeed(); call After setting $g_iMatchMode & $g_aiAttackAlgorithm
	$g_sAttackScrScriptName[$DB] = GUICtrlRead($g_hCmbScriptNameDB) ; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button

	; Getting the Run state
	Local $tempbRunState = $g_bRunState
	$g_bRunState = True
	; Getting the Siege Machines
	Local $tempSieges = $g_aiCurrentSiegeMachines
	$g_aiCurrentSiegeMachines[$eSiegeWallWrecker] = 1
	$g_aiCurrentSiegeMachines[$eSiegeBattleBlimp] = 1

	SetLog("Script Name : " & $g_sAttackScrScriptName[$DB], $COLOR_INFO)

	; only one capture here, very important for consistent debug images, zombies, redline calc etc.
	ForceCaptureRegion()
	_CaptureRegion2()

	; Let's check the ZoomOut
	SetLog("Check ZoomOut...", $COLOR_INFO)
	If CheckZoomOut("VillageSearch", True, False) = False Then
		; check two more times, only required for snow theme (snow fall can make it easily fail), but don't hurt to keep it
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($DELAYPREPARESEARCH2) Then Return ; wait 500 ms
			ForceCaptureRegion()
			_CaptureRegion2()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, False)
		Until $bMeasured = True Or $i >= 2
		If Not $bMeasured Then
			SetLog("Screen Was Not Zoomed Out, Now It is Please try Now!", $COLOR_ERROR)
			;Rest to default State
			$g_bRunState = $tempbRunState
			$g_aiCurrentSiegeMachines = $tempSieges
			Return ; exit func
		EndIf
	EndIf

	; Reset the TH and Buildings detection Obj
	ResetTHsearch()
	_ObjDeleteKey($g_oBldgAttackInfo, "") ; Remove all keys from building dictionary

	FindTownhall(True)

	; Get attack bar , troops , spells etc
	PrepareAttack($g_iMatchMode)
	; Attack
	Attack()
	SetLog("Check Heroes Health and waiting battle for end.", $COLOR_INFO)
	While IsAttackPage() And ($g_bCheckKingPower Or $g_bCheckQueenPower Or $g_bCheckWardenPower)
		CheckHeroesHealth()
		If _Sleep(500) Then Return
	WEnd
	SetLog("End Dead Base Attack TEST")
	;Rest to default State
	$g_bRunState = $tempbRunState
	$g_aiCurrentSiegeMachines = $tempSieges
EndFunc   ;==>AttackNowDB
