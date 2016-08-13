Scriptname jbMOOptions extends Quest  

jbMOUtils Property jbUtils Auto

Spell Property fireSpell Auto

GlobalVariable Property gvOpt_doFadeout  Auto
GlobalVariable Property gvOpt_NPCScanDist Auto
GlobalVariable Property gvOpt_doDwemer Auto
GlobalVariable Property gvOpt_OccupiedProb Auto
GlobalVariable Property gvOpt_UnoccupiedProb Auto
GlobalVariable Property gvOpt_PresetIndex Auto

bool Opt_doFadeout
bool Opt_doDwemer
bool Opt_giveSpell
bool Opt_noLocPrompt
bool Opt_enableFireLighter
bool Opt_STInstalled
bool Opt_STDisable
bool Opt_ELFXInstalled
bool Opt_ELFXDisableCandleSmoke
float Opt_NPCScanDist
float Opt_OccupiedProb
float Opt_UnoccupiedProb
bool Opt_isModEnabled
int Opt_PresetIndex
bool Opt_DebugMode
int Opt_NotificationLevel
string[] Opt_NotificationLevelText
bool Opt_ScanCurrentDungeon
bool Opt_ResetCurrentDungeon
bool Opt_ResetAllDungeons
float[] Opt_UnocProbFire
float[] Opt_UnocProbCandle
float[] Opt_UnocProbDwe

float[] Opt_UnocProbFireDefault
float[] Opt_UnocProbCandleDefault
float[] Opt_UnocProbDweDefault

float[] Opt_ActorProbFire
float[] Opt_ActorProbCandle
float[] Opt_ActorProbDwe

float[] Opt_ActorProbFireDefault
float[] Opt_ActorProbCandleDefault
float[] Opt_ActorProbDweDefault

float version = 2.0

Function doUpdate()

	jbUtils.DebugTrace("jBMO Current Version is: "+version)

	if version < 1.7
		jbUtils.DebugTrace("Updating to version 1.7")
		Opt_STInstalled = false
		Opt_STDisable = true
		version = 1.7
	endIf
	
	version = 2.0
	
endFunction

bool Property doFadeout

	Function Set(bool value)
		Opt_doFadeout = value
		gvOpt_doFadeout.setvalue(value as float)
		jbUtils.DebugTrace("Fadeout set to "+value)
		jbUtils.DebugTrace("Fadeout global set to "+gvOpt_doFadeout.getvalue())
	endFunction
	
	bool Function Get()
		jbUtils.DebugTrace("Returning doFadeout: "+Opt_doFadeout)
		return Opt_doFadeout
	EndFunction
	
endProperty

bool Property doDwemer

	Function Set(bool value)
		Opt_doDwemer = value
		gvOpt_doDwemer.setvalue(value as float)
		jbUtils.DebugTrace("Dwemer set to "+Opt_doDwemer)
		jbUtils.DebugTrace("Dwemer global set to "+gvOpt_doDwemer.getvalue())
	endFunction
	
	bool Function Get()
		return Opt_doDwemer
	EndFunction
	
endProperty
		
bool Property giveSpell

	Function Set(bool value)
		if value
			game.getplayer().addspell(fireSpell)
		else
			game.getplayer().removespell(fireSpell)
		endIf
		Opt_giveSpell = value
		jbUtils.DebugTrace("GiveSpell set to "+Opt_giveSpell)
	endFunction
	
	bool Function Get()
		return Opt_giveSpell
	EndFunction
	
endProperty
		
bool Property noLocPrompt

	Function Set(bool value)
		Opt_noLocPrompt = value
		jbUtils.DebugTrace("noLocPrompt set to "+Opt_noLocPrompt)
	endFunction
	
	bool Function Get()
		return Opt_noLocPrompt
	EndFunction
	
endProperty

bool Property STInstalled

	Function Set(bool value)
		Opt_STInstalled = value
		jbUtils.DebugTrace("STInstalled set to "+Opt_STInstalled)
	endFunction
	
	bool Function Get()
		return Opt_STInstalled
	EndFunction
	
endProperty

bool Property STDisable

	Function Set(bool value)
		Opt_STDisable = value
		jbUtils.DebugTrace("STDisable set to "+Opt_STDisable)
	endFunction
	
	bool Function Get()
		jbUtils.DebugTrace("Getting STDisable. Opt_STDisable: "+Opt_STDisable+" Opt_STInstalled: "+Opt_STInstalled+" Returning: "+(Opt_STDisable && Opt_STInstalled))
		return (Opt_STDisable && Opt_STInstalled)
	EndFunction
	
endProperty

bool Property ELFXInstalled

	Function Set(bool value)
		Opt_ELFXInstalled = value
		jbUtils.DebugTrace("ELFXInstalled set to "+Opt_ELFXInstalled)
	endFunction
	
	bool Function Get()
		return (Opt_ELFXInstalled)
	EndFunction
	
endProperty

bool Property ELFXDisableCandleSmoke

	Function Set(bool value)
		Opt_ELFXDisableCandleSmoke = value
		jbUtils.DebugTrace("ELFXDisableCandleSmoke set to "+Opt_ELFXDisableCandleSmoke)
	endFunction
	
	bool Function Get()
		return (Opt_ELFXDisableCandleSmoke)
	EndFunction
	
endProperty

bool Property enableFireLighter

	Function Set(bool value)
		Opt_enableFireLighter = value
		jbUtils.DebugTrace("enableFireLighter set to "+Opt_enableFireLighter)
	endFunction
	
	bool Function Get()
		return Opt_enableFireLighter
	EndFunction
	
endProperty

float Property NPCScanDist

	Function Set(float value)
		Opt_NPCScanDist = value
		gvOpt_NPCScanDist.setvalue(value)
		jbUtils.DebugTrace("NPCScanDist set to "+Opt_NPCScanDist)
		jbUtils.DebugTrace("NPCScanDist global set to "+gvOpt_NPCScanDist.getvalue())
	endFunction
	
	float Function Get()
		return Opt_NPCScanDist
	EndFunction
	
endProperty

float Property OccupiedProb

	Function Set(float value)
		Opt_OccupiedProb = value
		gvOpt_OccupiedProb.setvalue(value)
		jbUtils.DebugTrace("OccupiedProb set to "+Opt_OccupiedProb)
		jbUtils.DebugTrace("OccupiedProb global set to "+gvOpt_OccupiedProb.getvalue())
	endFunction
	
	float Function Get()
		return Opt_OccupiedProb
	EndFunction
	
endProperty

float Property UnoccupiedProb

	Function Set(float value)
		Opt_UnoccupiedProb = value
		gvOpt_UnoccupiedProb.setvalue(value)
		jbUtils.DebugTrace("UnoccupiedProb set to "+Opt_UnoccupiedProb)
		jbUtils.DebugTrace("UnoccupiedProb global set to "+gvOpt_UnoccupiedProb.getvalue())
	endFunction
	
	float Function Get()
		return Opt_UnoccupiedProb
	EndFunction
	
endProperty

bool Property isModEnabled

	Function Set(bool value)
		Opt_isModEnabled = value
		jbUtils.DebugTrace("isModEnabled set to "+Opt_isModEnabled)
	endFunction
	
	bool Function Get()
		return Opt_isModEnabled
	EndFunction
	
endProperty

bool Property DebugMode

	Function Set(bool value)
		Opt_DebugMode = value
		jbUtils.DebugTrace("DebugMode set to "+Opt_DebugMode)
	endFunction
	
	bool Function Get()
		return Opt_DebugMode
	EndFunction
	
endProperty

int Property NotificationLevel

	Function Set(int value)
		Opt_NotificationLevel = value
		jbUtils.DebugTrace("NotificationLevel set to "+Opt_NotificationLevel)
	endFunction
	
	int Function Get()
		return Opt_NotificationLevel
	EndFunction
	
endProperty

string Property NotificationLevelText hidden

	string Function get()
		return Opt_NotificationLevelText[Opt_NotificationLevel]
	endFunction
	
endProperty

bool Property ScanCurrentDungeon

	Function Set(bool value)
		Opt_ScanCurrentDungeon = value
		jbUtils.DebugTrace("ScanCurrentDungeon set to "+Opt_ScanCurrentDungeon)
	endFunction
	
	bool Function Get()
		return Opt_ScanCurrentDungeon
	EndFunction
	
endProperty

bool Property ResetCurrentDungeon

	Function Set(bool value)
		Opt_ResetCurrentDungeon = value
		jbUtils.DebugTrace("ResetCurrentDungeon set to "+Opt_ResetCurrentDungeon)
	endFunction
	
	bool Function Get()
		return Opt_ResetCurrentDungeon
	EndFunction
	
endProperty

bool Property ResetAllDungeons

	Function Set(bool value)
		Opt_ResetAllDungeons = value
		jbUtils.DebugTrace("ResetAllDungeons set to "+Opt_ResetAllDungeons)
	endFunction
	
	bool Function Get()
		return Opt_ResetAllDungeons
	EndFunction
	
endProperty

int Property PresetIndex

	Function Set(int value)
		Opt_PresetIndex = value
		gvOpt_PresetIndex.setvalue(value as float)
		jbUtils.DebugTrace("PresetIndex set to "+Opt_PresetIndex)
		jbUtils.DebugTrace("PresetIndex global set to "+gvOpt_PresetIndex.getvalue())
		if Opt_PresetIndex == 0
			doDwemer = true
			giveSpell = false
			NPCScanDist = 4500
			OccupiedProb = 1.0
			UnoccupiedProb = 0.2

			;Set unoccupied probability by location type: 0-Default, 1-Cave, 2-Dwarven Ruin, 3-Nordic Ruin
			Opt_UnocProbFire[0] = 0.25
			Opt_UnocProbFire[1] = 0.25
			Opt_UnocProbFire[2] = 0.25
			Opt_UnocProbFire[3] = 0.5

			Opt_UnocProbCandle[0] = 0.25
			Opt_UnocProbCandle[1] = 0.25
			Opt_UnocProbCandle[2] = 0.25
			Opt_UnocProbCandle[3] = 0.25

			Opt_UnocProbDwe[0] = 0.25
			Opt_UnocProbDwe[1] = 0.25
			Opt_UnocProbDwe[2] = 0.5
			Opt_UnocProbDwe[3] = 0.25

			;Set Actor probability by location type: 0-Default NPC, 1-Draugr, 2-DwarvenAutomaton, 3-Falmer, 4-Hargraven
			;5-Riekling, 6-Vampire
			Opt_ActorProbFire[0] = 1.0
			Opt_ActorProbFire[1] = 1.0
			Opt_ActorProbFire[2] = 0.25
			Opt_ActorProbFire[3] = 0.5
			Opt_ActorProbFire[4] = 0.5
			Opt_ActorProbFire[5] = 1.0
			Opt_ActorProbFire[6] = 0.5

			Opt_ActorProbCandle[0] = 1.0
			Opt_ActorProbCandle[1] = 0.25
			Opt_ActorProbCandle[2] = 0.25
			Opt_ActorProbCandle[3] = 0.25
			Opt_ActorProbCandle[4] = 1.0
			Opt_ActorProbCandle[5] = 1.0
			Opt_ActorProbCandle[6] = 1.0

			Opt_ActorProbDwe[0] = 0.25
			Opt_ActorProbDwe[1] = 0.25
			Opt_ActorProbDwe[2] = 1.0
			Opt_ActorProbDwe[3] = 0.25
			Opt_ActorProbDwe[4] = 0.25
			Opt_ActorProbDwe[5] = 0.25
			Opt_ActorProbDwe[6] = 0.25

		elseif Opt_PresetIndex == 1
			doDwemer = true
			giveSpell = false
			NPCScanDist = 3500
			OccupiedProb = 1.0
			UnoccupiedProb = 0.25

			;Set unoccupied probability by location type: 0-Default, 1-Cave, 2-Dwarven Ruin, 3-Nordic Ruin
			Opt_UnocProbFire[0] = 0.20
			Opt_UnocProbFire[1] = 0.0
			Opt_UnocProbFire[2] = 0.0
			Opt_UnocProbFire[3] = 0.2

			Opt_UnocProbCandle[0] = 0.2
			Opt_UnocProbCandle[1] = 0.0
			Opt_UnocProbCandle[2] = 0.0
			Opt_UnocProbCandle[3] = 0.2

			Opt_UnocProbDwe[0] = 0.0
			Opt_UnocProbDwe[1] = 0.0
			Opt_UnocProbDwe[2] = 0.2
			Opt_UnocProbDwe[3] = 0.0

			;Set Actor probability by location type: 0-Default NPC, 1-Dragr, 2-DwarvenAutomaton, 3-Falmer, 4-Hargraven
			;5-Riekling, 6-Vampire
			Opt_ActorProbFire[0] = 1.0
			Opt_ActorProbFire[1] = 1.0
			Opt_ActorProbFire[2] = 0.0
			Opt_ActorProbFire[3] = 0.0
			Opt_ActorProbFire[4] = 1.0
			Opt_ActorProbFire[5] = 1.0
			Opt_ActorProbFire[6] = 0.0

			Opt_ActorProbCandle[0] = 1.0
			Opt_ActorProbCandle[1] = 0.5
			Opt_ActorProbCandle[2] = 0.0
			Opt_ActorProbCandle[3] = 0.0
			Opt_ActorProbCandle[4] = 1.0
			Opt_ActorProbCandle[5] = 1.0
			Opt_ActorProbCandle[6] = 1.0

			Opt_ActorProbDwe[0] = 0.2
			Opt_ActorProbDwe[1] = 0.0
			Opt_ActorProbDwe[2] = 1.0
			Opt_ActorProbDwe[3] = 0.0
			Opt_ActorProbDwe[4] = 0.0
			Opt_ActorProbDwe[5] = 0.0
			Opt_ActorProbDwe[6] = 0.0

		elseif Opt_PresetIndex == 2
			doDwemer = true
			giveSpell = false
			NPCScanDist = 3500
			OccupiedProb = 1.0
			UnoccupiedProb = 0.0

			;Set unoccupied probability by location type: 0-Default, 1-Cave, 2-Dwarven Ruin, 3-Nordic Ruin
			Opt_UnocProbFire[0] = 0.0
			Opt_UnocProbFire[1] = 0.0
			Opt_UnocProbFire[2] = 0.0
			Opt_UnocProbFire[3] = 0.0

			Opt_UnocProbCandle[0] = 0.0
			Opt_UnocProbCandle[1] = 0.0
			Opt_UnocProbCandle[2] = 0.0
			Opt_UnocProbCandle[3] = 0.0

			Opt_UnocProbDwe[0] = 0.0
			Opt_UnocProbDwe[1] = 0.0
			Opt_UnocProbDwe[2] = 0.0
			Opt_UnocProbDwe[3] = 0.0

			;Set Actor probability by location type: 0-Default NPC, 1-Dragr, 2-DwarvenAutomaton, 3-Falmer, 4-Hargraven
			;5-Riekling, 6-Vampire
			Opt_ActorProbFire[0] = 1.0
			Opt_ActorProbFire[1] = 0.0
			Opt_ActorProbFire[2] = 0.0
			Opt_ActorProbFire[3] = 0.0
			Opt_ActorProbFire[4] = 0.25
			Opt_ActorProbFire[5] = 1.0
			Opt_ActorProbFire[6] = 0.0

			Opt_ActorProbCandle[0] = 1.0
			Opt_ActorProbCandle[1] = 0.0
			Opt_ActorProbCandle[2] = 0.0
			Opt_ActorProbCandle[3] = 0.0
			Opt_ActorProbCandle[4] = 1.0
			Opt_ActorProbCandle[5] = 1.0
			Opt_ActorProbCandle[6] = 1.0

			Opt_ActorProbDwe[0] = 0.0
			Opt_ActorProbDwe[1] = 0.0
			Opt_ActorProbDwe[2] = 1.0
			Opt_ActorProbDwe[3] = 0.0
			Opt_ActorProbDwe[4] = 0.0
			Opt_ActorProbDwe[5] = 0.0
			Opt_ActorProbDwe[6] = 0.0
			
		elseif Opt_PresetIndex == 3
			doDwemer = true
			giveSpell = false
			NPCScanDist = 2000
			OccupiedProb = 0.5
			UnoccupiedProb = 0.0

			;Set unoccupied probability by location type: 0-Default, 1-Cave, 2-Dwarven Ruin, 3-Nordic Ruin
			Opt_UnocProbFire[0] = 0.0
			Opt_UnocProbFire[1] = 0.0
			Opt_UnocProbFire[2] = 0.0
			Opt_UnocProbFire[3] = 0.0

			Opt_UnocProbCandle[0] = 0.0
			Opt_UnocProbCandle[1] = 0.0
			Opt_UnocProbCandle[2] = 0.0
			Opt_UnocProbCandle[3] = 0.0

			Opt_UnocProbDwe[0] = 0.0
			Opt_UnocProbDwe[1] = 0.0
			Opt_UnocProbDwe[2] = 0.0
			Opt_UnocProbDwe[3] = 0.0

			;Set Actor probability by location type: 0-Default NPC, 1-Dragr, 2-DwarvenAutomaton, 3-Falmer, 4-Hargraven
			;5-Riekling, 6-Vampire
			Opt_ActorProbFire[0] = 0.75
			Opt_ActorProbFire[1] = 0.0
			Opt_ActorProbFire[2] = 0.0
			Opt_ActorProbFire[3] = 0.0
			Opt_ActorProbFire[4] = 0.25
			Opt_ActorProbFire[5] = 0.75
			Opt_ActorProbFire[6] = 0.0

			Opt_ActorProbCandle[0] = 0.75
			Opt_ActorProbCandle[1] = 0.0
			Opt_ActorProbCandle[2] = 0.0
			Opt_ActorProbCandle[3] = 0.0
			Opt_ActorProbCandle[4] = 0.75
			Opt_ActorProbCandle[5] = 0.5
			Opt_ActorProbCandle[6] = 0.75

			Opt_ActorProbDwe[0] = 0.0
			Opt_ActorProbDwe[1] = 0.0
			Opt_ActorProbDwe[2] = 0.25
			Opt_ActorProbDwe[3] = 0.0
			Opt_ActorProbDwe[4] = 0.0
			Opt_ActorProbDwe[5] = 0.0
			Opt_ActorProbDwe[6] = 0.0

		else
			;Custom preset do nothing
		endIf
	endFunction
	
	int Function Get()
		return Opt_PresetIndex
	EndFunction
	
endProperty

Event OnInit()

	Opt_doFadeout = gvOpt_doFadeout.getvalue() as bool
	Opt_doDwemer = gvOpt_doDwemer.getvalue() as bool
	Opt_giveSpell = false
	Opt_noLocPrompt = false
	Opt_STInstalled = false
	Opt_STDisable = true
	Opt_ELFXInstalled = false
	Opt_ELFXDisableCandleSmoke = false
	Opt_enableFireLighter = false
	Opt_NPCScanDist = gvOpt_NPCScanDist.getvalue()
	Opt_OccupiedProb = gvOpt_OccupiedProb.getvalue()
	Opt_UnoccupiedProb = gvOpt_UnoccupiedProb.getvalue()
	Opt_isModEnabled = true
	Opt_PresetIndex = gvOpt_PresetIndex.getvalue() as int
	Opt_DebugMode = false
	
	Opt_NotificationLevel = 1
	Opt_NotificationLevelText = new string[3]
	Opt_NotificationLevelText[0] = "None"
	Opt_NotificationLevelText[1] = "Minimal"
	Opt_NotificationLevelText[2] = "Detailed"
	
	Opt_UnocProbFireDefault = new float[10]
	Opt_UnocProbCandleDefault = new float[10]
	Opt_UnocProbDweDefault = new float[10]
	
	Opt_UnocProbFire = new float[10]
	Opt_UnocProbCandle = new float[10]
	Opt_UnocProbDwe = new float[10]

	Opt_ActorProbFireDefault = new float[10]
	Opt_ActorProbCandleDefault = new float[10]
	Opt_ActorProbDweDefault = new float[10]
	
	Opt_ActorProbFire = new float[10]
	Opt_ActorProbCandle = new float[10]
	Opt_ActorProbDwe = new float[10]

	;Set unoccupied probability defaults by location type: 0-Default, 1-Cave, 2-Dwarven Ruin, 3-Nordic Ruin
	Opt_UnocProbFireDefault[0] = 0.0
	Opt_UnocProbFireDefault[1] = 0.0
	Opt_UnocProbFireDefault[2] = 0.0
	Opt_UnocProbFireDefault[3] = 0.0

	Opt_UnocProbCandleDefault[0] = 0.0
	Opt_UnocProbCandleDefault[1] = 0.0
	Opt_UnocProbCandleDefault[2] = 0.0
	Opt_UnocProbCandleDefault[3] = 0.0
	
	Opt_UnocProbDweDefault[0] = 0.0
	Opt_UnocProbDweDefault[1] = 0.0
	Opt_UnocProbDweDefault[2] = 0.0
	Opt_UnocProbDweDefault[3] = 0.0
	
	;Initialize unoccupied probabilities by location type: 0-Default, 1-Cave, 2-Dwarven Ruin, 3-Nordic Ruin
	int xindex = 0
	while xindex < 4
		Opt_UnocProbFire[xindex] = Opt_UnocProbFireDefault[xindex]
		Opt_UnocProbCandle[xindex] = Opt_UnocProbCandleDefault[xindex]
		Opt_UnocProbDwe[xindex] = Opt_UnocProbDweDefault[xindex]
		xindex += 1
	endWhile

	;Set Actor probability defaults by location type: 0-Default NPC, 1-Dragr, 2-DwarvenAutomaton, 3-Falmer, 4-Hargraven
	;5-Riekling, 6-Vampire
	
	Opt_ActorProbFireDefault[0] = 1.0
	Opt_ActorProbFireDefault[1] = 0.0
	Opt_ActorProbFireDefault[2] = 0.0
	Opt_ActorProbFireDefault[3] = 0.0
	Opt_ActorProbFireDefault[4] = 0.25
	Opt_ActorProbFireDefault[5] = 1.0
	Opt_ActorProbFireDefault[6] = 0.0

	Opt_ActorProbCandleDefault[0] = 1.0
	Opt_ActorProbCandleDefault[1] = 0.0
	Opt_ActorProbCandleDefault[2] = 0.0
	Opt_ActorProbCandleDefault[3] = 0.0
	Opt_ActorProbCandleDefault[4] = 1.0
	Opt_ActorProbCandleDefault[5] = 1.0
	Opt_ActorProbCandleDefault[6] = 1.0

	Opt_ActorProbDweDefault[0] = 0.0
	Opt_ActorProbDweDefault[1] = 0.0
	Opt_ActorProbDweDefault[2] = 1.0
	Opt_ActorProbDweDefault[3] = 0.0
	Opt_ActorProbDweDefault[4] = 0.0
	Opt_ActorProbDweDefault[5] = 0.0
	Opt_ActorProbDweDefault[6] = 0.0

	
	;Initialize unoccupied probabilities by location type: 0-Default, 1-Cave, 2-Dwarven Ruin, 3-Nordic Ruin
	xindex = 0
	while xindex < 7
		Opt_ActorProbFire[xindex] = Opt_ActorProbFireDefault[xindex]
		Opt_ActorProbCandle[xindex] = Opt_ActorProbCandleDefault[xindex]
		Opt_ActorProbDwe[xindex] = Opt_ActorProbDweDefault[xindex]
		xindex += 1
	endWhile

	
EndEvent

;*** Toggle Functions ***

Function Toggle_doFadeout()

	Opt_doFadeout = !Opt_doFadeout
	gvOpt_doFadeout.setvalue(Opt_doFadeout as float)
	jbUtils.DebugTrace("Fadeout set to "+Opt_doFadeout)
	jbUtils.DebugTrace("Fadeout global set to "+gvOpt_doFadeout.getvalue())

EndFunction

Function Toggle_doDwemer()

	Opt_doDwemer = !Opt_doDwemer
	gvOpt_doDwemer.setvalue(Opt_doDwemer as float)
	jbUtils.DebugTrace("Dwemer set to "+Opt_doDwemer)
	jbUtils.DebugTrace("Dwemer global set to "+gvOpt_doDwemer.getvalue())

EndFunction

Function Toggle_giveSpell()

	giveSpell = !giveSpell
	jbUtils.DebugTrace("giveSpell set to "+Opt_giveSpell)

EndFunction

Function Toggle_noLocPrompt()

	noLocPrompt = !noLocPrompt
	jbUtils.DebugTrace("noLocPrompt set to "+Opt_noLocPrompt)

EndFunction

Function Toggle_STInstalled()

	STInstalled = !STInstalled
	jbUtils.DebugTrace("STInstalled set to "+Opt_STInstalled)

EndFunction

Function Toggle_STDisable()

	Opt_STDisable = !Opt_STDisable
	jbUtils.DebugTrace("STDisable set to "+Opt_STDisable)

EndFunction

Function Toggle_ELFXInstalled()

	Opt_ELFXInstalled = !Opt_ELFXInstalled
	jbUtils.DebugTrace("ELFXInstalled set to "+Opt_ELFXInstalled)

EndFunction

Function Toggle_ELFXDisableCandleSmoke()

	Opt_ELFXDisableCandleSmoke = !Opt_ELFXDisableCandleSmoke
	jbUtils.DebugTrace("ELFXDisableCandleSmoke set to "+Opt_ELFXDisableCandleSmoke)

EndFunction

Function Toggle_enableFireLighter()

	enableFireLighter = !enableFireLighter
	jbUtils.DebugTrace("enableFireLighter set to "+Opt_enableFireLighter)

EndFunction

Function Toggle_isModEnabled()

	Opt_isModEnabled = !Opt_isModEnabled
	jbUtils.DebugTrace("isModEnabled set to "+Opt_isModEnabled)
	
EndFunction

Function Toggle_DebugMode()

	Opt_DebugMode = !Opt_DebugMode
	jbUtils.DebugTrace("DebugMode set to "+Opt_DebugMode)
	
EndFunction

Function Toggle_ScanCurrentDungeon()

	Opt_ScanCurrentDungeon = !Opt_ScanCurrentDungeon
	jbUtils.DebugTrace("ScanCurrentDungeon set to "+Opt_ScanCurrentDungeon)
	
EndFunction

Function Toggle_ResetCurrentDungeon()

	Opt_ResetCurrentDungeon = !Opt_ResetCurrentDungeon
	jbUtils.DebugTrace("ResetCurrentDungeon set to "+Opt_ResetCurrentDungeon)
	
EndFunction

Function Toggle_ResetAllDungeons()

	Opt_ResetAllDungeons = !Opt_ResetAllDungeons
	jbUtils.DebugTrace("ResetAllDungeons set to "+Opt_ResetAllDungeons)
	
EndFunction

;*** Cycle function for text types

Function Increment_NotificationLevel()

	if Opt_NotificationLevel < Opt_NotificationLevelText.Length - 1
		Opt_NotificationLevel += 1
	else
		Opt_NotificationLevel = 0
	endIf
	jbUtils.DebugTrace("Notification level incremented to "+Opt_NotificationLevel)
endFunction

;*** Get and Set Functions for Location Types

float Function GetUnocProb(int aklocset, int aklighttype)

	if aklighttype == 0
		return Opt_UnocProbFire[aklocset]
	elseif aklighttype == 1
		return Opt_UnocProbCandle[aklocset]
	elseif aklighttype == 2
		return Opt_UnocProbDwe[aklocset]
	else
		return 0.0
	endIf

endFunction

Function SetUnocProb(int aklocset, int aklighttype, float akvalue)

	if aklighttype == 0
		Opt_UnocProbFire[aklocset] = akvalue
		jbUtils.DebugTrace("Fire prob for locset "+aklocset+" set to "+akvalue)
	elseif aklighttype == 1
		Opt_UnocProbCandle[aklocset] = akvalue
		jbUtils.DebugTrace("Candle prob for locset "+aklocset+" set to "+akvalue)
	elseif aklighttype == 2
		Opt_UnocProbDwe[aklocset] = akvalue
		jbUtils.DebugTrace("Candle prob for locset "+aklocset+" set to "+akvalue)
	else
		; do nothing
	endIf

endFunction

float Function GetUnocProbDefault(int aklocset, int aklighttype)

	if aklighttype == 0
		return Opt_UnocProbFireDefault[aklocset]
	elseif aklighttype == 1
		return Opt_UnocProbCandleDefault[aklocset]
	elseif aklighttype == 2
		return Opt_UnocProbDweDefault[aklocset]
	else
		return 0.0
	endIf

endFunction
	
;*** Get and Set Functions for Actor Types
	
float Function GetActorProb(int akactortype, int aklighttype)

	if aklighttype == 0
		jbUtils.DebugTrace("Returning ActorProb "+Opt_ActorProbFire[akactortype])
		return Opt_ActorProbFire[akactortype]
	elseif aklighttype == 1
		jbUtils.DebugTrace("Returning ActorProb "+Opt_ActorProbCandle[akactortype])
		return Opt_ActorProbCandle[akactortype]
	elseif aklighttype == 2
		jbUtils.DebugTrace("Returning ActorProb "+Opt_ActorProbDwe[akactortype])
		return Opt_ActorProbDwe[akactortype]
	else
		return 0.0
	endIf

endFunction

float Function GetMaxProbforActor(int akactortype)

	float thisprob
	float maxprob = 0
	int ltypeindex = 0
	while ltypeindex < 3
		thisprob = GetActorProb(akactortype,ltypeindex)
		if thisprob > maxprob
			maxprob = thisprob
		endIf
		ltypeindex +=1
	endWhile
	jbUtils.DebugTrace("Returning MaxProb "+maxprob)
	return maxprob
endFunction	

Function SetActorProb(int akactortype, int aklighttype, float akvalue)

	if aklighttype == 0
		Opt_ActorProbFire[akactortype] = akvalue
		jbUtils.DebugTrace("Fire prob for actor type "+akactortype+" set to "+akvalue)
	elseif aklighttype == 1
		Opt_ActorProbCandle[akactortype] = akvalue
		jbUtils.DebugTrace("Candle prob for actor type "+akactortype+" set to "+akvalue)
	elseif aklighttype == 2
		Opt_ActorProbDwe[akactortype] = akvalue
		jbUtils.DebugTrace("Dwarven prob for actor type "+akactortype+" set to "+akvalue)
	else
		; do nothing
	endIf

endFunction

float Function GetActorProbDefault(int akactortype, int aklighttype)

	if aklighttype == 0
		return Opt_ActorProbFireDefault[akactortype]
	elseif aklighttype == 1
		return Opt_ActorProbCandleDefault[akactortype]
	elseif aklighttype == 2
		return Opt_ActorProbDweDefault[akactortype]
	else
		return 0.0
	endIf

endFunction

Function dumpOptions()

	debug.trace("DoFadeOut: "+Opt_doFadeout)
	debug.trace("DoDwemer: "+Opt_doDwemer)
	debug.trace("GiveSpell: "+Opt_giveSpell)
	debug.trace("noLocPrompt: "+Opt_noLocPrompt)
	debug.trace("STInstalled: "+Opt_STInstalled)
	debug.trace("STDisable: "+Opt_STDisable)
	debug.trace("ELFXInstalled: "+Opt_ELFXInstalled)
	debug.trace("ELFXDisableCandleSmoke: "+Opt_ELFXDisableCandleSmoke)
	debug.trace("enableFireLighter: "+Opt_enableFireLighter)
	debug.trace("NPCScanDist: "+Opt_NPCScanDist)
	debug.trace("OccupiedProb: "+Opt_OccupiedProb)
	debug.trace("UnoccupiedProb: "+Opt_UnoccupiedProb)
	debug.trace("isModEnabled: "+Opt_isModEnabled)
	debug.trace("PresetIndex: "+Opt_PresetIndex)
	debug.trace("DebugMode: "+Opt_DebugMode)
	debug.trace("NotificationLevel: "+Opt_NotificationLevel)

	debug.trace("UnoccupiedProbFire: "+Opt_UnocProbFire)
	debug.trace("UnoccupiedProbCandle: "+Opt_UnocProbCandle)
	debug.trace("UnoccupiedProbDwe: "+Opt_UnocProbDwe)

	debug.trace("ActorProbFire: "+Opt_ActorProbFire)
	debug.trace("ActorProbCandle: "+Opt_ActorProbCandle)
	debug.trace("ActorProbDwe: "+Opt_ActorProbDwe)

endFunction

	
	