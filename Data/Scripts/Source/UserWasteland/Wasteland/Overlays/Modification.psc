Scriptname Wasteland:Overlays:Modification extends Quest
import Wasteland:Library:Common
import Wasteland:Library:Log


; Meta
;---------------------------------------------

string Function GetTitle() Global
	return "Wasteland Overlays"
EndFunction


string Function GetPluginName() Global
	return "WastelandOverlays.esp"
EndFunction


string[] Function GetAuthors() Global
	string[] array = new string[0]
	array.Add("Scrivener07")
	array.Add("D1v1ne122")
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
	int iFormID = 0x00000F99 const
	return Game.GetFormFromFile(iFormID, sPlugin) as Modification
EndFunction
