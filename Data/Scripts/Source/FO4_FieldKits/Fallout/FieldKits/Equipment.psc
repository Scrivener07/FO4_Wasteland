ScriptName Fallout:FieldKits:Equipment extends Papyrus:Project:Modules:Required
import Papyrus:Diagnostics:Log

; http://www.creationkit.com/fallout4/index.php?title=PlaceAtMe_-_ObjectReference
; http://www.creationkit.com/fallout4/index.php?title=Activate_-_ObjectReference


UserLog Log

ObjectReference Reference

; Message Options
int NoneOption = -1 const
int ExitOption = 0 const
int WeaponOption = 1 const
int ArmorOption = 2 const
int PAOption = 3 const
int CookOption = 4 const
int ChemistryOption = 5 const

bool Silent = true const
bool DefaultProcessingOnly = true const


; Events
;---------------------------------------------

Event OnInitialize()
	Log = LogNew(Context.Title, self)
EndEvent


Event OnEnable()
	GiveKit()
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	WriteLine(Log, "Equipment Module has been enabled.")
EndEvent


Event OnDisable()
	RemoveKits()
	DestroyBench()
	UnregisterForRemoteEvent(Player, "OnItemEquipped")
	WriteLine(Log, "Equipment Module has been disabled.")
EndEvent


Event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
	If (akBaseObject == Fallout_FieldKits_Kit)
		WriteLine(Log, "The player has consumed a kit. Count:"+Count)
		If (Utility.IsInMenuMode())
			Fallout_FieldKits_KitExitMenuMessage.Show()
			Utility.Wait(0.1)
		EndIf

		GiveKit()
		PromptOptions()
	EndIf
EndEvent


Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	WriteLine(Log, "The player has activated the '"+akSender+"' furniture.")
EndEvent


Event ObjectReference.OnExitFurniture(ObjectReference akSender, ObjectReference akActionRef)
	WriteLine(Log, "The player is exiting the '"+akSender+"' furniture.")
	DestroyBench()
EndEvent


Event Actor.OnGetUp(Actor akSender, ObjectReference akFurniture)
	WriteLine(Log, "The player is getting up from the '"+akFurniture+"' furniture.")
    DestroyBench()
EndEvent


; Functions
;---------------------------------------------

Function PromptOptions()
	int selected = Fallout_FieldKits_BenchOptionsMessage.Show()
	If (selected == NoneOption || selected == ExitOption)
		WriteLine(Log, "Selected NoneOption or ExitOption.")
		return
	ElseIf (selected == WeaponOption)
		WriteLine(Log, "Selected the Weapon Kit.")
		CreateBench(Fallout_FieldKits_BenchWeapon)
	ElseIf (selected == ArmorOption)
		WriteLine(Log, "Selected the Armor Kit.")
		CreateBench(Fallout_FieldKits_BenchArmor)
	ElseIf (selected == PAOption)
		WriteLine(Log, "Selected the PA Kit.")
		CreateBench(Fallout_FieldKits_BenchPA)
	ElseIf (selected == CookOption)
		WriteLine(Log, "Selected the Cooking Kit.")
		CreateBench(Fallout_FieldKits_BenchCook)
	ElseIf (selected == ChemistryOption)
		WriteLine(Log, "Selected the Chemistry Kit.")
		CreateBench(Fallout_FieldKits_BenchChemistry)
	Else
		WriteLine(Log, "Unhandled option selected: " + selected)
	EndIf
EndFunction


Function CreateBench(Furniture aFurniture)
	DestroyBench()
	Reference = Player.PlaceAtMe(aFurniture)

	If (Reference)
		Reference.SetAngle(0.0, 0.0, Reference.GetAngleZ())
		RegisterForRemoteEvent(Reference, "OnActivate")
		RegisterForRemoteEvent(Reference, "OnExitFurniture")
		RegisterForRemoteEvent(Player, "OnGetUp")


		InputEnableLayer input = InputEnableLayer.Create()
		input.DisablePlayerControls()
		Game.ForceThirdPerson()
		;Utility.Wait(0.5)

		If (Reference.Activate(Player, DefaultProcessingOnly))
			WriteLine(Log, "Activated bench. " + Reference)

		Else
			WriteLine(Log, "Could not activate the bench. " + Reference)
			DestroyBench()
		EndIf

		input.EnablePlayerControls()
	Else
		DestroyBench()
		WriteLine(Log, "Could not create a new bench.")
	EndIf
EndFunction


Function DestroyBench()
	If (Reference)
		UnregisterForRemoteEvent(Reference, "OnActivate")
		UnregisterForRemoteEvent(Reference, "OnExitFurniture")
		UnregisterForRemoteEvent(Player, "OnGetUp")
		Reference.Disable()
		Reference.Delete()
		WriteLine(Log, "Destroyed a bench. " + Reference)
	Else
		WriteLine(Log, "There is no bench to destroy.")
	EndIf
EndFunction


Function GiveKit()
	If (Count == 0)
		Player.AddItem(Fallout_FieldKits_Kit, 1, Silent)
		WriteLine(Log, "Gave the player one kit.")
	Else
		WriteLine(Log, "The player already has a kit.")
	EndIf
EndFunction


Function RemoveKits()
	If (Count > 0)
		Player.RemoveItem(Fallout_FieldKits_Kit, Count, Silent)
		WriteLine(Log, "Removed all kits from the player.")
	Else
		WriteLine(Log, "There are no kits to remove from the player.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Kit
	Potion Property Fallout_FieldKits_Kit Auto Const Mandatory
	Message Property Fallout_FieldKits_KitExitMenuMessage Auto Const Mandatory

	int Property Count Hidden
		int Function Get()
			return Player.GetItemCount(Fallout_FieldKits_Kit)
		EndFunction
	EndProperty
EndGroup

Group Reference
	Message Property Fallout_FieldKits_BenchOptionsMessage Auto Const Mandatory
	Furniture Property Fallout_FieldKits_BenchWeapon Auto Const Mandatory
	Furniture Property Fallout_FieldKits_BenchArmor Auto Const Mandatory
	Furniture Property Fallout_FieldKits_BenchPA Auto Const Mandatory
	Furniture Property Fallout_FieldKits_BenchCook Auto Const Mandatory
	Furniture Property Fallout_FieldKits_BenchChemistry Auto Const Mandatory
EndGroup
