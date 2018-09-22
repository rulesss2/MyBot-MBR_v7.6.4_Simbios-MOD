; #FUNCTION# ====================================================================================================================
; Name ..........: MyBot Theme
; Description ...:
; Syntax ........: GUI Theme
; Parameters ....: None
; Return values .: None
; Author ........: Bushido-21 (2015)
; Modified ......: RF (2016)
; Remarks .......: This file is part of MyBot.Run Copyright 2015
;                  MyBot.run is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func btnLoadTheme()
	Local $sFileOpenDialog = FileOpenDialog(GetTranslated(601,26, "Open theme file"), @ScriptDir & "\Themes\", "MS Theme (*.msstyles;)", $FD_FILEMUSTEXIST + $FD_MULTISELECT)

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", GetTranslated(601,25, "Error opening file!"))
		FileChangeDir(@ScriptDir)
	Else
		FileChangeDir(@ScriptDir)
		$sFileOpenDialog = StringReplace($sFileOpenDialog, "|", @CRLF)
		$ThemeConfig = $sFileOpenDialog
	    _USkin_LoadSkin($ThemeConfig)
		writeThemeConfig()
	$ThemeName = StringRegExpReplace(IniRead(@ScriptDir & "\Themes\skin.ini", "skin", "skin", @ScriptDir & "\Themes\Themes\MyBot Default Skin.msstyles"), '^(?:.*\\)([^\\]*?)(?:\.[^.]+)?$', '\1')	
	    SetLog(GetTranslated(601, 28, "Theme modified") & ":" & " " & $ThemeName, $COLOR_ORANGE)
	EndIf
	
EndFunc   ;==>btnLoadTheme

Func readThemeConfig()
    $ThemeConfig = IniRead(@ScriptDir & "\Themes\skin.ini", "skin", "skin", @ScriptDir & "\Themes\Themes\MyBot Default Skin.msstyles")
	_USkin_Init($ThemeConfig)
 EndFunc

Func writeThemeConfig()
	IniWrite(@ScriptDir & "\Themes\skin.ini", "skin", "skin", $ThemeConfig)
EndFunc
