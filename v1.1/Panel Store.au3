#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_outfile=Panel Store.exe
#AutoIt3Wrapper_Res_Comment=Store your Fsx Panels positions
#AutoIt3Wrapper_Res_Description=Store your Fsx Panels positions
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
; CHECK IF A WINDOW IS IN FULLSCREEN MODE
; Get the size of the active window
Local $Dimensions = WinGetPos('')
Local $WinWidth = $Dimensions[2]
Local $WinHeight = $Dimensions[3]

; Compare to the desktop size
If $WinWidth >= @DesktopWidth And $WinHeight >= @DesktopHeight Then
	Exit
EndIf

; DELETE THE OLD INI FILE

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
FileDelete ($aircraftname & ".ini")
;~ $return=IniWrite ($aircraftname & ".ini","window ","name","truc")
;~ MsgBox(0,"",$return)
;~ Exit	



;~ ; RECHERCHE DES FENETRES ET STOCKAGE DES POSITIONS (MODE FENETREE)
$var = WinList("[CLASS:FS98FLOAT]")
ReDim $var[UBound($var)][Ubound($var,2)+5]
$i=1

While $i <> $var[0][0]
  ; Only display visible windows that have class=FS98FLOAT
  If $var[$i][0] <> "" AND IsVisible($var[$i][1]) Then
	  $i=$i+1
  Else
;~ 	  MsgBox(0,"","nbr de ligne = " & $var[0][0])
	  delete_array_row($var,2,$i,$i)
	  $var[0][0]=$var[0][0]-1
;~ 	  _ArrayDisplay($var)
  EndIf
WEnd

For $i=1 to $var[0][0]
	$pos=WinGetPos($var[$i][0])
;~ 	_ArrayDisplay($pos)
;~ MsgBox(0,"",$pos)
	If UBound($pos) <> 0 Then
		$var[$i][1]=$pos[0]
		$var[$i][2]=$pos[1]
		$var[$i][3]=$pos[2]
		$var[$i][4]=$pos[3]
	EndIf
	
Next


; RECHERCHE DES FENETRES ET STOCKAGE DES POSITIONS (MODE FENETREE)

; STOCKAGE DES INFOS DANS UN FICHIER INI
For $i=1 to $var[0][0]-1
IniWrite ($aircraftname & ".ini","window "&$i,"name",$var[$i][0])
IniWrite ($aircraftname & ".ini","window "&$i,"x",$var[$i][1])
IniWrite ($aircraftname & ".ini","window "&$i,"y",$var[$i][2])
IniWrite ($aircraftname & ".ini","window "&$i,"width",$var[$i][3])
IniWrite ($aircraftname & ".ini","window "&$i,"height",$var[$i][4])

Next


Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then 
    Return 1
  Else
    Return 0
  EndIf

EndFunc

Func delete_array_row(ByRef $array, $dimcount, $row_start, $row_end)
    For $row = $row_start to $row_end
        If $dimcount = 2 Then
            For $a = $row to UBound($array,1) - 2
                For $b = 0 to UBound($array,2) - 1
                    $array[$a][$b] = $array[$a+1][$b]
                Next
            Next
            ReDim $array[UBound($array,1)-1][UBound($array,2)]
        Else
            For $a = $row to UBound($array,1) - 2
                $array[$a] = $array[$a+1]
            Next
            ReDim $array[UBound($array,1)-1]
        EndIf
    Next
    Return
EndFunc
