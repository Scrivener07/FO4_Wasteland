Scriptname Wasteland:Overlays:OverlayProgram extends ObjectReference
import Shared:Log


; Variables
;---------------------------------------------
UserLog Log

string DataToken = "DataToken" const
ObjectReference LastTerminal


Group Properties
	Message Property Overlays_ProgramMessage Auto Const Mandatory
EndGroup


; Initialize
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = Wasteland:Overlays:Modification.GetTitle()
EndEvent


; Holotapes
;---------------------------------------------

Event OnHolotapePlay(ObjectReference akTerminalRef)
	Writeline(Log, "OnHolotapePlay(akTerminalRef="+akTerminalRef+")")

	If (akTerminalRef)
		LastTerminal = akTerminalRef
	EndIf

	; Message equals "banana.png"

	LastTerminal.AddTextReplacementData(DataToken, Overlays_ProgramMessage)
	Writeline(Log, "Sent the message '"+ Overlays_ProgramMessage + "' to OverlayProgram.as")
EndEvent


Event OnHolotapeChatter(string asChatter, float afNumericData)
	; Event that occurs when a flash program on a holotape wants to communicate with script.
	Writeline(Log, "________________________")
	Writeline(Log, "| HOLOTAPE LISTENER")
	Writeline(Log, "|   Received Chatter")
	Writeline(Log, "|   Chatter: "+asChatter)
	Writeline(Log, "|   Numeric: "+afNumericData)
	Writeline(Log, "________________________")
EndEvent
