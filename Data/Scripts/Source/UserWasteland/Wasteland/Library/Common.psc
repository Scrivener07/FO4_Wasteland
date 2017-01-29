Scriptname Wasteland:Library:Common Hidden

; Version
;---------------------------------------------

Struct Version
	int Major = 0
	int Minor = 0
	int Build = 0
	int Revision = 0
	bool DeveloperOnly = true
EndStruct

string Function VersionGetString(Version aVersion) Global
	string sDevOnly
	If (aVersion.DeveloperOnly)
		sDevOnly = "[DEV]"
	Else
		sDevOnly = "[REL]"
	EndIf
	return aVersion.Major+"."+aVersion.Minor+"."+aVersion.Build+"."+aVersion.Revision+" "+sDevOnly
EndFunction


; Text
;---------------------------------------------

bool Function StringIsNoneOrEmpty(string value) Global
	return !(value) || value == ""
EndFunction



; Array
;---------------------------------------------

var[] Function GetDistint(var[] aArray) Global
	var[] uniques = new var[0]

	int index = 0
	While (index < aArray.Length)
		var element = aArray[index]
		If (uniques.Find(element) == -1)
			uniques.Add(element)
		EndIf
		index += 1
	EndWhile

	return uniques
EndFunction
