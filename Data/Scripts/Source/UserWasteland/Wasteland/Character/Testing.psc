Scriptname Wasteland:Character:Testing extends Lilac
import Wasteland:Character:Skills
; https://github.com/chesko256/LilacFO4/wiki


Group Testing
	System Property SkillSystem Auto Mandatory
	Client Property DummySkill Auto Mandatory
EndGroup


; Lilac
;---------------------------------------------

Function TestSuites()
	describe("The character skill system", skillSystemSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function skillSystemSuite()
	it("should be able to register a skill script", skillRegisterTest(SkillSystem, DummySkill))
	it("should be able to unregister a skill script", skillRegisterTest(SkillSystem, DummySkill))
	it("should be able to find the default dummy skill by script", skillFindByScriptTest(SkillSystem, DummySkill))
	it("should be able to find the default dummy skill by name", skillFindByNameTest(SkillSystem, DummySkill))
	return true
EndFunction


; Tests
;---------------------------------------------

Function beforeEach()
	If (DummySkill.IsRegistered)
		SkillSystem.Unregister(DummySkill)
	EndIf
EndFunction


bool Function skillRegisterTest(System aSystem, Client aClient)
	; expectations
	expect(aSystem != none, to, beTruthy)
	expect(aClient != none, to, beTruthy)


	expect(aSystem.Register(aClient), to, beTruthy)
	expect(aClient.IsRegistered, to, beTruthy)
	return true
EndFunction


bool Function skillUnregisterTest(System aSystem, Client aClient)
	aSystem.Register(aClient)

	; expectations
	expect(aSystem.Unregister(aClient), to, beTruthy)
	expect(aClient.IsRegistered, to, beFalsy)
	return true
EndFunction


bool Function skillFindByScriptTest(System aSystem, Client aClient)
	aSystem.Register(aClient)

	; expectations
	expect(aSystem.FindByScript(aClient), beGreaterThan, -1)
	return true
EndFunction


bool Function skillFindByNameTest(System aSystem, Client aClient)
	aSystem.Register(aClient)

	; expectations
	expect(aSystem.FindByName(aClient.Name), beGreaterThan, -1)
	return true
EndFunction
