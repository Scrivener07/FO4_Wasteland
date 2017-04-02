Scriptname Fallout:Gameplay:Startup extends Papyrus:Project:Modules:Required
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInitialize()
	Log = Log(Context.Title, self)
EndEvent


Event OnEnable()
	WriteLine(Log, "Startup Module has been enabled.")
EndEvent


Event OnDisable()
	WriteLine(Log, "Startup Module has been disabled.")
EndEvent
