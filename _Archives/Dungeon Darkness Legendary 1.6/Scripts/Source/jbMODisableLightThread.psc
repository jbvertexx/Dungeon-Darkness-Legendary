scriptname jbMODisableLightThread extends Quest hidden

import math
;import StorageUtil

;jbMOMainQS property refScript Auto

;Thread variables

Bool GetData = False
Bool SetData = False
jbMOMainQS ReturnVal

bool thread_queued = false
 
;Variables you need to get things done go here 
Int theIndexVal
Int theLocType
Int theLightType
Int result = 0
float theScanDist
Cell theCell
FormList theDisableLightList
FormList theLightsList
FormList theStatsList
FormList theActivatorsList
FormList theAllLightSourceList
FormList theFireLightSourceList
FormList theCandleLightSourceList
FormList theDwemerLightSourceList
FormList theSunLightList
FormList theFogsList
FormList theAmbientsList
FormList theOilLampExtender
FormList theOilLampRope
ObjectReference theLight
Form theLightBase
Form theDeleteForm
ObjectReference newFog
ObjectReference thePRef
Actor theNPC
Keyword ActorTypeNPC
jbMOMainQS theMainQS
jbMOOptions Options
jbMOUtils jbUtils
Form[] theNPCList
Int[] theNPCTypes
Int theNPCCount
Int theClosestNPCType
Activator theTorchActivator
Activator theOilLamp
RemovableTorchSconce01Script theTorchScript
Activator theFireMarker

function loadVars(jbMOMainQS akMainQS, Cell akCell, Int akLocType, Int akLightType, FormList akDisableLightList, int akRunType = 0)
 
    ;Store our passed-in parameters to member variables
	theMainQS = akMainQS
	Options = (theMainQS as Quest) as jbMOOptions
	jbUtils = theMainQS.jbUtils
	theCell = akCell
	theLocType = akLocType
	theLightType = akLightType
	theDisableLightList = akDisableLightList
			jbUtils.DebugTrace("DisableLightList: "+theDisableLightList)
	theSunLightList = theMainQS.lSunLights
	theLightsList = theMainQS.lLights
	theStatsList = theMainQS.lStatics
	theActivatorsList = theMainQS.lActivators
	theAllLightSourceList = theMainQS.lAllLightSources
	theFireLightSourceList = theMainQS.lFireLightSources
	theCandleLightSourceList = theMainQS.lCandleLightSources
	theDwemerLightSourceList = theMainQS.lDwemerLightSources
	theFogsList = theMainQS.lFogsandMists
	theAmbientsList = theMainQS.lAmbients
	theOilLampExtender = theMainQS.lOilLampExtender
	theOilLampRope = theMainQS.lOilLampRope
	ActorTypeNPC = theMainQS.actorTypeNPCKW
	thePRef = theMainQS.playerRef
	theNPCList = themainQS.npcList
	theNPCCount = ArrayCount(theNPCList)
	theNPCTypes = theMainQS.npcTypes
	theScanDist = Options.NPCScanDist
	theTorchActivator = theMainQS.torchActivator
	theOilLamp = theMainQS.oilLamp
	theFireMarker = theMainQS.FireMarker
	if akRuntype == 0
		If akLightType == 31
			GoToState("Lights")
		elseIf akLightType == 36
			GoToState("MoveStatics")
		elseIf akLightType == 24
			GoToState("Activators")
		else
			GoToState("Statics")
		endIf
	elseIf akRunType == 1
		GoToState("CloseByLights")
	elseIf akRunType == 2
		GoToState("ResetDungeon")
	elseIf akRunType == 3
		GoToState("ResetAll")
	endIf
endFunction

;Thread queuing and set-up
function get_async(Int akIndexVal)
 
    ;Let the Thread Manager know that this thread is busy
    thread_queued = true
 
	theIndexVal = akIndexVal
	
endFunction
 
;Allows the Thread Manager to determine if this thread is available
bool function queued()
	return thread_queued
endFunction
 
;For Thread Manager troubleshooting.
bool function force_unlock()
    clear_thread_vars()
    thread_queued = false
    return true
endFunction
 
;The actual set of code we want to multi-thread.

;Default State
Event onDisableLight()
	if thread_queued
		theLight = theCell.GetNthRef(theINdexVal,theLightType)
		theLightBase = theLight.GetBaseObject() as Form
		if theDisableLightList.HasForm(theLightBase) && theLight.isEnabled()
			goDisableLight()
		Else
			jbUtils.DebugTrace(theLight+" Not in list or is not enabled.")
		endIf
        ;OK, we're done - raise event to return results
		RaiseEvent_DisableLightCallback(result, theDeleteForm)

        ;Set all variables back to default
		theIndexVal = 0
		result = 0
		theLight = None
		theLightBase = None
 

		;Make the thread available to the Thread Manager again
		thread_queued = false
	endIf
endEvent

Function goDisableLight()
	;do nothing in default state
endFunction

int Function getNearestLightSourceType(ObjectReference akLightBulb)

;Search for nearest light source - 0=Fire Light, 1=Candle Light, 2=Dwemer Light

	int akLSType
	objectreference akclosestsource
	akclosestsource = Game.FindClosestReferenceOfAnyTypeInListFromRef(theAllLightSourceList,akLightBulb,200)
	jbUtils.DebugTrace("Closes Source to "+akLightBulb+" is "+akclosestsource)
	if akclosestsource == None
		jbUtils.DebugTrace(akLightBulb+" nearest source type Not Found.")
		Return -1
	endIf
	form akbaseform = akclosestsource.GetBaseObject() as Form
	If theFireLightSourceList.HasForm(akbaseform)
		jbUtils.DebugTrace(akLightBulb+" has nearest source type fire.")
		akLSType = 0
	elseIf theCandleLightSourceList.HasForm(akbaseform)
		jbUtils.DebugTrace(akLightBulb+" has nearest source type candle.")
		akLSType = 1
	elseIf theDwemerLightSourceList.HasForm(akbaseform)
		jbUtils.DebugTrace(akLightBulb+" has nearest source type dwemer.")
		akLSType = 2
	else
		jbUtils.DebugTrace(akLightBulb+" nearest source type Not known.")
		akLSType = -1
	endIf

	akclosestsource = None
	akbaseform = None
	Return akLSType
	
endFunction

;State disabling closeby lights
State CloseByLights

Event onDisableLight()
	if thread_queued
		theLight = Game.FindRandomReferenceOfAnyTypeInListFromRef(theDisableLightList , thePRef, 2500)
			jbUtils.DebugTrace("Found light "+theLight+" "+theIndexVal)

		if theLight && theLight.isEnabled()
			if theLightType == 36
				GoToState("MoveStatics")
			elseIf theLightType == 24
				GoToState("Activators")
			else
				GoToState("Statics")
			endIf
			theLightBase = theLight.GetBaseObject() as Form
			goDisableLight()
		endIf
		
		GoToState("CloseByLights")
		
;		if theLight && theLight.isenabled() && !isLightBulbLitNearby()
;			jbUtils.DebugTrace("Disabling light "+theLight+" "+theIndexVal)
;			theLight.disable()
;			int addedat = FormListAdd(theCell as form, "DisabledLights", theLight as form, false)
;			jbUtils.DebugTrace(theLight+" added at #"+addedat+" Test get:"+FormListGet(theCell as Form, "DisabledLights",addedat))
;			result = 1
;		endif

        ;OK, we're done - raise event to return results
		RaiseEvent_DisableLightCallback(result, theDeleteForm)
 
        ;Set all variables back to default
		theIndexVal = 0
		result = 0
		theLight = None
		theLightBase = None
 
        ;Make the thread available to the Thread Manager again
		thread_queued = false
	endIf
endEvent

endState
	
;State Lights
State Lights

Function goDisableLight()

	jbUtils.DebugTrace("Checking Light "+theLight)

	float lightProb = 0
	float theOccupiedProb
;	float start_time = Utility.GetCurrentRealTime()
;	jbUtils.DebugTrace("IndexVal #"+theIndexVal+" for "+theLight+" starting now")
	int theLightSourceType = getNearestLightSourceType(theLight)
	;if static or movestatic not nearby, then disable
	if theLightSourceType < 0
		jbUtils.DebugTrace("Found no object to light near light "+theLight)
		;do nothing - lightProb = 0
		theLight.disable()
;		int addedat = FormListAdd(theCell as form, "DisabledLights", theLight as form, false)
;		jbUtils.DebugTrace(theLight+" added at #"+addedat+" Test get:"+FormListGet(theCell as Form, "DisabledLights",addedat))
		result = 1
	else
;		jbUtils.DebugTrace("IndexVal #"+theIndexVal+" for "+theLight+" Checkpoint 1: "+(Utility.GetCurrentRealTime() - start_time)+" seconds")

		;Calculate probability
		float theUnoccupiedProb = Options.GetUnocProb(theLocType,theLightSourceType)
;		jbUtils.DebugTrace("IndexVal #"+theIndexVal+" for "+theLight+" Checkpoint 2: "+(Utility.GetCurrentRealTime() - start_time)+" seconds")
		if theNPCCount == 0
			jbUtils.DebugTrace("No NPCs, using UnoccupiedProb")
			lightProb = theUnoccupiedProb
		Else
			float closestNPCdist = getDistancetoClosestRefinList(theLight, theNPCList, theNPCCount )
;			jbUtils.DebugTrace("IndexVal #"+theIndexVal+" for "+theLight+" Checkpoint 3: "+(Utility.GetCurrentRealTime() - start_time)+" seconds")
			if closestNPCdist > Options.NPCScanDist
				jbUtils.DebugTrace("Closest NPC to light "+theLight+ " is "+closestNPCdist+".  Using UnoccupiedProb")
				lightProb = theUnoccupiedProb
			Else
;			jbUtils.DebugTrace("IndexVal #"+theIndexVal+" for "+theLight+" Checkpoint 4: "+(Utility.GetCurrentRealTime() - start_time)+" seconds")
				theOccupiedProb = Options.GetActorProb(theClosestNPCType, theLightSourceType)
;			jbUtils.DebugTrace("IndexVal #"+theIndexVal+" for "+theLight+" Checkpoint 5: "+(Utility.GetCurrentRealTime() - start_time)+" seconds")
				if theOccupiedProb > theUnoccupiedProb
					float theExponent = -4.0 * (1.0 - (closestNPCdist / Options.NPCScanDist))
					lightProb=theUnoccupiedProb+((theOccupiedProb - theUnoccupiedProb) * (1-pow(2.718,theExponent)))
					jbUtils.DebugTrace("Closest NPC to light "+theLight+ " is "+closestNPCdist+".  theExponent="+theExponent+"  lightProb="+lightProb)
					jbUtils.DebugTrace(theLight+"Occupied Prob="+theOccupiedProb+" UnoccupiedProb="+theUnoccupiedProb)
				else
					lightProb = theUnoccupiedProb
				endIf
			endIf
		endIf
;		jbUtils.DebugTrace("IndexVal #"+theIndexVal+" for "+theLight+" Checkpoint 6: "+(Utility.GetCurrentRealTime() - start_time)+" seconds")
		
		;Let's roll the die
		float dieRoll = Utility.RandomFloat()
		
		if dieRoll > lightProb
			jbUtils.DebugTrace("Die roll = "+dieRoll+" Light Probability = "+lightProb+" Disabling "+theLight)
			theLight.disable()
;			int addedat = FormListAdd(theCell as form, "DisabledLights", theLight as form, false)
;			jbUtils.DebugTrace(theLight+" added at #"+addedat+" Test get:"+FormListGet(theCell as Form, "DisabledLights",addedat))
			result = 1
;			objectreference nearbyLight
;			nearbyLight = Game.FindClosestReferenceOfAnyTypeInListFromRef(theLightsList,theLight,250)
;			if nearbyLight != None && nearbyLight.isEnabled()
;				jbUtils.DebugTrace("Disabling nearby light "+nearbyLight)
;				nearbyLight.disable()
;				result += 1
;			endIf
;			nearbyLight = None
		else
			jbUtils.DebugTrace("Die roll = "+dieRoll+" Light Probability = "+lightProb+" Not Disabling "+theLight)
		endIf
	endIf
;	float end_time = Utility.GetCurrentRealTime()
;	float time_delta = end_time - start_time
;	jbUtils.DebugTrace("IndexVal #"+theIndexVal+" for "+theLight+" Completed in "+time_delta+" seconds.")

endFunction

endState

;State MoveStatics
State MoveStatics
Function goDisableLight()
	jbUtils.DebugTrace("Checking MovStatic "+theLight)
	if isLightBulbLitNearby()
		jbUtils.DebugTrace("Lit light bulb found near "+theLight)
	elseif theAmbientsList.HasForm(theLightBase) && Game.FindClosestReferenceOfAnyTypeInListFromRef(theSunLightList,theLight,1500) != None
		jbUtils.DebugTrace("Found sunlight "+Game.FindClosestReferenceOfAnyTypeInListFromRef(theSunLightList,theLight,1500)+" near "+theLight)
	else
		jbUtils.DebugTrace("Disabling "+theLight)
		theLight.disable()
;		int addedat = FormListAdd(theCell as form, "DisabledLights", theLight as form, false)
;		jbUtils.DebugTrace(theLight+" added at #"+addedat+" Test get:"+FormListGet(theCell as Form, "DisabledLights",addedat))
		result = 1
		if theFogsList.HasForm(theLightBase)
			newFog = theLight.placeAtMe(theLightBase)
			jbUtils.DebugTrace("Replacing Fog "+theLight+" with "+newFog)
			newFog.SetScale(theLight.getScale())
			newFog.SetAngle(theLight.getAngleX(),theLight.getAngleY(),theLight.getAngleZ())
;			theLight.MoveTo(theLight, afZOffset = -10000)
			newFog = None
		endIf
	endIf
	if Options.enableFireLighter && theFireLightSourceList.HasForm(theLightBase)
		objectreference newMarker = theLight.placeAtMe(theFireMarker)
		jbUtils.DebugTrace("New marker "+newMarker+" placed at "+theLight)
	endIf
	
endFunction
endState

;State Activators
State Activators
Function goDisableLight()
	jbUtils.DebugTrace("Checking Activator "+theLight)
	if isLightBulbLitNearby()
		jbUtils.DebugTrace("Lit light bulb found near "+theLight)
	elseIf theLightBase == theTorchActivator
	;Check for torch activator
		theTorchScript = theLight as RemovableTorchSconce01Script
		jbUtils.DebugTrace("Found torch activator "+theLight)
		jbUtils.DebugTrace("State:  "+theTorchScript.GetState())
		if theTorchScript.GetState() == "HasTorch"
			jbUtils.DebugTrace("Linked Ref: "+theLight.GetLinkedRef())
			jbUtils.DebugTrace("Linked Ref Disabled? "+theLight.GetLinkedRef().isDisabled())
			if theLight.GetLinkedRef() != None && theLight.GetLinkedRef().isDisabled()
				jbUtils.DebugTrace("Enabling "+theLight.GetLinkedRef())
				theLight.EnableLinkChain()
			endIf
			theTorchScript.PlacedTorch.disable()
			theLight.DisableLinkChain()
			theTorchScript.GoToState("NoTorch")
		endIf
	else
		jbUtils.DebugTrace("Disabling "+theLight)
		theLight.disable()
;		int addedat = FormListAdd(theCell as form, "DisabledLights", theLight as form, false)
;		jbUtils.DebugTrace(theLight+" added at #"+addedat+" Test get:"+FormListGet(theCell as Form, "DisabledLights",addedat))
		result = 1
		;Check for Oil Lamp
		If theLightBase == theOilLamp as Form
			jbUtils.DebugTrace("Disabling rope for Oil Lamp "+theLight)
			if Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampRope,theLight,5) != None
				Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampRope,theLight,5).disable()
			endIf
			if Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampExtender,theLight,5) != None
				Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampExtender,theLight,5).disable()
			endIf
		EndIf
	endIf
endFunction
endState

;State Statics
State Statics
Function goDisableLight()
	jbUtils.DebugTrace("Checking Static "+theLight)
	if isLightBulbLitNearby()
		jbUtils.DebugTrace("Lit light bulb found near "+theLight)
	else
		jbUtils.DebugTrace("Disabling "+theLight)
		theLight.disable()
;		int addedat = FormListAdd(theCell as form, "DisabledLights", theLight as form, false)
;		jbUtils.DebugTrace(theLight+" added at #"+addedat+" Test get:"+FormListGet(theCell as Form, "DisabledLights",addedat))
		result = 1
	endIf
endFunction
endState

;State ResetDungeon
State ResetDungeon
Event onDisableLight()
	if thread_queued
		theLight = theCell.GetNthRef(theINdexVal,theLightType)
		theLightBase = theLight.GetBaseObject() as Form
		if theLight.isDisabled() && theLight.getpositionz() > -30000 ;(check ELFX lights that have enable parent tied to player)
			theLight.enable()
			result = 1
			jbUtils.DebugTrace("Enabled "+theLight)
			;Check for Oil Lamp
			If theLightBase == theOilLamp as Form
				jbUtils.DebugTrace("Disabling rope for Oil Lamp "+theLight)
				if Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampRope,theLight,5) != None
					Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampRope,theLight,5).enable()
				endIf
				if Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampExtender,theLight,5) != None
					Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampExtender,theLight,5).enable()
				endIf
			EndIf
			;Check for torch activator
			If theLightBase == theTorchActivator
				theTorchScript = theLight as RemovableTorchSconce01Script
				jbUtils.DebugTrace("Found torch activator "+theLight)
				jbUtils.DebugTrace("State:  "+theTorchScript.GetState())
				if theTorchScript.StartsEmpty
					theTorchScript.PlacedTorch.disable()
					theLight.DisableLinkChain()
					theTorchScript.GoToState("NoTorch")
				else
					theTorchScript.PlacedTorch.enable()
					theLight.EnableLinkChain()
					theTorchScript.GoToState("HasTorch")
				endIf
			endIf
		elseIf theFogsList.HasForm(theLightBase) && theLight.getFormId() >= 4278190080
			jbUtils.DebugTrace("Deleting fog "+theLight)
			theLight.disable()
			theDeleteForm = theLight as Form
		else
			jbUtils.DebugTrace(theLight+" Is already enabled.")
		endIf

        ;OK, we're done - raise event to return results
		RaiseEvent_DisableLightCallback(result, theDeleteForm)

        ;Set all variables back to default
		theIndexVal = 0
		result = 0
		theLight = None
		theLightBase = None

		;Make the thread available to the Thread Manager again
		thread_queued = false

	endIf
endEvent
endState

;State Resetting all lights
State ResetAll

;Event onDisableLight()
;	if thread_queued
;		theLight = FormListGet(theCell as Form, "DisabledLights", theIndexVal) as objectreference
;		jbUtils.DebugTrace("Cell: "+theCell+" Disabling #"+theINdexVal+" Light: "+theLight)
;		GoToState("ResetDungeon")
;		goDisableLight()
;		GoToState("ResetAll")
;		result = 1
;		
;       ;OK, we're done - raise event to return results
;		RaiseEvent_DisableLightCallback(result, theDeleteForm)
;
;		;Set all variables back to default
;		theIndexVal = 0
;		result = 0
;		theLight = None
;		theLightBase = None
;
;        ;Make the thread available to the Thread Manager again
;		thread_queued = false
;	endIf
;endEvent

endState

function clear_thread_vars()
	;Reset all thread variables to default state
;	theIndexVal = 0
	theMainQS = None
	theCell = None
	theLocType = 0
	theLightType = 0
	theDisableLightList = None
	theLightsList = None
	theStatsList = None
	theAllLightSourceList = None
	theFireLightSourceList = None
	theCandleLightSourceList = None
	theDwemerLightSourceList = None
	theActivatorsList = None
	theSunLightList = None
	theFogsList = None
	theAmbientsList = None
	theOilLampExtender = None
	theOilLampRope = None
	result = 0
	theLightType = 0
;	theLight = None
	thePRef = None
	ActorTypeNPC = None
	theTorchActivator = None
	theOilLamp = None
	theClosestNPCType = 0
	theDeleteForm = None
	theNPCCount = 0
	theScanDist = 0
	theFireMarker = None
	theNPCList = new Form[1]
	theNPCTypes = new int[1]
endFunction

;Create the callback
function RaiseEvent_DisableLightCallback(Int akResult, Form akDeleteForm)
    int handle = ModEvent.Create("JBMod_DisableLightCallback")
    if handle
    	ModEvent.PushInt(handle, akResult)
		ModEvent.PushForm(handle, akDeleteForm)
        ModEvent.Send(handle)
    else
        ;pass
    endif
endFunction

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
 
Form[] Function ArrayClear(Form[] myArray)

	int i = 0
	int myCount = 0
	while i < myArray.Length
		myArray[i] = none
		i += 1
	endWhile
 
	return myArray
 
endFunction

float function getDistancebetweenRefs(objectreference akref1, objectreference akref2)

	float xdist = akref1.GetPositionX() - akref2.GetPositionX()
	float ydist = akref1.GetPositionY() - akref2.getpositionY()
	float zdist = akref1.getpositionz() - akref2.getpositionz()
	float distance = sqrt( pow(xdist, 2) + pow(ydist,2) + pow(zdist,2))
	
	return distance
	
EndFunction

float Function getDistancetoClosestRefinList(objectreference aktheref, form[] akreflist, int akrefcount )
	if akrefcount < 1
		return -1
	endIf
	float scanDist = 0.75 * theScanDist
	float distance = 0
	int closestref = 0
	int xCount = 1
	float mindistance = getDistancebetweenRefs(aktheref, akreflist[0] as objectreference)
	if mindistance < scanDist
		xCount = akrefcount
	endIf
	while xCount < akrefcount
		distance = getDistancebetweenRefs(aktheref, akreflist[xCount] as objectreference)
		if distance < mindistance
			mindistance = distance
			closestref = xCount
			if mindistance < scanDist
				xCount = akrefcount
			endIf
		endIf
		xCount += 1
	endWhile
	
	theClosestNPCType = theNPCTypes[closestref]
	jbUtils.DebugTrace("Closest ref to "+aktheref+" is "+akreflist[closestref] as actor+" at "+mindistance+" Type: "+theClosestNPCType)

	return mindistance
	
endFunction

bool Function isRefCloseBy(form aktheref, form[] akreflist, int akrefcount, int akrange )
	if akrefcount < 1
		return false
	endIf
	int distance
	int xCount = 0
	while xCount < akrefcount
		distance = getDistancebetweenRefs(aktheref as objectreference, akreflist[xCount] as objectreference) as int
		if distance <= akrange
			jbUtils.DebugTrace("Found NPC "+akreflist[xCount] as actor+" near light "+aktheref as objectreference)
			return true
		endIf
		xCount += 1
	endWhile
	
;	jbUtils.DebugTrace("Closest ref to "+aktheref+" is "+akreflist[closestref] as actor+" at "+mindistance)
	
	return false
	
endFunction

bool Function isLightBulbLitNearby()
	objectreference nearbyLight
	nearbyLight = Game.FindClosestReferenceOfAnyTypeInListFromRef(theLightsList,theLight,200)
	if nearbyLight == None
		return false
	elseIf nearbyLight.isEnabled()
		jbUtils.DebugTrace(theLight+" Enabled Lightbulb found nearby: "+nearbyLight)
		nearbyLight = None
		return true
	else
		jbUtils.DebugTrace(theLight+" Disabled Lightbulb found nearby: "+nearbyLight)
		nearbyLight = None
		return false
	endIf
endFunction	

