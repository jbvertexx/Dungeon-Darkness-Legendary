Scriptname jbMOLightAliasScript extends ReferenceAlias  

Import Math

jbMOMainQS Property theMainQS Auto

ObjectReference theLight
ObjectReference theNearbyLightBulb
FormList theLightsList
jbMOUtils jbUtils
jbMOOptions Options
Form[] theNPCList
Int[] theNPCTypes
Int theNPCCount
Int theClosestNPCType
Int theLocType
Float theScanDist
FormList theAllLightSourceList
FormList theFireLightSourceList
FormList theCandleLightSourceList
FormList theDwemerLightSourceList

Event onInit()

if self.getowningquest().isrunning()


	Bool Result = false

	if theMainQS.ResetDungeon
		GoToState("Reset")
	endIf

	theLight = self.getRef()
	debug.trace(self+" Activated for Reference: "+theLight)

	if theLight

		jbUtils = theMainQS.jbUtils
		Options = theMainQS.Options
		theScanDist = Options.NPCScanDist
		theLightsList = theMainQS.lLights
		theNPCList = theMainQS.npcList
		theNPCTypes = theMainQS.npcTypes
		theNPCCount = theMainQS.npcCount
		theLocType = theMainQS.CurrentLocType
		theAllLightSourceList = theMainQS.lAllLightSources
		theFireLightSourceList = theMainQS.lFireLightSources
		theCandleLightSourceList = theMainQS.lCandleLightSources
		theDwemerLightSourceList = theMainQS.lDwemerLightSources

		Result = takeAction()
		trytoclear()

	endIf

	RaiseEvent_DisableLightAliasCallback(Result)

endIf

endEvent

;Create the callback
function RaiseEvent_DisableLightAliasCallback(Bool akResult)
    int handle = ModEvent.Create("JBMod_DisableLightAliasCallback")
    if handle
    	ModEvent.PushBool(handle, akResult)
        ModEvent.Send(handle)
    else
        ;pass
    endif
endFunction


Bool Function takeAction()

	Bool wasDisabled = False
	jbUtils.DebugTrace("Checking Light "+theLight)

	float lightProb = 0
	float theOccupiedProb
	int theLightSourceType = getNearestLightSourceType(theLight)
	;if static or movestatic not nearby, then disable
	if theLightSourceType < 0
		jbUtils.DebugTrace("Found no object to light near light "+theLight)
		;do nothing - lightProb = 0
		theLight.disable()
		wasDisabled = true
	else

		;Calculate probability
		float theUnoccupiedProb = Options.GetUnocProb(theLocType,theLightSourceType)
		if theNPCCount == 0
			jbUtils.DebugTrace("No NPCs, using UnoccupiedProb")
			lightProb = theUnoccupiedProb
		Else
			float closestNPCdist = getDistancetoClosestNPC()
			if closestNPCdist > Options.NPCScanDist
				jbUtils.DebugTrace("Closest NPC to light "+theLight+ " is "+closestNPCdist+".  Using UnoccupiedProb")
				lightProb = theUnoccupiedProb
			Else
				theOccupiedProb = Options.GetActorProb(theClosestNPCType, theLightSourceType)
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
		
		;Let's roll the die
		float dieRoll = Utility.RandomFloat()
		
		if dieRoll > lightProb
			jbUtils.DebugTrace("Die roll = "+dieRoll+" Light Probability = "+lightProb+" Disabling "+theLight)
			theLight.disable()
			wasDisabled = true
		else
			jbUtils.DebugTrace("Die roll = "+dieRoll+" Light Probability = "+lightProb+" Not Disabling "+theLight)
		endIf
	endIf

	Return wasDisabled
	
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

float function getDistancebetweenRefs(objectreference akref1, objectreference akref2)

	float xdist = akref1.GetPositionX() - akref2.GetPositionX()
	float ydist = akref1.GetPositionY() - akref2.getpositionY()
	float zdist = akref1.getpositionz() - akref2.getpositionz()
	float distance = sqrt( pow(xdist, 2) + pow(ydist,2) + pow(zdist,2))
	
	return distance
	
EndFunction

float Function getDistancetoClosestNPC()
	if theNPCCount < 1
		return -1
	endIf
	float scanDist = 0.75 * theScanDist
	float distance = 0
	int closestref = 0
	int xCount = 1
	float mindistance = getDistancebetweenRefs(theLight, theNPCList[0] as objectreference)
	if mindistance < scanDist
		xCount = theNPCCount
	endIf
	while xCount < theNPCCount
		distance = getDistancebetweenRefs(theLight, theNPCList[xCount] as objectreference)
		if distance < mindistance
			mindistance = distance
			closestref = xCount
			if mindistance < scanDist
				xCount = theNPCCount
			endIf
		endIf
		xCount += 1
	endWhile
	
	theClosestNPCType = theNPCTypes[closestref]
	jbUtils.DebugTrace("Closest ref to "+theLight+" is "+theNPCList[closestref] as actor+" at "+mindistance+" Type: "+theClosestNPCType)

	return mindistance
	
endFunction

State Reset
Bool Function takeAction()

	if !theLight.isEnabled()
		theLight.Enable()
		jbUtils.DebugTrace("Enabled "+theLight)
		Return True
	else
		Return False
	endIf
	
endFunction
endState