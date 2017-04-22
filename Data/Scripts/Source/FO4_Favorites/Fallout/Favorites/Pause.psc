Scriptname Fallout:Favorites:Pause extends Papyrus:Project:Modules:Required
import Papyrus:Diagnostics:Log

UserLog Log

string FavoritesMenu = "FavoritesMenu" Const
InputEnableLayer InputLayer


; Events
;---------------------------------------------

Event OnInitialize()
	Log = LogNew(Context.Title, self)
	InputLayer = InputEnableLayer.Create()
EndEvent


Event OnEnable()
	WriteLine(Log, "OnEnable")
	RegisterForMenuOpenCloseEvent(FavoritesMenu)
EndEvent


Event OnDisable()
	WriteLine(Log, "OnDisable")
	UnregisterForMenuOpenCloseEvent(FavoritesMenu)
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	WriteLine(Log, "The menu '"+asMenuName+"' is opening equals '"+abOpening+"'.")
	Pause(abOpening)
EndEvent



; Functions
;---------------------------------------------

bool Function Pause(bool abApply = true)
	If (abApply)
		If (InCombat)
			Player.AddSpell(Fallout_Favorites_Pause, false)

			bool bSneaking = Player.IsSneaking()
			InputLayer.EnableLooking(false)

			If (bSneaking)
				Player.StartSneaking()
				WriteLine(Log, "Reappling the players sneak state.")
			Else
				WriteLine(Log, "No need to reapply the players sneak state.")
			EndIf


			WriteLine(Log, "The favorites pause spell has been cast on the player.")
			return true
		Else
			WriteLine(Log, "The player must be in combat to pause the favorites menu.")
			return false
		EndIf
	Else
		Player.RemoveSpell(Fallout_Favorites_Pause)
		InputLayer.Reset()
		WriteLine(Log, "The favorites pause spell has been dispeled from the player.")
		return true
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Spell Property Fallout_Favorites_Pause Auto Const Mandatory

	bool Property InCombat Hidden
		bool Function Get()
			return Player.IsInCombat()
		EndFunction
	EndProperty
EndGroup
