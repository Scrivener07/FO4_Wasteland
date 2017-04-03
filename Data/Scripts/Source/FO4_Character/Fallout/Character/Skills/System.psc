Scriptname Character:Skills:System extends Quest
import Character
import Papyrus:StringType
import Papyrus:Diagnostics:Log
import Papyrus

UserLog Log

CustomEvent ReadyEvent
CustomEvent ResetEvent
CustomEvent ShutdownEvent

ClientEntry[] Clients



; Properties
;---------------------------------------------

Group Properties
	Project:Context Property Context Auto Const Mandatory
EndGroup


Struct ClientEntry
	string Name
	Skills:Client Script = none
EndStruct


; Events
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = Context.Title

	Clients = new ClientEntry[0]
	Actor Player = Game.GetPlayer()
	RegisterForRemoteEvent(Player, "OnPlayerLoadGame")
EndEvent


Event OnQuestInit()
	WriteLine(Log, "OnQuestInit")
	StartTimer(5)
EndEvent


Event OnQuestShutdown()
	WriteLine(Log, "Sending the shutdown event..")
	SendCustomEvent("ShutdownEvent")
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	WriteLine(Log, "OnPlayerLoadGame")
	StartTimer(5)
EndEvent


Event OnTimer(int aiTimerID)
	WriteLine(Log, "Sending the ReadyEvent..")
	Utility.Wait(5.0)
	SendCustomEvent("ReadyEvent")
EndEvent



; Data
;---------------------------------------------

bool Function Register(Skills:Client aScript)
	If (aScript == none)
		return false
	ElseIf (StringIsNoneOrEmpty(aScript.Name))
		return false
	Else
		ClientEntry entry = new ClientEntry
		entry.Script = aScript
		entry.Name = aScript.Name

		If (Contains(entry) == false)
			WriteLine(Log, "Adding the entry " + entry.Name)
			Clients.Add(entry)
			return true
		Else
			WriteLine(Log, "Could not add the entry " + entry.Name + " because it already exists.")
			return false
		EndIf
	EndIf
EndFunction


bool Function Unregister(Skills:Client aScript)
	If (aScript == none)
		return false
	Else
		int index = FindByScript(aScript)

		If (index > -1)
			WriteLine(Log, "Unregistering " + aScript.Name)
			Clients.Remove(index)
			return true
		Else
			WriteLine(Log, "Could not find " + aScript.Name + " to unregister.")
			return false
		EndIf
	EndIf
EndFunction


bool Function Contains(ClientEntry entry)
	If (FindByName(entry.Name) > -1)
		WriteLine(Log, "Contains an entry with the same name as " + entry.Name)
		return true
	ElseIf (FindByScript(entry.Script) > -1)
		WriteLine(Log, "Contains an entry with the same script instance as " + entry.Name)
		return true
	Else
		return false
	EndIf
EndFunction


int Function FindByName(string asName)
	return Clients.FindStruct("Name", asName)
EndFunction


int Function FindByScript(Skills:Client aScript)
	return Clients.FindStruct("Script", aScript)
EndFunction


ClientEntry[] Function GetEntries()
	return Clients
EndFunction
