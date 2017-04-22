Scriptname Fallout:Saving:Startup extends Papyrus:Project:Modules:Required
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInitialize()
	Log = LogNew(Context.Title, self)
EndEvent


Event OnEnable()
	Player.AddPerk(Fallout_SavingBedPerk, false)
	WriteLine(Log, "Added the save with beds perk." + Fallout_SavingBedPerk)

	If (HasHolotape)
		WriteLine(Log, "Player already has a holotape." + Fallout_SavingSettings)
	Else
		Player.AddItem(Fallout_SavingSettings, 1, true)
		WriteLine(Log, "Added the holotape." + Fallout_SavingSettings)
	EndIf
EndEvent


Event OnDisable()
	Player.RemovePerk(Fallout_SavingBedPerk)
	WriteLine(Log, "Removed the save with beds perk." + Fallout_SavingBedPerk)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Perk Property Fallout_SavingBedPerk Auto Const Mandatory
	Holotape Property Fallout_SavingSettings Auto Const Mandatory
EndGroup

bool Property HasHolotape Hidden
	bool Function Get()
		return Player.GetItemCount(Fallout_SavingSettings) > 0
	EndFunction
EndProperty
