Scriptname Fallout:Saving:Context extends Papyrus:Project:Context Conditional
import Papyrus:Compatibility:External
import Papyrus:Diagnostics:Log
import Papyrus:VersionType

UserLog Log



; Events
;---------------------------------------------

Event OnInitialize()
	Log = Log(Title, self)
	Required = MQ102
	RequiredStage = 1
	HasActivated = false
EndEvent


Event OnContextStartup()
	HasActivated = true
	Write(Title, "The context has started.")
EndEvent


Event OnContextShutdown()
	HasActivated = false
	Write(Title, "The context has shutdown.")
EndEvent


; Context
;---------------------------------------------

string Function GetTitle()
	return "Saving"
EndFunction


string[] Function GetAuthors()
	string[] values = new string[1]
	values[0] = "Scrivener07"
	return values
EndFunction


Version Function GetVersion()
	Version value = new Version
	value.Major = 0
	value.Minor = 0
	value.Build = 0
	value.Revision = 1
	value.Distribution = false
	return value
EndFunction


ExternalForm Function Context()
	ExternalForm value = new ExternalForm
	value.FormID = 0x00000800
	value.FileName = "Saving.esp"
	return value
EndFunction


; Properties
;---------------------------------------------

Group Properties
	bool Property HasActivated Auto Hidden Conditional
	Quest Property MQ102 Auto Const Mandatory
EndGroup

