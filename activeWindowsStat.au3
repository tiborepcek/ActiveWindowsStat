#cs
	ActiveWindowsStat 1.0 written in AutoIt 3
	Description: This program identifies active window every second and get the name of its process. The name is written to a text file $iniFile in INI format in section “processes” like this: name of a process = seconds count. The only way to end this program is to kill its process in task manager. ActiveWindowsStat does not have graphical user interface and needs minimum computer performance.
	Author: Tibor Repček
	Web: http://tiborepcek.com/
#ce

#NoTrayIcon

#include <Process.au3>

$iniFile = @ScriptDir & "\tracked.ini"

IniWrite($iniFile, "init", "start",  @MDAY & "." & @MON & "." & @YEAR & "," & @HOUR & ":" & @MIN & ":" & @SEC)
IniWrite($iniFile, "init", "comp",  @ComputerName)
IniWrite($iniFile, "init", "user",  @UserName)
IniWrite($iniFile, "init", "osVer",  @OSVersion)
IniWrite($iniFile, "init", "osBuild",  @OSBuild)
IniWrite($iniFile, "init", "osSP",  @OSServicePack)
IniWrite($iniFile, "init", "IP1",  @IPAddress1)
IniWrite($iniFile, "init", "IP2",  @IPAddress2)
IniWrite($iniFile, "init", "IP3",  @IPAddress3)
IniWrite($iniFile, "init", "IP4",  @IPAddress4)

While 1
	$winList = WinList()
	For $i = 1 To $winList[0][0]
		If WinActive($winList[$i][1]) Then
			$sec = IniRead($iniFile, "processes", _ProcessGetName(WinGetProcess($winList[$i][1])), "nf")
			If $sec = "nf" Then $sec = 0
			IniWrite($iniFile, "processes", _ProcessGetName(WinGetProcess($winList[$i][1])), $sec + 1)
		EndIf
	Next
	
	Sleep(1000)
WEnd