Scriptname jbMOMCM_ConfigScript  extends SKI_ConfigBase

jbMOOptions Property Options auto
String[] PresetList

event OnConfigInit()

	PresetList = new String[5]
	PresetList[0] = "Milk Drinker"
	PresetList[1] = "Lore Drinker"
	PresetList[2] = "Realistic Dark"
	PresetList[3] = "Hardcore Dark"
	PresetList[4] = "Custom"
	
endEvent

event OnPageReset(string page)

if page == "Basic Config"

	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("General Configuration")
	AddToggleOptionST("OPTION_isModEnabled", "Mod is Enabled", Options.isModEnabled)
	AddToggleOptionST("OPTION_Fadeout", "Do fadeout on dungeon entry?", Options.doFadeout)
	AddToggleOptionST("OPTION_doDwemer", "Disable lights in Dwarven ruins?", Options.doDwemer)
	AddToggleOptionST("OPTION_noLocPrompt", "Prompt when keywords not found?",Options.noLocPrompt)
	AddMenuOptionST("OPTION_Preset", "Mod Presets:", PresetList[Options.PresetIndex])
	AddHeaderOption("NPC Scan Settings")
	AddSliderOptionST("OPTION_NPCScanDist", "NPC Scan Distance",Options.NPCScanDist)
	AddSliderOptionST("OPTION_OccupiedProb", "Occupied Area Lighting Probability",100*Options.OccupiedProb)
	AddSliderOptionST("OPTION_UnoccupiedProb", "Unoccupied Area Lighting Probability",100*Options.UnoccupiedProb)
	SetCursorPosition(1)
	AddHeaderOption("Re-lighting Options")
	AddToggleOptionST("OPTION_enableFireLighter", "Enable lighting fires",Options.enableFireLighter)
	if Options.STInstalled || Options.ELFXInstalled
			AddHeaderOption("Mod Compatibility")
	endIf
	if Options.STInstalled
		AddToggleOptionST("OPTION_STDisable", "Pause sneaktools fire lighting in dungeons?",Options.STDisable)
	endIf
	if Options.ELFXInstalled
		AddToggleOptionST("OPTION_ELFXDisableCandleSmoke", "Include ELFX candle smoke in scans?",Options.ELFXDisableCandleSmoke)
	endIf
;	AddToggleOptionST("OPTION_giveSpell", "Give player Merida's Flame?",Options.giveSpell)
	AddHeaderOption("Debug / Utility")
	AddToggleOptionST("OPTION_DebugMode", "Papyrus Debug Mode", Options.DebugMode)
	AddTextOptionST("OPTION_NotificationLevel", "Notification Level",Options.NotificationLevelText)
	AddToggleOptionST("OPTION_ScanCurrentDungeon", "Manually Scan Current Dungeon",Options.ScanCurrentDungeon)
	AddToggleOptionST("OPTION_ResetCurrentDungeon", "Reset Current Dungeon",Options.ResetCurrentDungeon)
;	AddToggleOptionST("OPTION_ResetAllDungeons", "Reset All Dungeons",Options.ResetAllDungeons)

elseif page == "Location Type Overrides"

	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("Default Location Types")
	AddSliderOptionST("OPTION_DefaultUnocProbFire", "Fire light type probability",100*Options.GetUnocProb(0,0))
	AddSliderOptionST("OPTION_DefaultUnocProbCandle", "Candle light type probability",100*Options.GetUnocProb(0,1))
	AddSliderOptionST("OPTION_DefaultUnocProbDwemer", "Dwemer type probability",100*Options.GetUnocProb(0,2))
	
	AddHeaderOption("Cave Location Types")
	AddSliderOptionST("OPTION_CaveUnocProbFire", "Fire light type probability",100*Options.GetUnocProb(1,0))
	AddSliderOptionST("OPTION_CaveUnocProbCandle", "Candle light type probability",100*Options.GetUnocProb(1,1))
	AddSliderOptionST("OPTION_CaveUnocProbDwemer", "Dwemer type probability",100*Options.GetUnocProb(1,2))

	SetCursorPosition(1)
	
	AddHeaderOption("Dwarven Ruin Location Types")
	AddSliderOptionST("OPTION_DwarvenUnocProbFire", "Fire light type probability",100*Options.GetUnocProb(2,0))
	AddSliderOptionST("OPTION_DwarvenUnocProbCandle", "Candle light type probability",100*Options.GetUnocProb(2,1))
	AddSliderOptionST("OPTION_DwarvenUnocProbDwemer", "Dwemer type probability",100*Options.GetUnocProb(2,2))
	
	AddHeaderOption("Nordic Ruin Location Types")
	AddSliderOptionST("OPTION_NordicUnocProbFire", "Fire light type probability",100*Options.GetUnocProb(3,0))
	AddSliderOptionST("OPTION_NordicUnocProbCandle", "Candle light type probability",100*Options.GetUnocProb(3,1))
	AddSliderOptionST("OPTION_NordicUnocProbDwemer", "Dwemer type probability",100*Options.GetUnocProb(3,2))

elseif page == "Actor Type Overrides"

	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("Default NPC Types")
	AddSliderOptionST("OPTION_DefaultActorProbFire", "Fire light type probability",100*Options.GetActorProb(0,0))
	AddSliderOptionST("OPTION_DefaultActorProbCandle", "Candle light type probability",100*Options.GetActorProb(0,1))
	AddSliderOptionST("OPTION_DefaultActorProbDwemer", "Dwemer type probability",100*Options.GetActorProb(0,2))
	
	AddHeaderOption("Draugr")
	AddSliderOptionST("OPTION_DraugrActorProbFire", "Fire light type probability",100*Options.GetActorProb(1,0))
	AddSliderOptionST("OPTION_DraugrActorProbCandle", "Candle light type probability",100*Options.GetActorProb(1,1))
	AddSliderOptionST("OPTION_DraugrActorProbDwemer", "Dwemer type probability",100*Options.GetActorProb(1,2))
	
	AddHeaderOption("Dwarven Automatons")
	AddSliderOptionST("OPTION_DwarvenActorProbFire", "Fire light type probability",100*Options.GetActorProb(2,0))
	AddSliderOptionST("OPTION_DwarvenActorProbCandle", "Candle light type probability",100*Options.GetActorProb(2,1))
	AddSliderOptionST("OPTION_DwarvenActorProbDwemer", "Dwemer type probability",100*Options.GetActorProb(2,2))
	
	AddHeaderOption("Falmer")
	AddSliderOptionST("OPTION_FalmerActorProbFire", "Fire light type probability",100*Options.GetActorProb(3,0))
	AddSliderOptionST("OPTION_FalmerActorProbCandle", "Candle light type probability",100*Options.GetActorProb(3,1))
	AddSliderOptionST("OPTION_FalmerActorProbDwemer", "Dwemer type probability",100*Options.GetActorProb(3,2))
	

	SetCursorPosition(1)
	
	AddHeaderOption("Hargraven")
	AddSliderOptionST("OPTION_HargravenActorProbFire", "Fire light type probability",100*Options.GetActorProb(4,0))
	AddSliderOptionST("OPTION_HargravenActorProbCandle", "Candle light type probability",100*Options.GetActorProb(4,1))
	AddSliderOptionST("OPTION_HargravenActorProbDwemer", "Dwemer type probability",100*Options.GetActorProb(4,2))
	
	AddHeaderOption("Riekling")
	AddSliderOptionST("OPTION_RieklingActorProbFire", "Fire light type probability",100*Options.GetActorProb(5,0))
	AddSliderOptionST("OPTION_RieklingActorProbCandle", "Candle light type probability",100*Options.GetActorProb(5,1))
	AddSliderOptionST("OPTION_RieklingActorProbDwemer", "Dwemer type probability",100*Options.GetActorProb(5,2))
	
	AddHeaderOption("Vampires")
	AddSliderOptionST("OPTION_VampireActorProbFire", "Fire light type probability",100*Options.GetActorProb(6,0))
	AddSliderOptionST("OPTION_VampireActorProbCandle", "Candle light type probability",100*Options.GetActorProb(6,1))
	AddSliderOptionST("OPTION_VampireActorProbDwemer", "Dwemer type probability",100*Options.GetActorProb(6,2))
	

	
else
	;do nothing
	
endIf	

	
endEvent

event OnConfigClose()
	if Options.ResetCurrentDungeon
		int handle = ModEvent.Create("JBMod_ResetCurrentDungeon")
		if handle
			ModEvent.Send(handle)
		else
			;pass
		endif
	Options.ResetCurrentDungeon = false
	elseif Options.ScanCurrentDungeon
		int handle = ModEvent.Create("JBMod_ScanCurrentDungeon")
		if handle
			ModEvent.Send(handle)
		else
			;pass
		endif
	Options.ScanCurrentDungeon = false
	endif 
endEvent

state OPTION_Fadeout
    event OnSelectST()
		Options.Toggle_doFadeout()
		SetToggleOptionValueST(Options.doFadeout)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(true)
		Options.doFadeout = true
    endEvent

    event OnHighlightST()
        SetInfoText("Implements brief fade-out while nearby lights are being turned off.  Minimizes chance you will see lights blink off")
    endEvent
endState

state OPTION_doDwemer
    event OnSelectST()
		Options.Toggle_doDwemer()
		SetToggleOptionValueST(Options.doDwemer)
		Options.PresetIndex = 4
		ForcePageReset()
		endEvent

    event OnDefaultST()
		Options.doDwemer = true
		SetToggleOptionValueST(Options.doDwemer)
    endEvent

    event OnHighlightST()
        SetInfoText("Disable lights in Dwemer ruins.")
    endEvent
endState

state OPTION_giveSpell
    event OnSelectST()
		Options.Toggle_giveSpell()
		SetToggleOptionValueST(Options.giveSpell)
	endEvent

    event OnDefaultST()
		Options.giveSpell = false
		SetToggleOptionValueST(Options.giveSpell)
    endEvent

    event OnHighlightST()
        SetInfoText("Adds spell that allows player to light fires and sconces in dungeons")
    endEvent
endState

state OPTION_noLocPrompt
    event OnSelectST()
		Options.Toggle_noLocPrompt()
		SetToggleOptionValueST(Options.noLocPrompt)
	endEvent

    event OnDefaultST()
		Options.noLocPrompt = false
		SetToggleOptionValueST(Options.noLocPrompt)
    endEvent

    event OnHighlightST()
        SetInfoText("When a location keyword is not found, a menu will prompt whether or not to run the scan.  This is useful if you run a number of dungeon mods that may not have locations and keywords properly set.")
    endEvent
endState

state OPTION_STDisable
    event OnSelectST()
		Options.Toggle_STDisable()
		SetToggleOptionValueST(Options.STDisable)
	endEvent

    event OnDefaultST()
		Options.STDisable = true
		SetToggleOptionValueST(Options.STDisable)
    endEvent

    event OnHighlightST()
        SetInfoText("Will pause sneak tools fire lighting when in dungeons, eliminating conflict with DISDD (recommend if Fire Lighting is enabled).")
    endEvent
endState

state OPTION_ELFXDisableCandleSmoke
    event OnSelectST()
		Options.Toggle_ELFXDisableCandleSmoke()
		SetToggleOptionValueST(Options.ELFXDisableCandleSmoke)
	endEvent

    event OnDefaultST()
		Options.ELFXDisableCandleSmoke = false
		SetToggleOptionValueST(Options.ELFXDisableCandleSmoke)
    endEvent

    event OnHighlightST()
        SetInfoText("Check if you have ELFX installed with Candle Smoke.  This will remove ELFX candle smoke for candles that are disabled in the scan.")
    endEvent
endState

state OPTION_enableFireLighter
    event OnSelectST()
		Options.Toggle_enableFireLighter()
		SetToggleOptionValueST(Options.enableFireLighter)
	endEvent

    event OnDefaultST()
		Options.enableFireLighter = false
		SetToggleOptionValueST(Options.enableFireLighter)
    endEvent

    event OnHighlightST()
        SetInfoText("Enable activators for fires - light and extinguish dungeon fires in sconces, torches, cooking fires, etc.")
    endEvent
endState

state OPTION_NPCScanDist
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.NPCScanDist)
		SetSliderDialogDefaultValue(2000)
		SetSliderDialogRange(100,6000)
		SetSliderDialogInterval(50)
	endEvent

	event OnSliderAcceptST(float value)
		Options.NPCScanDist = value
		SetSliderOptionValueST(Options.NPCScanDist)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
        Options.NPCScanDist = 2000
		SetSliderOptionValueST(Options.NPCScanDist)
    endEvent

    event OnHighlightST()
        SetInfoText("Lights within this distance from any detected NPC will not be disabled.  Establishes lit areas around NPCs.  The larger the number the slower the scan will run.")
    endEvent
endState

state OPTION_OccupiedProb
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.OccupiedProb * 100)
		SetSliderDialogDefaultValue(80)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.OccupiedProb = value/100
		SetSliderOptionValueST(Options.OccupiedProb * 100)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
        Options.OccupiedProb = 0.8
		SetSliderOptionValueST(Options.NPCScanDist * 100)
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that lights in NPC occupied zones will be left on.  Set lower for fewer lights lit in NPC occupied areas.")
    endEvent
endState

state OPTION_UnoccupiedProb
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.UnoccupiedProb * 100)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.UnoccupiedProb = value/100
		SetSliderOptionValueST(Options.UnoccupiedProb * 100)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
        Options.UnoccupiedProb = 0.8
		SetSliderOptionValueST(Options.NPCScanDist * 100)
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that lights in unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_isModEnabled
    event OnSelectST()
		Options.Toggle_isModEnabled()
		SetToggleOptionValueST(Options.isModEnabled)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(true)
		Options.isModEnabled = true
    endEvent

    event OnHighlightST()
        SetInfoText("Enables or disables mod.  Disabling will retain all set values.  Affects future loaded dungeons only.  Lights already disabled will remain disabled.")
    endEvent
endState

state OPTION_DebugMode
    event OnSelectST()
		Options.Toggle_DebugMode()
		SetToggleOptionValueST(Options.DebugMode)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
		Options.DebugMode = false
    endEvent

    event OnHighlightST()
        SetInfoText("Enables debug mode.  Must also enable Papyrus debugging in Skyrim INI.  ")
    endEvent
endState

state OPTION_NotificationLevel
    event OnSelectST()
		Options.Increment_NotificationLevel()
		SetTextOptionValueST(Options.NotificationLevelText)
    endEvent

    event OnDefaultST()
        Options.NotificationLevel = 1
		SetTextOptionValueST(Options.NotificationLevelText)
    endEvent

    event OnHighlightST()
        SetInfoText("Screen Notifications:  None, Minimal, Detailed")
    endEvent
endState

state OPTION_ScanCurrentDungeon
    event OnSelectST()
		Options.Toggle_ScanCurrentDungeon()
		SetToggleOptionValueST(Options.ScanCurrentDungeon)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
		Options.ScanCurrentDungeon = false
    endEvent

    event OnHighlightST()
        SetInfoText("Forces manual scan of lights in current dungeon on menu close.  Use this if you are running a dungeon mod that is not automatically detected.")
    endEvent
endState

state OPTION_ResetCurrentDungeon
    event OnSelectST()
		Options.Toggle_ResetCurrentDungeon()
		SetToggleOptionValueST(Options.ResetCurrentDungeon)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
		Options.ResetCurrentDungeon = false
    endEvent

    event OnHighlightST()
        SetInfoText("Resets lights in current dungeon on menu close.")
    endEvent
endState

state OPTION_ResetAllDungeons
    event OnSelectST()
		Options.Toggle_ResetAllDungeons()
		SetToggleOptionValueST(Options.ResetAllDungeons)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
		Options.ResetAllDungeons = false
    endEvent

    event OnHighlightST()
        SetInfoText("Resets lights for all Dungeons on menu close.  Expect this to take between 30 and 60 seconds per dungeon.")
    endEvent
endState

state OPTION_Preset
	event OnMenuOpenST()
		SetMenuDialogStartIndex(Options.PresetIndex)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(PresetList)
	endEvent

	event OnMenuAcceptST(int index)
		Options.PresetIndex = index
		SetMenuOptionValueST(PresetList[Options.PresetIndex])
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
        Options.PresetIndex = 2
		SetSliderOptionValueST(Options.PresetIndex)
    endEvent

    event OnHighlightST()
        SetInfoText("Presets.  Milk Drinker - Generous lighting; Lore Drinker - you believe Drauger maintain lights and dwemer ruins are lit; Realistic Dark - Recommended for the realistic lighting experience; Hardcore Dark - NPCs huddle in the vast dark dungeons - don't expect much light; Custom - Set your own settings.")
    endEvent
endState
;                     ************************
;********************* LOCATION TYPE SETTINGS *******************************
;                     ************************

; DEFAULT Location Types

state OPTION_DefaultUnocProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(0,0) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(0,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(0,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(0,0)
        Options.SetUnocProb(0,0,value)
		SetSliderOptionValueST(Options.GetUnocProb(0,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights in DEFAULT unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_DefaultUnocProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(0,1) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(0,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(0,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(0,1)
        Options.SetUnocProb(0,1,value)
		SetSliderOptionValueST(Options.GetUnocProb(0,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights in DEFAULT unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_DefaultUnocProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(0,2) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(0,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(0,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(0,2)
        Options.SetUnocProb(0,2,value)
		SetSliderOptionValueST(Options.GetUnocProb(0,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights in DEFAULT unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

; CAVE Location Types

state OPTION_CaveUnocProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(1,0) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(1,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(1,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(1,0)
        Options.SetUnocProb(1,0,value)
		SetSliderOptionValueST(Options.GetUnocProb(1,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights in CAVE unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_CaveUnocProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(1,1) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(1,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(1,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(1,1)
        Options.SetUnocProb(1,1,value)
		SetSliderOptionValueST(Options.GetUnocProb(1,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights in CAVE unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_CaveUnocProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(1,2) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(1,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(1,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(1,2)
        Options.SetUnocProb(1,2,value)
		SetSliderOptionValueST(Options.GetUnocProb(1,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights in CAVE unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

; DWARVEN Location Types

state OPTION_DwarvenUnocProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(2,0) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(2,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(2,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(2,0)
        Options.SetUnocProb(2,0,value)
		SetSliderOptionValueST(Options.GetUnocProb(2,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights in DWARVEN unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_DwarvenUnocProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(2,1) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(2,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(2,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(2,1)
        Options.SetUnocProb(2,1,value)
		SetSliderOptionValueST(Options.GetUnocProb(2,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights in DWARVEN unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_DwarvenUnocProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(2,2) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(2,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(2,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(2,2)
        Options.SetUnocProb(2,2,value)
		SetSliderOptionValueST(Options.GetUnocProb(2,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights in DEFAULT unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

; NORDIC Location Types

state OPTION_NordicUnocProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(3,0) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(3,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(3,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(3,0)
        Options.SetUnocProb(3,0,value)
		SetSliderOptionValueST(Options.GetUnocProb(3,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights in NORDIC unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_NordicUnocProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(3,1) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(3,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(3,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(3,1)
        Options.SetUnocProb(3,1,value)
		SetSliderOptionValueST(Options.GetUnocProb(3,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights in NORDIC unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

state OPTION_NordicUnocProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetUnocProb(3,2) * 100)
		SetSliderDialogDefaultValue(Options.GetUnocProbDefault(3,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetUnocProb(3,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetUnocProbDefault(3,2)
        Options.SetUnocProb(3,2,value)
		SetSliderOptionValueST(Options.GetUnocProb(3,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights in NORDIC unoccupied zones will be left on.  Set higher if unoccupied zones are too dark.")
    endEvent
endState

;                     ************************
;********************* ACTOR TYPE SETTINGS *******************************
;                     ************************

; DEFAULT Actor Types

state OPTION_DefaultActorProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(0,0) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(0,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(0,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(0,0)
        Options.SetActorProb(0,0,value)
		SetSliderOptionValueST(Options.GetActorProb(0,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights for DEFAULT actor types will be lit.  Set higher if this Actor type uses this light type.")
    endEvent
endState

state OPTION_DefaultActorProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(0,1) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(0,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(0,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(0,1)
        Options.SetActorProb(0,1,value)
		SetSliderOptionValueST(Options.GetActorProb(0,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights for DEFAULT actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_DefaultActorProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(0,2) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(0,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(0,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(0,2)
        Options.SetActorProb(0,2,value)
		SetSliderOptionValueST(Options.GetActorProb(0,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights for DEFAULT actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

; DRAUGR Actor Types

state OPTION_DraugrActorProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(1,0) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(1,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(1,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(1,0)
        Options.SetActorProb(1,0,value)
		SetSliderOptionValueST(Options.GetActorProb(1,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights for DRAUGR actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_DraugrActorProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(1,1) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(1,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(1,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(1,1)
        Options.SetActorProb(1,1,value)
		SetSliderOptionValueST(Options.GetActorProb(1,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights for DRAUGR actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_DraugrActorProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(1,2) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(1,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(1,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(1,2)
        Options.SetActorProb(1,2,value)
		SetSliderOptionValueST(Options.GetActorProb(1,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights for DRAUGR actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

; DWARVEN Actor Types

state OPTION_DwarvenActorProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(2,0) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(2,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(2,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(2,0)
        Options.SetActorProb(2,0,value)
		SetSliderOptionValueST(Options.GetActorProb(2,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights for DWARVEN actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_DwarvenActorProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(2,1) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(2,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(2,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(2,1)
        Options.SetActorProb(2,1,value)
		SetSliderOptionValueST(Options.GetActorProb(2,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights for DWARVEN actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_DwarvenActorProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(2,2) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(2,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(2,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(2,2)
        Options.SetActorProb(2,2,value)
		SetSliderOptionValueST(Options.GetActorProb(2,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights for DWARVEN actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

; FALMER Actor Types

state OPTION_FalmerActorProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(3,0) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(3,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(3,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(3,0)
        Options.SetActorProb(3,0,value)
		SetSliderOptionValueST(Options.GetActorProb(3,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights for FALMER actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_FalmerActorProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(3,1) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(3,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(3,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(3,1)
        Options.SetActorProb(3,1,value)
		SetSliderOptionValueST(Options.GetActorProb(3,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights for FALMER actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_FalmerActorProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(3,2) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(3,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(3,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(3,2)
        Options.SetActorProb(3,2,value)
		SetSliderOptionValueST(Options.GetActorProb(3,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights for FALMER actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

; HARGRAVEN Actor Types

state OPTION_HargravenActorProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(4,0) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(4,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(4,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(4,0)
        Options.SetActorProb(4,0,value)
		SetSliderOptionValueST(Options.GetActorProb(4,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights for HARGRAVEN actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_HargravenActorProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(4,1) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(4,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(4,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(4,1)
        Options.SetActorProb(4,1,value)
		SetSliderOptionValueST(Options.GetActorProb(4,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights for HARGRAVEN actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_HargravenActorProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(4,2) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(4,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(4,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(4,2)
        Options.SetActorProb(4,2,value)
		SetSliderOptionValueST(Options.GetActorProb(4,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights for HARGRAVEN actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

; RIEKLING Actor Types

state OPTION_RieklingActorProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(5,0) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(5,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(5,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(5,0)
        Options.SetActorProb(5,0,value)
		SetSliderOptionValueST(Options.GetActorProb(5,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights for RIEKLING actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_RieklingActorProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(5,1) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(5,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(5,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(5,1)
        Options.SetActorProb(5,1,value)
		SetSliderOptionValueST(Options.GetActorProb(5,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights for RIEKLING actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_RieklingActorProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(5,2) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(5,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(5,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(5,2)
        Options.SetActorProb(5,2,value)
		SetSliderOptionValueST(Options.GetActorProb(5,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights for RIEKLING actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

; VAMPIRE Actor Types

state OPTION_VampireActorProbFire
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(6,0) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(6,0))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(6,0,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(6,0)
        Options.SetActorProb(6,0,value)
		SetSliderOptionValueST(Options.GetActorProb(6,0))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that FIRE lights for VAMPIRE actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_VampireActorProbCandle
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(6,1) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(6,1))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(6,1,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(6,1)
        Options.SetActorProb(6,1,value)
		SetSliderOptionValueST(Options.GetActorProb(6,1))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that CANDLE lights for VAMPIRE actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState

state OPTION_VampireActorProbDwemer
	event OnSliderOpenST()
		SetSliderDialogStartValue(Options.GetActorProb(6,2) * 100)
		SetSliderDialogDefaultValue(Options.GetActorProbDefault(6,2))
		SetSliderDialogRange(0,100)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Options.SetActorProb(6,2,value/100)
		SetSliderOptionValueST(value)
		Options.PresetIndex = 4
		ForcePageReset()
	endEvent
	
    event OnDefaultST()
		float value = Options.GetActorProbDefault(6,2)
        Options.SetActorProb(6,2,value)
		SetSliderOptionValueST(Options.GetActorProb(6,2))
    endEvent

    event OnHighlightST()
        SetInfoText("Sets the probability that DWEMER lights for VAMPIRE actor types will be left on.  Set higher if this Actor uses this light type.")
    endEvent
endState
