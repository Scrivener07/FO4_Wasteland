Scriptname Wasteland:Library:Log Hidden DebugOnly
import Wasteland:Library:Common


Struct UserLog
	string Label
	string Caller
	string FileName
EndStruct


; User Log
;---------------------------------------------

bool Function WriteLine(UserLog log, var text) Global
	If (StringIsNoneOrEmpty(log.FileName))
		; dots are also not accepted in filename
		return false
	Else
		text = log.Caller + " :" + log.Label + ": " + text

		If(Debug.TraceUser(log.FileName, text))
			return true
		Else
			Debug.OpenUserLog(log.FileName)
			return Debug.TraceUser(log.FileName, text)
		EndIf
	EndIf
EndFunction


Function WriteChangedValue(UserLog log, string propertyName, var fromValue, var toValue) Global
	log.Label = "ChangedValue"
	WriteLine(log, "Setting "+propertyName+" from " + fromValue + " to " + toValue)
EndFunction


Function WriteNotification(UserLog log, var text) Global
	log.Label = "Notification"
	If (WriteLine(log, text))
		Debug.Notification(text)
	EndIf
EndFunction


Function WriteMessage(UserLog log, var text) Global
	log.Label = "MessageBox"
	If (WriteLine(log, text))
		Debug.MessageBox(text)
	EndIf
EndFunction


Function WriteError(UserLog log, var text) Global
	log.Label = "Error"
	If (WriteLine(log, text))
		Debug.MessageBox(log.Label+"\n"+text)
	EndIf
EndFunction
