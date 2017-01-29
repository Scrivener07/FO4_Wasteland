Scriptname Wasteland:Character:Skills:Data:Blunt extends Wasteland:Character:Skills:Client
import Wasteland:Character:Modification
import Wasteland:Character:Skills
import Wasteland:Library:Log

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
	skill.Name = "Blunt"
	skill.Description = "Using blunted weapons in melee combat such as crowbars, hammers, pipes, clubs and so on."
	return skill
EndFunction

; Experience
;---------------------------------------------
