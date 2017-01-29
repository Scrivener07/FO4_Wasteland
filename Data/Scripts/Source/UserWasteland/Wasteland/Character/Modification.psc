Scriptname Wasteland:Character:Modification extends Quest
import Wasteland:Character:Skills
import Wasteland:Library:Common
import Wasteland:Library:Log


Group Components
	System Property Skills Auto Const Mandatory
EndGroup


; Meta
;---------------------------------------------

string Function GetTitle() Global
	return "Wasteland Character"
EndFunction


string Function GetPluginName() Global
	return "WastelandCharacter.esp"
EndFunction


string[] Function GetAuthors() Global
	string[] array = new string[0]
	array.Add("Scrivener07")
	array.Add("Sireyn")
	return array
EndFunction


Version Function GetVersion() Global
	Version current = new Version
	current.DeveloperOnly = true
	current.Major = 0
	current.Minor = 0
	current.Build = 1
	current.Revision = 0
	return current
EndFunction


; Inter-mod Communication
;---------------------------------------------
; http://www.creationkit.com/fallout4/index.php?title=Inter-mod_Communication

Modification Function Modification() Global
	string sPlugin = GetPluginName() const
	int iFormID = 0x00005B9E const
	return Game.GetFormFromFile(iFormID, sPlugin) as Modification
EndFunction
