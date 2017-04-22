Scriptname Fallout:Saving:Settings:Activation extends Terminal
import Fallout
import Papyrus:Diagnostics:Log

UserLog Log

int OptionStartup = 4 const
int OptionShutdown = 1 const


; Events
;---------------------------------------------

Event OnInit()
	Log = LogNew(Context.Title, self)
EndEvent


Event OnMenuItemRun(int auiMenuItemID, ObjectReference akTerminalRef)
	WriteLine(Log, "OnMenuItemRun :: auiMenuItemID="+auiMenuItemID + ", akTerminalRef="+akTerminalRef)

	If (auiMenuItemID == OptionStartup)
		Context.IsActivated = true
	ElseIf (auiMenuItemID == OptionShutdown)
		Context.IsActivated = false
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Saving:Context Property Context Auto Const Mandatory
EndGroup
