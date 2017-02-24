Scriptname Wasteland:Character:Skills:Display:SkillProgram extends ObjectReference
import Wasteland:Character:Modification
import Wasteland:Character:Skills:System
import Shared:Log

; http://www.creationkit.com/fallout4/index.php?title=Text_Replacement
; http://www.creationkit.com/fallout4/index.php?title=AddTextReplacementData_-_ObjectReference

; Variables
;---------------------------------------------
UserLog Log

string DataToken = "DataToken" const
ObjectReference LastTerminal


Group Properties
	Wasteland:Character:Modification Property WCM Auto Const Mandatory
	Message Property Character_Skill_ProgramMessage Auto Const Mandatory
EndGroup


; Initialize
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = GetTitle()
EndEvent


; Holotapes
;---------------------------------------------

Event OnHolotapePlay(ObjectReference akTerminalRef)
	Writeline(Log, "OnHolotapePlay(akTerminalRef="+akTerminalRef+")")

	If (akTerminalRef)
		LastTerminal = akTerminalRef
	EndIf

	string data = DataString(WCM)

	; I cannot create a string and pass it to AddTextReplacementData. It must use a Form.
	; As a place holder I am using the Message "Character_Skill_ProgramMessage" in place of "data"
	LastTerminal.AddTextReplacementData(DataToken, Character_Skill_ProgramMessage)
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


; Data
;---------------------------------------------

string Function DataString(Wasteland:Character:Modification aWCM)
	If (aWCM == none)
		WriteLine(Log, "Could not get an instance for user modification.")
		return none
	else
		ClientEntry[] entries = aWCM.Skills.GetEntries()
		string datastring = ""

		int idx = 0
		While (idx < entries.Length)
			ClientEntry entry = entries[idx]
			datastring += entry.Name + "Token|" ; are spaces in name okay?

			idx += 1
		EndWhile

		; Creates a data string of each skill token separated by a pipe '|'
		; example: "DummyToken|BarterToken|LeadershipToken|ExplorationToken|"

		; The menu must know the text replacement token name to get the value.
		; I dont want to hard code all possible skill data tokens into the skill program
		; The skill program will lookup the "DataToken" value which is known by SkillProgram.as
		; The data string can be parsed into a string token array with AS3.
		; With all the token names for skills at hand I can use AS3 to retrieve the values.

		Writeline(Log, "The data string equals '"+datastring+"'.")
		return datastring
	EndIf
EndFunction
