Scriptname Wasteland:Character:Skills:System extends Quest
import Wasteland:Character
import Wasteland:Character:Modification
import Wasteland:Library:Common
import Wasteland:Library:Log

UserLog Log
CustomEvent ReadyEvent
CustomEvent ResetEvent
CustomEvent ShutdownEvent
ClientEntry[] Clients




Struct ClientEntry
	string Name
	Skills:Client Script = none
EndStruct


; Events
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = GetTitle()
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
			WriteError(Log, "Could not add the entry " + entry.Name + " because it already exists.")
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
			WriteError(Log, "Could not find " + aScript.Name + " to unregister.")
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
