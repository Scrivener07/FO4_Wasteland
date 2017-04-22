Scriptname Fallout:Favorites:Setup extends Papyrus:Project:Modules:Required
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInitialize()
	Log = LogNew(Context.Title, self)
EndEvent


Event OnEnable()
	If (HasHolotape)
		WriteLine(Log, "Player already has a holotape." + Fallout_FavoritesSettings)
	Else
		Player.AddItem(Fallout_FavoritesSettings, 1, true)
		WriteLine(Log, "Added the holotape." + Fallout_FavoritesSettings)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Holotape Property Fallout_FavoritesSettings Auto Const Mandatory
EndGroup

bool Property HasHolotape Hidden
	bool Function Get()
		return Player.GetItemCount(Fallout_FavoritesSettings) > 0
	EndFunction
EndProperty
