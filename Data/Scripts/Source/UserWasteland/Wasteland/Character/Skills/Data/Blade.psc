Scriptname Wasteland:Character:Skills:Data:Blade extends Wasteland:Character:Skills:Client
import Wasteland:Character:Modification
import Wasteland:Character:Skills
import Shared:Log

UserLog Log


; Custom Skill
;---------------------------------------------

Function OnInitialize()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = GetTitle()
EndFunction


Client:CustomSkill Function Create(CustomSkill skill)
	WriteLine(Log, "Create")
	skill.Name = "Blade"
	skill.Description = "Using bladed weapons in melee combat such as knives and sharpened tools."
	return skill
EndFunction


; Experience
;---------------------------------------------
