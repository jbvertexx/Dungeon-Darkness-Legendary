scriptname jbMOMainQS extends Quest

import math
;import storageutil

FormList Property lStatics Auto
FormList Property lMovStatics Auto
FormList Property lActivators Auto
FormList Property lLights Auto
FormList Property lFireLightSources Auto
FormList Property lCandleLightSources Auto
FormList Property lDwemerLightSources Auto
FormList Property lAllLightSources Auto
Activator Property torchActivator Auto
Activator Property oilLamp Auto
Activator Property FireMarker Auto
Keyword Property actorTypeNPCKW Auto
Keyword Property actorTypeGhostKW Auto
Message Property resetAllDungeonsMessage Auto
jbMOOptions Property Options Auto
jbMOUtils Property jbUtils Auto
FormList Property lSunLights Auto
FormList Property lFogsandMists Auto
FormList Property lAmbients Auto
FormList Property lNPCExclusions Auto
FormList Property lOilLampExtender Auto
FormList Property lOilLampRope Auto
FormList Property lExceptionCells Auto
jbMODisableLightThreadManager Property threadManager Auto
jbMOScanNPCThreadManager Property ScanNPCManager Auto
ObjectReference Property playerRef Auto
ImageSpaceModifier Property pFadeToBlack Auto
ImageSpaceModifier Property pFadeFromBlack Auto
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

Int nDisLights = 0
Int npcCount
Int CallBackCount
Int CurrentLocType
Cell pCell
Bool Processing = false

Form[] dlist0
Form[] dlist1
Form[] dlist2
Form[] deleteIDList

Form[] npcListvar
Int[] npcTypesvar
Form[] npcDisableList


Event OnInit()

	jbUtils.DebugNotification("Dungeon Darkness Initialized",0)
	dlist0 = New Form[128]
	dlist1 = New Form[128]
	dlist2 = New Form[128]
	deleteIDList = New Form[128]
	npcListvar = New Form[128]
	npcTypesvar = New int[128]
	npcDisableList = New Form[128]
	CheckforELFX()	
EndEvent

Function doGameLoad()

	threadManager.InitializeThreadManager()
	ScanNPCManager.InitializeThreadManager()
	if !Processing
		deleteIDList = New Form[128]
		npcListvar = New Form[128]
		npcTypesvar = New int[128]
		npcDisableList = New Form[128]
	endIf
	CheckforELFX()

	;    RegisterForModEvent("JBMod_UninstallNow", "OnUninstallNow")

EndFunction

Function TerminateProcessing()
	jbUtils.DebugTrace("Terminating processing")
	Processing = false
endFunction

;Event OnUninstallNow()
;	jbUtils.DebugTrace("Uninstall event initiated in MainQS")
;	if Options.uninstallNow
;		jbUtils.DebugTrace("Uninstalling & stopping scripts")
;		(Options as Quest).Stop()
;		Stop()
;	endIf
;endEvent
		
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

	bool doDisableAI = false
	Processing = True
	pCell = akpCell
	CurrentLocType = akLocType

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
			DoFadeOut()
			doDisableAI = Options.disableAI
		endif
		
		scanActors(0,doDisableAI)

		disableLights("Lights",31,lLights)

		disableClosetoPlayer()

		if Options.doFadeout
			if Options.disableAI
				enableActors()
			endIf
			DoFadeIn()
		endif

		disableLights("Movstatics",36,lMovStatics)
		disableLights("Activators",24,lActivators)
		disableLights("Statics",34,lStatics)

		float end_time = Utility.GetCurrentRealTime()
		float time_delta = end_time - start_time
		jbUtils.DebugNotification("Lights turned out in " + time_delta + " seconds.",1)
		jbUtils.DebugTrace("Script completed in " + time_delta + " seconds.")
		
		if Processing
			addDoneCell(pCell as Form)
		endIf
		
		npcListvar = new form[128]
		npcTypesvar = new int[128]
		npcDisableList = new form[128]

	EndIf
		
	pCell = None
	Processing = False
	
EndFunction

Function scanActors(int akrunType, bool akDisableAI)

	int aktype = 43
	Int numRefs = pCell.GetNumRefs(aktype)
	Int xIndex = 0
	npcCount = 0
	RegisterForModEvent("JBMod_ScanNPCCallback", "ScanNPCCallback")
	jbUtils.DebugTrace("Scanning for NPCs")
	jbUtils.DebugTrace("Found "+numRefs+" actors in cell.")

	ScanNPCManager.loadforRun(Self,pCell,akrunType,akDisableAI)
	
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

Function enableActors()

int xIndex = 0
int numActors = ArrayCount(npcDisableList)
jbUtils.DebugTrace("Enableing Actor AI: "+numActors+" actors.")
jbUtils.DebugTrace(npcListvar)
Actor theActor
while xIndex < numActors
	theActor = npcDisableList[xIndex] as Actor
	jbUtils.DebugTrace("Enabling AI for: "+theActor)
	theActor.enableAI(true)
	xIndex+=1
endWhile

endFunction


bool locked = false
Event ScanNPCCallback(Form akNPCForm, Int akNPCType, bool akAddActor)

	;A spin lock is required here
	while locked
		Utility.wait(0.1)
	endWhile
	locked = true

	if akNPCForm != None && npcCount < 128
		;Add actor to list for re-enabling AI after blackout
		ArrayAddForm(npcDisableList,akNPCForm)
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


Function disableClosetoPlayer()

	int i = 0
	nDisLights = 0
	CallBackCount = 0

	jbUtils.DebugTrace("Doing close by movstatics")

	;Register for the callback event
	RegisterForModEvent("JBMod_DisableLightCallback", "DisableLightCallback")
	threadManager.loadforRun(Self,pCell,CurrentLocType,36,lMovStatics,1)

	while nDisLights < 20 && CallBackCount < (2*nDisLights+4) && i < 100
		jbUtils.DebugTrace("i="+i+"; nDisLights="+nDisLights+"; CallBackCount="+CallBackCount+"; CallBackCheck="+(2*nDisLights+4))
		threadManager.DisableLightAsync(i)
		i+=1
	endWhile

	threadManager.wait_all()
	threadManager.clear_vars()
	
	i = 0
	nDisLights = 0
	CallBackCount = 0

	jbUtils.DebugTrace("Doing close by activators")

	;Register for the callback event
	RegisterForModEvent("JBMod_DisableLightCallback", "DisableLightCallback")
	threadManager.loadforRun(Self,pCell,CurrentLocType,24,lActivators,1)

	while nDisLights < 20 && CallBackCount < (2*nDisLights+4) && i < 100
		jbUtils.DebugTrace("i="+i+"; nDisLights="+nDisLights+"; CallBackCount="+CallBackCount+"; CallBackCheck="+(2*nDisLights+4))
		threadManager.DisableLightAsync(i)
		i+=1
	endWhile

	threadManager.wait_all()
	threadManager.clear_vars()
	
	i = 0
	nDisLights = 0
	CallBackCount = 0

	jbUtils.DebugTrace("Doing close by statics")

	;Register for the callback event
	RegisterForModEvent("JBMod_DisableLightCallback", "DisableLightCallback")
	threadManager.loadforRun(Self,pCell,CurrentLocType,34,lStatics,1)

	while nDisLights < 20 && CallBackCount < (2*nDisLights+4) && i < 100
		jbUtils.DebugTrace("i="+i+"; nDisLights="+nDisLights+"; CallBackCount="+CallBackCount+"; CallBackCheck="+(2*nDisLights+4))
		threadManager.DisableLightAsync(i)
		i+=1
	endWhile

	threadManager.wait_all()
	threadManager.clear_vars()
	
	
endFunction


Function disableLights(String msgText, Int lightType, FormList lightList)


	Int nLights = pCell.GetNumRefs(lightType)
	nDisLights = 0

	;Register for the callback event
	RegisterForModEvent("JBMod_DisableLightCallback", "DisableLightCallback")
	jbUtils.DebugTrace("Doing "+msgText)
	jbUtils.DebugNotification("Found "+nLights+" "+msgText+" in cell.")

	threadManager.loadforRun(Self,pCell,CurrentLocType,lightType,lightList)
	Int xIndex = 0
	While Processing && xIndex < nLights
		threadManager.DisableLightAsync(xIndex)
		xIndex += 1
	EndWhile
	threadManager.wait_all()
	threadManager.clear_vars()
	
	jbUtils.DebugNotification(nDisLights+" "+msgText+" Disabled")
EndFunction

Function dungeonReset(Cell akpCell)

	Processing = True
	pCell = akpCell

	if !findDoneCell(pCell as Form)
	
		jbUtils.DebugNotification("Dungeon not previously done",0)
		
	Else

		float start_time = Utility.GetCurrentRealTime()

		jbUtils.DebugNotification("Resetting lights in "+pCell,0)
		jbUtils.DebugTrace("Resetting lights in "+pCell)
	
		resetLights("Lights",31,lLights)
		resetLights("Movstatics",36,lMovStatics)
		resetLights("Activators",24,lActivators)
		resetLights("Statics",34,lStatics)

		float end_time = Utility.GetCurrentRealTime()
		float time_delta = end_time - start_time
		jbUtils.DebugNotification("Lights reset in " + time_delta + " seconds.",0)
		jbUtils.DebugTrace("Script completed in " + time_delta + " seconds.")
		
		if Processing
			RemoveCell(pCell as Form)
		endIf
		
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

	threadManager.loadforRun(Self,pCell,-1,lightType,lightList,2)
	Int xIndex = 0
	While Processing && xIndex < nLights
		threadManager.DisableLightAsync(xIndex)
		xIndex += 1
	EndWhile
	threadManager.wait_all()
	threadManager.clear_vars()
	
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

;Function dungeonResetAll()
;
;	Processing = True
;	int dungeonCount
;	dungeonCount = arrayCount(dlist0) + arrayCount(dlist1) + arrayCount(dlist2)
;	
;	int MessageSelection = 0
;	MessageSelection = resetAllDungeonsMessage.show()
;	
;	If MessageSelection > 0
;		return
;	endIf
;	
;	int doneCount = 0
;	int xIndex = 0
;	while xIndex < 128
;		if dlist0[xIndex] != None
;			doneCount+=1
;			jbUtils.DebugNotification("Resetting Dungeon "+doneCount+" of "+dungeonCount,0)
;			jbUtils.DebugTrace("Resetting "+doneCount+" of "+dungeonCount+" Dungeon: "+dlist0[xIndex])
;			resetFromList(dlist0[xIndex] as Cell)
;			FormListClear(dlist0[xIndex],"DisabledLights")
;			dlist0[xIndex] = None
;		endIf
;		xIndex+=1
;	endWhile
;	
;	xIndex = 0
;	while xIndex < 128
;		if dlist1[xIndex] != None
;			doneCount+=1
;			jbUtils.DebugNotification("Resetting Dungeon "+doneCount+" of "+dungeonCount,0)
;			jbUtils.DebugTrace("Resetting "+doneCount+" of "+dungeonCount+" Dungeon: "+dlist1[xIndex])
;			resetFromList(dlist1[xIndex] as Cell)
;			FormListClear(dlist1[xIndex],"DisabledLights")
;			dlist1[xIndex] = None
;		endIf
;		xIndex+=1
;	endWhile
;	
;	xIndex = 0
;	while xIndex < 128
;		if dlist2[xIndex] != None
;			doneCount+=1
;			jbUtils.DebugNotification("Resetting Dungeon "+doneCount+" of "+dungeonCount,0)
;			jbUtils.DebugTrace("Resetting "+doneCount+" of "+dungeonCount+" Dungeon: "+dlist2[xIndex])
;			resetFromList(dlist2[xIndex] as Cell)
;			FormListClear(dlist2[xIndex],"DisabledLights")
;			dlist2[xIndex] = None
;		endIf
;		xIndex+=1
;	endWhile
;	
;	Processing = False
;
;endFunction

;Function resetFromList(cell resetCell)
;
;	Int nLights = FormListCount(resetCell as Form, "DisabledLights")
;	jbUtils.DebugTrace("Found "+nLights+" in cell "+resetCell)
;	nDisLights = 0
;
;	;Register for the callback event
;	RegisterForModEvent("JBMod_DisableLightCallback", "DisableLightCallback")
;	jbUtils.DebugTrace("Doing "+nLights)
;
;	threadManager.loadforRun(Self,resetCell,-1,0,None,3)
;	Int xIndex = 0
;	While Processing && xIndex < nLights
;		threadManager.DisableLightAsync(xIndex)
;		xIndex += 1
;	EndWhile
;	threadManager.wait_all()
;	threadManager.clear_vars()
;	
;	jbUtils.DebugNotification(nDisLights+" Lights Reset")
;	
;	;Check for any to delete
;	if arrayCount(deleteIDList) > 0
;		int numtoDelete = arrayCount(deleteIDList)
;		xIndex = 0
;		while xIndex < numtoDelete
;			(deleteIDList[xIndex] as objectreference).delete()
;			jbUtils.DebugTrace("Deleting "+(deleteIDList[xIndex] as objectreference))
;			xIndex += 1
;		endWhile
;		ArrayClear(deleteIDList)
;	endIf
;	
;EndFunction


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
	lMovStatics.revert()
	lStatics.revert()

	Bool ELFXInstalled = (Game.GetModbyName("EnhancedLightsandFX.esp") < 255)
	
	if ELFXInstalled
		AddELFXForms()

	endIf

endFunction		

Function AddELFXForms()

	lLights.addForm(Game.GetFormFromFile(0x0000F374, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x00023CD5, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000E6E1E, "EnhancedLightsandFX.esp"))
	lLights.addForm(Game.GetFormFromFile(0x000C0A75, "EnhancedLightsandFX.esp"))

	lMovStatics.addForm(Game.GetFormFromFile(0x00088419, "EnhancedLightsandFX.esp"))
	lMovStatics.addForm(Game.GetFormFromFile(0x00088980, "EnhancedLightsandFX.esp"))
	lMovStatics.addForm(Game.GetFormFromFile(0x00088981, "EnhancedLightsandFX.esp"))
	lMovStatics.addForm(Game.GetFormFromFile(0x00088982, "EnhancedLightsandFX.esp"))
	lMovStatics.addForm(Game.GetFormFromFile(0x000036C9, "EnhancedLightsandFX.esp"))
	lMovStatics.addForm(Game.GetFormFromFile(0x000036CA, "EnhancedLightsandFX.esp"))
	lMovStatics.addForm(Game.GetFormFromFile(0x000036CB, "EnhancedLightsandFX.esp"))
	lMovStatics.addForm(Game.GetFormFromFile(0x000036CC, "EnhancedLightsandFX.esp"))
	
	lStatics.addForm(Game.GetFormFromFile(0x000E7915, "EnhancedLightsandFX.esp"))
	lStatics.addForm(Game.GetFormFromFile(0x00110813, "EnhancedLightsandFX.esp"))
	lStatics.addForm(Game.GetFormFromFile(0x0014CF31, "EnhancedLightsandFX.esp"))
	lStatics.addForm(Game.GetFormFromFile(0x0014CF32, "EnhancedLightsandFX.esp"))
	lStatics.addForm(Game.GetFormFromFile(0x00156214, "EnhancedLightsandFX.esp"))

endFunction
	
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
	Game.FadeOutGame(False,True,50, 1.0)
	Game.DisablePlayerControls(True, True,True,True, True,True, True, True)
 
EndFunction

;**************************************
; Fade the game back in after a call to DoFadeOut
;**************************************
Function DoFadeIn()
   Game.FadeOutGame(False,True,0.1, 2.0)
   pFadeToBlack.PopTo(pFadeFromBlack)
   Game.EnablePlayerControls()
EndFunction
;************************************
