#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_outfile=Panel Restore.exe
#AutoIt3Wrapper_Res_Comment=Restore your Fsx Panels positions
#AutoIt3Wrapper_Res_Description=Restore your Fsx Panels positions
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=CASAWAVE
#AutoIt3Wrapper_Res_Field=Author|Stéphane Péneau
#AutoIt3Wrapper_Res_Field=Company|CASAWAVE
#AutoIt3Wrapper_Res_Field=Date|%longdate%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; Author : Stéphane Péneau
; Company: Casawave

#include <Array.au3>
#include <String.au3>
AutoItSetOption( "WinDetectHiddenText",1)

Dim $var
$i=1

; Get the size of the active window
Local $Dimensions = WinGetPos('')
Local $WinWidth = $Dimensions[2]
Local $WinHeight = $Dimensions[3]

; Compare to the desktop size
If $WinWidth >= @DesktopWidth And $WinHeight >= @DesktopHeight Then
	Exit
EndIf

;~ Retrieve the Aircraft name

$aircraftname=WinGetText("Microsoft Flight Simulator X","$") ; Get the Hidden Text
$aircraftname=StringStripCR($aircraftname) ; Remove carrier return
;~ MsgBox(0,"",$aircraftname)
$aircraftname=StringReplace($aircraftname,Chr(10),"") ; Remove Carrier return
;~ MsgBox(0,"Return Stringreplace",$aircraftname)
;~ MsgBox(0,"",$aircraftname)
$first=StringInStr($aircraftname, "$") ; Find the first '$' character
;~ MsgBox(0,"","premier $ au bout de " & $first)
$aircraftname=StringTrimLeft($aircraftname, $first) ; Left Trim 
;~ MsgBox(0,"",$aircraftname)
; Check if another '$' is present and delete the end of the string if needed.
If StringInStr($aircraftname, "$")<>0 Then 
$aircraftname=StringTrimRight($aircraftname, StringLen($aircraftname)-StringInStr($aircraftname, "$")+1)
EndIf
;~ $aircraftname=StringTrimRight($aircraftname,1)
;~ MsgBox(0,"",$aircraftname & ".ini")



If FileExists($aircraftname & ".ini")=0	Then
	MsgBox(4096,"","Error ! No ini file present")
	Exit
EndIf

$windownamelist=IniReadSectionNames($aircraftname & ".ini")
;~ _ArrayDisplay($windownamelist)
;~ MsgBox(0,"","nbr de section :" & $windownamelist[0])
For $i=1 to $windownamelist[0] 
	$infosection=IniReadSection($aircraftname & ".ini", $windownamelist[$i])
	WinActivate("Microsoft Flight Simulator X")
    WinMove($infosection[1][1],"",$infosection[2][1],$infosection[3][1],$infosection[4][1],$infosection[5][1])
Next


;~ Send("!{ENTER}")


#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%