#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.0
 Author:         Andreas Hofer

 Script Function:
	Schachuhr, Protokollierung von Arbeitszeiten

#ce ----------------------------------------------------------------------------


#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Array.au3>


;# ---- Define Files ---------------------------------
$File_NAME_GlazINI = @ScriptDir & "\" & "GlazTimestamp.ini"
$File_NAME_GlazZeiten = @ScriptDir & "\" & "GlazTimestamp.csv"

;# ---- Define Buttons, PSPs, ... --------------------
Global $aButton_TEXT[1][2] = [["Pause",""]]
Global $AnzButtons

; # Hauptprogramm #########################

; Erzeuge einen Link auf das Script im Autostart Verzeichnis (sofern noch nicht vorhanden).
; Das Script wird dann zum Start von Windowws mit ausgeführt
If Not FileExists(@StartupDir & '\' & @ScriptName & '.lnk') Then
   FileCreateShortcut ( @ScriptFullPath, @StartupDir & '\' & @ScriptName & '.lnk' )
EndIf

CheckFile($File_NAME_GlazZeiten)
GetINIdaten($File_NAME_GlazINI)


Opt("GUIOnEventMode", 1)

#Region ### START Koda GUI section ### Form=d:\_pdata\glaz\au3\form1.kxf

; 3ter Wert ist die Höhe des Fensters ...Button 1 = 57, jeder weitere Button + 30
$Form1_ = GUICreate("Glaz", 116, 57+($AnzButtons*30), 80, 100, BitOR($GUI_SS_DEFAULT_GUI,$DS_SETFOREGROUND))

GUISetOnEvent($GUI_EVENT_CLOSE, "Form1_Close")
;GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1_Minimize")
;GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1_Maximize")
;GUISetOnEvent($GUI_EVENT_RESTORE, "Form1_Restore")

$Label1 = GUICtrlCreateLabel("-- Please select --", 8, 5, 100, 17, $SS_CENTER)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetOnEvent(-1, "Label1Click")

; 2ter Wert immer um 30 mehr: Start=27, 27+30=57, 57+30=87, ...

;#cs --------------------------------------------------------------------------
For $i = 0 To $AnzButtons
   $Button0 = GUICtrlCreateButton($aButton_TEXT[$i][0], 8, 27+($i*30), 100, 25)
   GUICtrlSetOnEvent(-1, "Button" & $i & "Click")
Next

GUISetState(@SW_SHOW)

#EndRegion ### END Koda GUI section ###

; Run the GUI until the dialog is closed
While 1
   Sleep(500)
   $sTime = StringFormat("%.2i.%.2i.%.4i %.2i:%.2i:%.2i", @MDAY, @MON, @YEAR, @HOUR, @MIN, @SEC)
WEnd

Func CheckFile($FName)
   $file = FileOpen($FName, 1)

   ; Prüfen, ob Datei geöffnet werden kann
   If $file = -1 Then
	  MsgBox(0, "GlazTimestamp", "Die Datei konnte nicht geöffnet werden.")
	  Exit
   EndIf

   FileClose($file)
EndFunc

Func GetINIdaten($File_NAME_GlazINI)
    Local Const $sFilePath = $File_NAME_GlazINI

    ; Read the INI section labelled 'GlazThemen'. This will return a 2 dimensional array.
    Local $aArray = IniReadSection($sFilePath, "GlazThemen")

    ; Check if an error occurred.
    If Not @error Then
	    $AnzButtons = $aArray[0][0]
		; Anzahl Einträge auf max 20 begrenzen
		if $AnzButtons > 20 Then
		   $AnzButtons = 20
	    EndIf

#cs ----------------------------------------------------------------------------
        ; Enumerate through the array displaying the keys and their respective values.
        For $i = 1 To $aArray[0][0]
            MsgBox($MB_SYSTEMMODAL, "", "Key: " & $aArray[$i][0] & @CRLF & "Value: " & $aArray[$i][1])
        Next
#ce ----------------------------------------------------------------------------
        ; Umspeichern der Variablen aus dem ini File auf die Buttons
        For $i = 1 To $AnzButtons
		    _ArrayAdd($aButton_TEXT, $aArray[$i][0] & "|" & $aArray[$i][1])
;		    _ArrayAdd($aButton_TEXT, "Aufgabe " & $i & "|" & "PSP Aufgabe " & $i)
        Next
		;_ArrayDisplay($aButton_TEXT, "2D - Item delimited")
    Else
	  MsgBox(0, "FehlerGlazTimestamp", "Fehler beim lesen aus der GlazZeiten.ini Datei.")
    EndIf

EndFunc   ;==>GetINIdaten

Func ButtonClick($i, $aButton, $BColor)
   GUICtrlSetBkColor($Label1, $BColor)
   GUICtrlSetData($Label1, $aButton[$i][0])
   FileWriteLine($File_NAME_GlazZeiten, $aButton[$i][0] & ";" & $aButton[$i][1] & ";" & $sTime & @CRLF)
   GUICtrlSetState($aButton[$i][0], $GUI_FOCUS)
   GUISetState(@SW_MINIMIZE)
EndFunc

; ######## Button Clicks #############################################
Func Button0Click()
   $i = 0
   ButtonClick($i, $aButton_TEXT, 0xFFC000)
EndFunc

Func Button1Click()
   $i = 1
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button2Click()
   $i = 2
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button3Click()
   $i = 3
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button4Click()
   $i = 4
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button5Click()
   $i = 5
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button6Click()
   $i = 6
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button7Click()
   $i = 7
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button8Click()
   $i = 8
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button9Click()
   $i = 9
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button10Click()
   $i = 10
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button11Click()
   $i = 11
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button12Click()
   $i = 12
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button13Click()
   $i = 13
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button14Click()
   $i = 14
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button15Click()
   $i = 15
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button16Click()
   $i = 16
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button17Click()
   $i = 17
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button18Click()
   $i = 18
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button19Click()
   $i = 19
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

Func Button20Click()
   $i = 20
   ButtonClick($i, $aButton_TEXT, 0x99FF33)
EndFunc

; ######## Form Clicks   #############################################
Func Form1_Close()
   FileWriteLine($File_NAME_GlazZeiten, "Logout;;" & $sTime & @CRLF)
   Exit
EndFunc

Func Form1_Maximize()

EndFunc

Func Form1_Minimize()

EndFunc

Func Form1_Restore()

EndFunc

Func Label1Click()

EndFunc

; ####### Erzeugt einen Link im Autostart Verzeichnis damit das Script beim Start von Windows ausgeführt wird
; ####### bzw. löscht das File aus dem Autostart Verzeichnis
Func _Autostart()

   If $Autostart=1 Then
      If Not FileExists(@StartupDir & '\' & @ScriptName & '.lnk') Then
		 FileCreateShortcut ( @ScriptFullPath, @StartupDir & '\' & @ScriptName & '.lnk' )
      EndIf
   Else
      If FileExists(@StartupDir & '\' & @ScriptName & '.lnk') Then
         FileDelete ( @StartupDir & '\' & @ScriptName & '.lnk' )
      EndIf
   EndIf
EndFunc