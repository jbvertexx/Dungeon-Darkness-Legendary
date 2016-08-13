scriptname jbMOScanNPCThread extends Quest hidden

import math

;jbMOMainQS property refScript Auto

;Thread variables

Bool GetData = False
Bool SetData = False
jbMOMainQS ReturnVal

bool thread_queued = false
 
;Variables you need to get things done go here 
Int theIndexVal
Int theActorType
Cell theCell
ObjectReference thePRef
Actor theActor
Keyword ActorTypeNPC
jbMOMainQS theMainQS
jbMOOptions Options
jbMOUtils jbUtils

Formlist theActorExclusions
FormList theDraugrRaceList
Keyword theDwarvenKW
Race theFalmerRace
Race theHargravanRace
FormList theRieklingRaceList 
Keyword theVampireKW
Keyword theactorTypeGhostKW

function loadVars(jbMOMainQS akMainQS, Cell akCell)
 
    ;Store our passed-in parameters to member variables
	theMainQS = akMainQS
	Options = (theMainQS as Quest) as jbMOOptions
	jbUtils = theMainQS.jbUtils
	theCell = akCell
	ActorTypeNPC = theMainQS.actorTypeNPCKW
	thePRef = theMainQS.playerRef
	theActorExclusions = theMainQS.lNPCExclusions
	theDraugrRaceList = theMainQS.DraugrRaceList
	theDwarvenKW = theMainQS.DwarvenKW
	theFalmerRace = theMainQS.FalmerRace
	theHargravanRace = theMainQS.HargravanRace
	theRieklingRaceList = theMainQS.RieklingRaceList
	theVampireKW = theMainQS.VampireKW
	theactorTypeGhostKW = theMainQS.actorTypeGhostKW
	
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
Event onScanNPCs()
	if thread_queued
		bool addActortoList = false
		theActor = theCell.GetNthRef(theIndexVal, 43) as Actor
		if theActor
			jbUtils.DebugTrace("Actor "+theIndexVal+": "+theActor+" Race: "+theActor.GetRace())
			;evaluate actor type
			theActorType = getActorType(theActor)
			if theActorType >= 0 && Options.GetMaxProbforActor(theActorType) > 0 && getDistancebetweenRefs(theActor as ObjectReference,thePRef) > 400 && !theActorExclusions.hasForm(theActor as Form)
				addActortoList = true
			Endif
			RaiseEvent_ScanNPCCallback(theActor, theActorType, addActortoList)
		endIf
        ;Set all variables back to default
		theIndexVal = 0
		theActor = None
		theActorType = 0
 
        ;Make the thread available to the Thread Manager again
		thread_queued = false

	endIf
endEvent

int Function getActorType(Actor akActor)

	race theActorRace = akActor.getRace()
	if akActor as Form == thePRef as Form
		jbUtils.DebugTrace(akActor+" is Player.")
		return -1
	elseif akActor.isDead()
		jbUtils.DebugTrace(akActor+" is Dead.")
		return -1
	elseif theDraugrRaceList.hasForm(theActorRace as Form)
		jbUtils.DebugTrace(akActor+" is type 1")
		Return 1
	elseif akActor.HasKeyword(theDwarvenKW)
		jbUtils.DebugTrace(akActor+" is type 2")
		Return 2
	elseif theActorRace == theFalmerRace
		jbUtils.DebugTrace(akActor+" is type 3")
		Return 3 
	elseif theActorRace == theHargravanRace
		jbUtils.DebugTrace(akActor+" is type 4")
		Return 4 
	elseif theRieklingRaceList.hasForm(theActorRace as Form)
		jbUtils.DebugTrace(akActor+" is type 5")
		Return 5 
	elseif akActor.HasKeyword(theVampireKW)
		jbUtils.DebugTrace(akActor+" is type 6")
		Return 6
	elseif akActor.HasKeyword(ActorTypeNPC) && !akActor.HasKeyword(theactorTypeGhostKW)
		jbUtils.DebugTrace(akActor+" is type 0")
		Return 0
	else
		jbUtils.DebugTrace(akActor+" is type -1")
		Return -1
	endIf
endFunction

function clear_thread_vars()
	;Reset all thread variables to default state
	theMainQS = None
	theCell = None
	thePRef = None
	theDraugrRaceList = None
	theDwarvenKW = None
	theFalmerRace = None
	theHargravanRace = None
	theRieklingRaceList = None
	theVampireKW = None
	theactorTypeGhostKW = None
	
endFunction

;Create the callback
function RaiseEvent_ScanNPCCallback(Form akNPCForm, Int akNPCType, bool akAddActor)
    int handle = ModEvent.Create("JBMod_ScanNPCCallback")
    if handle
		ModEvent.PushForm(handle, akNPCForm)
    	ModEvent.PushInt(handle, akNPCType)
		ModEvent.PushBool(handle, akAddActor)
        ModEvent.Send(handle)
    else
        ;pass
    endif
endFunction

float function getDistancebetweenRefs(objectreference akref1, objectreference akref2)
	
	float distance
	distance = sqrt( pow(akref1.GetPositionX() - akref2.GetPositionX(), 2) + pow(akref1.GetPositionY() - akref2.getpositionY(),2) + pow(akref1.getpositionz() - akref2.getpositionz(),2))
	
	return distance
	
EndFunction


