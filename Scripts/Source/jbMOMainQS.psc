scriptname jbMOMainQS extends Quest

import math
;import storageutil

Quest Property StaticsQ Auto
Quest Property LightsQ Auto
Quest Property FiresQ Auto
Quest Property FogsQ Auto
Quest Property FogsQ2 Auto
Quest Property FogsResetQ Auto
Quest Property FogsResetQ2 Auto
Quest Property ActivatorsQ Auto
Quest Property CloseByQ Auto
FormList Property lStatics Auto
FormList Property lActivators Auto
FormList Property lLights Auto
FormList Property lFireLightSources Auto
FormList Property lFireLightsOff Auto
FormList Property lCandleLightSources Auto
FormList Property lCandleLightsOff	Auto
FormList Property lDwemerLightSources Auto
FormList Property lAllLightSources Auto
FormList Property lELFXCandleSmoke Auto
Activator Property torchActivator Auto
Activator Property oilLamp Auto
Activator Property FireMarker Auto
Activator Property CandleMarkerBig Auto
Activator Property CandleMarkerSmall Auto
Keyword Property actorTypeNPCKW Auto
Keyword Property actorTypeGhostKW Auto
Message Property resetAllDungeonsMessage Auto
jbMOOptions Property Options Auto
jbMOUtils Property jbUtils Auto
FormList Property lSunLights Auto
FormList Property lFogsandMists Auto
FormList Property lAmbients Auto
FormList Property lSmokes Auto
FormList Property lNPCExclusions Auto
FormList Property lOilLampExtender Auto
FormList Property lOilLampRope Auto
FormList Property lExceptionCells Auto
FormList Property lLightMarkers Auto
;jbMODisableLightThreadManager Property threadManager Auto
jbMOScanNPCThreadManager Property ScanNPCManager Auto
ObjectReference Property playerRef Auto
ImageSpaceModifier Property pFadeToBlack Auto
ImageSpaceModifier Property pFadeFromBlack Auto
Int Property npcCount Auto Hidden
Int Property CurrentLocType Auto Hidden
Form[] Property npcList
	Form[] function get()
		return npcListvar
	endFunction
endProperty
Bool Property isProcessing
	bool function get()
		return Processing
	endFunction
endProperty
Int[] Property npcTypes
	Int[] function get()
		return npcTypesvar
	endFunction
endProperty

FormList Property DraugrRaceList Auto
Keyword Property DwarvenKW Auto
Race Property FalmerRace Auto
Race Property HargravanRace Auto
FormList Property RieklingRaceList Auto
Keyword Property VampireKW Auto
Bool Property ResetDungeon = False Auto Hidden

Int nDisLights = 0
Int nDisabledStatics = 0
Int nCallbackStatics = 0
Int CallBackCount
Int CurrentLocType
Cell pCell
Bool Processing = false
Bool isSneakToolsPaused = false

Form[] dlist0
Form[] dlist1
Form[] dlist2
Form[] deleteIDList

Form[] npcListvar
Int[] npcTypesvar


Event OnInit()

	jbUtils.DebugNotification("Dungeon Darkness Initialized",0)
	dlist0 = New Form[128]
	dlist1 = New Form[128]
	dlist2 = New Form[128]
	deleteIDList = New Form[128]
	npcListvar = New Form[128]
	npcTypesvar = New int[128]
	CheckforELFX()
	CheckforSneakTools()
EndEvent

Function doGameLoad()

;	threadManager.InitializeThreadManager()
	ScanNPCManager.InitializeThreadManager()
	if !Processing
		deleteIDList = New Form[128]
		npcListvar = New Form[128]
		npcTypesvar = New int[128]
	endIf

	CheckforELFX()
	CheckforSneakTools()

	;    RegisterForModEvent("JBMod_UninstallNow", "OnUninstallNow")

EndFunction

Function TerminateProcessing()
	jbUtils.DebugTrace("Terminating processing")
	Processing = false
endFunction

bool Function checkExceptionCells(Cell akpCell)

	if lExceptionCells.hasForm(akpCell)
		jbUtils.DebugTrace("Found "+akpCell+" in "+lExceptionCells)
		Return True
	Else
		jbUtils.DebugTrace("Did not find "+akpCell+" in "+lExceptionCells)
		Return False
	endIf
	
endFunction

Function dungeonScan(Cell akpCell, Int akLocType, Bool akWasinDungeon)

	Processing = True
	pCell = akpCell
	CurrentLocType = akLocType
	
	if Options.STDisable
		SneakToolsPause()
	endIf

	if findDoneCell(pCell as Form)
	
		jbUtils.DebugNotification("Dungeon previously done")
		
	Else

		float start_time = Utility.GetCurrentRealTime()
		jbUtils.DebugNotification("Turning out lights",1)
		jbUtils.DebugTrace("Turning out lights in "+pCell)

		if Options.DebugMode
			jbUtils.dumpModInfo()
			Options.dumpOptions()
		endIf
		
		if Options.doFadeout
			debug.ToggleAI()
			DoFadeOut()
		endif
		
		scanActors()

		disableLightAliases("Lights",LightsQ)
		disableLightAliases("Fires",FiresQ)
		if Options.doFadeout
			disableLightAliases("CloseBy",CloseByQ)
			DoFadeIn()
			debug.ToggleAI()
		endif

		disableLightAliases("Fogs",FogsQ)
;		if pCell.getFormID() == 0x00015258
;			disableLightAliases("Fogs 2",FogsQ2)
;		endIf
;		disableLightAliases("Activators",ActivatorsQ)
		disableLightAliases("Statics",StaticsQ)

		float end_time = Utility.GetCurrentRealTime()
		float time_delta = end_time - start_time
		jbUtils.DebugNotification("Lights turned out in " + time_delta + " seconds.",1)
		jbUtils.DebugTrace("Script completed in " + time_delta + " seconds.")
		
		if Processing
			addDoneCell(pCell as Form)
		endIf

		CloseByQ.Stop()
		LightsQ.Stop()
		FiresQ.Stop()
		FogsQ.Stop()
		FogsQ2.Stop()
		ActivatorsQ.Stop()
		StaticsQ.Stop()
		
		npcListvar = new form[128]
		npcTypesvar = new int[128]

	EndIf
		
	pCell = None
	Processing = False
	
EndFunction

Function scanActors()

	int aktype = 43
	Int numRefs = pCell.GetNumRefs(aktype)
	Int xIndex = 0
	npcCount = 0
	RegisterForModEvent("JBMod_ScanNPCCallback", "ScanNPCCallback")
	jbUtils.DebugTrace("Scanning for NPCs")
	jbUtils.DebugTrace("Found "+numRefs+" actors in cell.")

	ScanNPCManager.loadforRun(Self,pCell)
	
	while xIndex < numRefs
		ScanNPCManager.ScanNPCAsync(xIndex)
		xIndex += 1
	endWhile
	ScanNPCManager.wait_all()
	ScanNPCManager.clear_vars()
	
	jbUtils.DebugTrace("Found "+npcCount+" NPCs in cell.")
	jbUtils.DebugTrace(npcListvar)
	jbUtils.DebugTrace(npcTypesvar)
	
EndFunction

bool locked = false
Event ScanNPCCallback(Form akNPCForm, Int akNPCType, bool akAddActor)

	;A spin lock is required here
	while locked
		Utility.wait(0.01)
	endWhile
	locked = true

	if akNPCForm != None && npcCount < 128
		;Add actor to npc list for lights based on evaluation logic from npcscan thread
		if akAddActor
			ArrayAddForm(npcListvar,akNPCForm)
			npcTypesvar[npcCount] = akNPCType
			npcCount += 1
		endIf
	endIf

	locked = false

endEvent

float function getDistancebetweenRefs(form ref1, form ref2)

	objectreference akref1 = ref1 as objectreference
	objectreference akref2 = ref2 as objectreference
	float refdist = sqrt( pow(akref1.GetPositionX() - akref2.GetPositionX(), 2) + pow(akref1.GetPositionY() - akref2.getpositionY(),2) + pow(akref1.getpositionz() - akref2.getpositionz(),2))
	jbUtils.DebugTrace(refdist+" distance between "+akref1+" and "+akref2)
	return refdist
	
EndFunction

Function disableLightAliases(String msgText, Quest AliasQuest)

	nDisLights = 0
	CallBackCount = 0

	;Register for the callback event
	RegisterForModEvent("JBMod_DisableLightAliasCallback", "DisableLightAliasCallback")
	jbUtils.DebugTrace("Doing "+msgText)

	If AliasQuest.isRunning()
		AliasQuest.Stop()
	endIf
	AliasQuest.Start()

	int numAliases = AliasQuest.getNumAliases()
	
	AliasQuestWait(numAliases)
	
	jbUtils.DebugNotification(nDisLights+" "+msgText+" Disabled")
EndFunction

Function AliasQuestWait(int nAliases)

	jbUtils.DebugTrace("***Waiting for "+nAliases+" alias callbacks")

	while CallBackCount < nAliases
		Utility.wait(0.5)
	endWhile

	jbUtils.DebugTrace("Alias waiting complete.  Number of Disabled: "+nDisLights)
	
endFunction

Event DisableLightAliasCallback(Bool akResult)

	;A spin lock is required here
	while locked
		Utility.wait(0.01)
	endWhile
	locked = true
	CallBackCount += 1
	nDisLights += akResult as Int
	
;	jbUtils.DebugTrace("Received Callback #"+CallBackCount+"  Result = "+akResult)
	
	locked = false

endEvent


Function dungeonReset(Cell akpCell)

	Processing = True
	pCell = akpCell

	if !findDoneCell(pCell as Form)
	
		jbUtils.DebugNotification("Dungeon not previously done",0)
		
	Else

		float start_time = Utility.GetCurrentRealTime()

		ResetDungeon = True
		
		jbUtils.DebugNotification("Resetting lights in "+pCell,0)
		jbUtils.DebugTrace("Resetting lights in "+pCell)
	
		disableLightAliases("Lights",LightsQ)
		disableLightAliases("Fires",FiresQ)
		disableLightAliases("Fogs",FogsResetQ)
		disableLightAliases("Fogs2",FogsResetQ2)
;		disableLightAliases("Activators",ActivatorsQ)
		disableLightAliases("Statics",StaticsQ)

		CloseByQ.Stop()
		LightsQ.Stop()
		FiresQ.Stop()
		FogsResetQ.Stop()
		FogsResetQ2.Stop()
		ActivatorsQ.Stop()
		StaticsQ.Stop()

		float end_time = Utility.GetCurrentRealTime()
		float time_delta = end_time - start_time
		jbUtils.DebugNotification("Lights reset in " + time_delta + " seconds.",0)
		jbUtils.DebugTrace("Script completed in " + time_delta + " seconds.")
		
		if Processing
			RemoveCell(pCell as Form)
		endIf

		ResetDungeon = False

	EndIf
		
	pCell = None
	Processing = False
	
EndFunction

Function resetLights(String msgText, Int lightType, FormList lightList)

	Int nLights = pCell.GetNumRefs(lightType)
	nDisLights = 0

	;Register for the callback event
	RegisterForModEvent("JBMod_DisableLightCallback", "DisableLightCallback")
	jbUtils.DebugTrace("Doing "+msgText)
	jbUtils.DebugNotification("Found "+nLights+" "+msgText+" in cell.")

;	threadManager.loadforRun(Self,pCell,-1,lightType,lightList,2)
	Int xIndex = 0
	While Processing && xIndex < nLights
;		threadManager.DisableLightAsync(xIndex)
		xIndex += 1
	EndWhile
;	threadManager.wait_all()
;	threadManager.clear_vars()
	
	jbUtils.DebugNotification(nDisLights+" "+msgText+" Reset")
	
	;Check for any to delete
	if arrayCount(deleteIDList) > 0
		int numtoDelete = arrayCount(deleteIDList)
		xIndex = 0
		while xIndex < numtoDelete
			(deleteIDList[xIndex] as objectreference).delete()
			jbUtils.DebugTrace("Deleting "+(deleteIDList[xIndex] as objectreference))
			xIndex += 1
		endWhile
		ArrayClear(deleteIDList)
	endIf
	
EndFunction

Event DisableLightCallback(Int akResult, Form akdeleteForm)

	;A spin lock is required here
	while locked
		Utility.wait(0.1)
	endWhile
	locked = true

	;Check if added fog that needs to be deleted.
	if akdeleteForm != None
		ArrayAddForm(deleteIDList,akdeleteForm)
	endIf
	if akResult == 0
		CallBackCount += 1
	else
		CallBackCount = 0
	endIf
	nDisLights +=akResult
	locked = false

endEvent

Function CheckforELFX()

	lLights.revert()
	lFogsandMists.revert()
	lStatics.revert()
	lELFXCandleSmoke.revert()

	Options.ELFXInstalled = (Game.GetModbyName("EnhancedLightsandFX.esp") < 255)
	
	if Options.ELFXInstalled
		AddELFXForms()
	endIf

endFunction		

Function AddELFXForms()

	lLights.addForm(Game.GetFormFromFile(0x0000F374, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x00023CD5, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x0004101C, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000A63D1, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000B4528, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000C0A75, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000D28E1, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000D72C2, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000DCCD2, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000E6E1E, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x001520D8, "EnhancedLightsandFX.esp"))

	lELFXCandleSmoke.addForm(Game.GetFormFromFile(0x00088419, "EnhancedLightsandFX.esp"))
	lELFXCandleSmoke.addForm(Game.GetFormFromFile(0x00088980, "EnhancedLightsandFX.esp"))
	lELFXCandleSmoke.addForm(Game.GetFormFromFile(0x00088981, "EnhancedLightsandFX.esp"))
	lELFXCandleSmoke.addForm(Game.GetFormFromFile(0x00088982, "EnhancedLightsandFX.esp"))
	lELFXCandleSmoke.addForm(Game.GetFormFromFile(0x000036C9, "EnhancedLightsandFX.esp"))
	lELFXCandleSmoke.addForm(Game.GetFormFromFile(0x000036CA, "EnhancedLightsandFX.esp"))
	lELFXCandleSmoke.addForm(Game.GetFormFromFile(0x000036CB, "EnhancedLightsandFX.esp"))
	lELFXCandleSmoke.addForm(Game.GetFormFromFile(0x000036CC, "EnhancedLightsandFX.esp"))

;	lAmbients.addForm(Game.GetFormFromFile(0x00088419, "EnhancedLightsandFX.esp"))
;	lAmbients.addForm(Game.GetFormFromFile(0x00088980, "EnhancedLightsandFX.esp"))
;	lAmbients.addForm(Game.GetFormFromFile(0x00088981, "EnhancedLightsandFX.esp"))
;	lAmbients.addForm(Game.GetFormFromFile(0x00088982, "EnhancedLightsandFX.esp"))
;	lAmbients.addForm(Game.GetFormFromFile(0x000036C9, "EnhancedLightsandFX.esp"))
;	lAmbients.addForm(Game.GetFormFromFile(0x000036CA, "EnhancedLightsandFX.esp"))
;	lAmbients.addForm(Game.GetFormFromFile(0x000036CB, "EnhancedLightsandFX.esp"))
;	lAmbients.addForm(Game.GetFormFromFile(0x000036CC, "EnhancedLightsandFX.esp"))

	lFogsandMists.addForm(Game.GetFormFromFile(0x000A9884, "EnhancedLightsandFX.esp"))
	lFogsandMists.addForm(Game.GetFormFromFile(0x000D727C, "EnhancedLightsandFX.esp"))
	lFogsandMists.addForm(Game.GetFormFromFile(0x000D72D0, "EnhancedLightsandFX.esp"))
	
	lStatics.addForm(Game.GetFormFromFile(0x000E7915, "EnhancedLightsandFX.esp"))
	lStatics.addForm(Game.GetFormFromFile(0x00110813, "EnhancedLightsandFX.esp"))
	lStatics.addForm(Game.GetFormFromFile(0x00156214, "EnhancedLightsandFX.esp"))

endFunction

Function CheckforSneakTools()

	Bool SneakToolsInstalled = (Game.GetModbyName("Sneak Tools.esp") < 255)
	jbUtils.DebugTrace ("Sneak tools installed: "+SneakToolsInstalled)
	
	if SneakToolsInstalled
		Options.STInstalled = true
	else
		isSneakToolsPaused = false
		Options.STInstalled = false
	endIf

endFunction

Function SneakToolsPause()
	
	Form STMainQ = Game.GetFormFromFile(0x00000D63,"Sneak Tools.esp")
	Quest STAliasQ = Game.GetFormFromFile(0x0007232C, "Sneak Tools.esp") as Quest
	jbUtils.DebugTrace ("Pausing Sneak tools: "+STMainQ+"-"+STAliasQ)
	
	if STMainQ
		STMainQ.UnregisterforUpdate()
		STAliasQ.Stop()
		isSneakToolsPaused = True
	endIf

EndFunction

Function SneakToolsResume()
	
	Form STMainQ = Game.GetFormFromFile(0x00000D63,"Sneak Tools.esp")
	jbUtils.DebugTrace ("Resuming Sneak tools: "+STMainQ)
	
	if isSneakToolsPaused && STMainQ
		STMainQ.RegisterforSingleUpdate(3)
		isSneakToolsPaused = False
	endIf

EndFunction
	
Function addDoneCell(Form myForm)

	if ArrayCount(dlist0) < 128	
		ArrayAddForm(dlist0,myForm)
	ElseIf ArrayCount(dlist1) < 128
		ArrayAddForm(dlist1,myForm)
	Else 
		ArrayAddForm(dlist2,myForm)
	EndIf
	
EndFunction

Function RemoveCell(Form myForm)

	if ArrayRemoveForm(dlist0,myForm)
		;do nothing
	ElseIf ArrayRemoveForm(dlist1,myForm)
		;do nothing
	ElseIf ArrayRemoveForm(dlist2,myForm)
		;do nothing
	Else
		;do nothing
	EndIf
	
EndFunction

bool Function ArrayRemoveForm(Form[] myArray, form myForm)

	int i = 0
	bool found = false
	while i < myArray.Length && !found
		if myArray[i] == myForm
			myArray[i] = None
			found = true
		endIf
		i+=1
	endWhile
	jbUtils.DebugTrace(myArray)
	return found

endFunction
		
bool Function findDoneCell(Form myForm)

	if ArrayHasForm(dlist0, myForm) >= 0
		return true
	elseif ArrayHasForm(dlist1, myForm) >= 0 
		return true
	elseif ArrayHasForm(dlist2, myForm) >= 0
		return true
	else 
		return false
	EndIf

EndFunction

int Function ArrayCount(Form[] myArray)

	int i = 0
	int myCount = 0
	while i < myArray.Length
		if myArray[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
 
	return myCount
 
endFunction
 
int function ArrayHasForm(Form[] myArray, Form myForm)

	int i = 0
	;jbUtils.DebugTrace("Searching for "+myForm)
	dumpArrayContents(myArray)
	while i < myArray.Length
		if myArray[i] == myForm
			;jbUtils.DebugTrace("Found at position "+i)
			return i
		else
			i += 1
		endif
	endWhile
 
	return -1
 
endFunction

function ArrayAddForm(Form[] myArray, Form myForm)
 
	int i = 0
	while i < myArray.Length
		if myArray[i] == none
			myArray[i] = myForm
			;jbUtils.DebugTrace("Adding " + myForm + " to position "+i)
			i=myArray.Length
		else
			i += 1
		endif
	endWhile
	jbUtils.DebugTrace(myArray)
endFunction

function dumpArrayContents (Form[] myArray)

	int i = 0
	while i < myArray.Length
		jbUtils.DebugTrace("Array element "+i+":  "+myArray[i])
		i+=1
	endWhile

endFunction

Form[] Function ArrayClear(Form[] myArray)

	int i = 0
	int myCount = 0
	while i < myArray.Length
		myArray[i] = none
		i += 1
	endWhile
 
	return myArray
 
endFunction


Function DoFadeOut()
	debug.ToggleAI()
	Game.FadeOutGame(False,True,50, 1.0)
	Game.DisablePlayerControls(True,False,True,True,False,True,True,True)
 
EndFunction

;**************************************
; Fade the game back in after a call to DoFadeOut
;**************************************
Function DoFadeIn()
	Game.FadeOutGame(False,True,0.1, 2.0)
	pFadeToBlack.PopTo(pFadeFromBlack)
	Game.EnablePlayerControls()
	debug.ToggleAI()
EndFunction
;************************************
