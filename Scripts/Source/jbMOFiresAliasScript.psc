Scriptname jbMOFiresAliasScript extends ReferenceAlias  
jbMOMainQS Property theMainQS Auto

ObjectReference theLight
Form theLightBase
ObjectReference theNearbyLightBulb
FormList theLightsList
FormList theMarkerList
FormList theFireLightSourceList
FormList theFireLightsOffList
jbMOUtils jbUtils
jbMOOptions Options
Activator theFireMarker

Event onInit()

if self.getowningquest().isrunning()

	Bool Result = False
	Options = theMainQS.Options
	jbUtils = theMainQS.jbUtils

	theLight = self.getRef()
	debug.trace(self+" Activated for Reference: "+theLight)

	if theLight

		theLightsList = theMainQS.lLights
		theMarkerList = theMainQS.lLightMarkers
		theFireMarker = theMainQS.FireMarker
		theFireLightSourceList = theMainQS.lFireLightSources
		theFireLightsOffList = theMainQS.lFireLightsOff
		if theMainQS.ResetDungeon
			GoToState("Reset")
		endIf

		theLightBase = theLight.GetBaseObject() as Form

		Result = takeAction()

	endIf

	RaiseEvent_DisableLightAliasCallback(Result)

endIf

endEvent

Bool Function takeAction()

	bool tookAction = False
	theNearbyLightBulb = Game.FindClosestReferenceOfAnyTypeInListFromRef(theLightsList,theLight,200)
	if theNearbyLightBulb && theNearbyLightBulb.isEnabled()
		jbUtils.DebugTrace("Lit light bulb "+theNearbyLightBulb+" found near "+theLight)
	elseIf !theNearbyLightBulb
		jbUtils.DebugTrace("No lightbulb found near "+theLight+" - Disabling")
		theLight.disable()
		tookAction = True
	else
		jbUtils.DebugTrace("Unlit light bulb "+theNearbyLightBulb+" found near "+theLight+" - Disabling")
		theLight.disable()
		tookAction = True
	endIf
	
	if Options.enableFireLighter && theNearbyLightBulb && !Game.FindClosestReferenceOfAnyTypeInListFromRef(theMarkerList, theLight, 100)
	
	
		objectreference newMarker = theLight.placeAtMe(theFireMarker)
		jbUtils.DebugTrace("New marker "+newMarker+" placed at "+theLight)
		(newMarker as jbMOCandleLighterScript).setRefs(theLight,theNearbyLightBulb)
	endIf

	Return tookAction
	
endFunction

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

State Reset
Bool Function takeAction()

	bool tookAction = False
	if theLight.isDisabled()
		theLight.Enable()
		jbUtils.DebugTrace("Enabled "+theLight)
		tookAction = True
	endIf

	objectreference theMarker = Game.FindClosestReferenceOfAnyTypeInListFromRef(theMarkerList, theLight, 100)
	if theMarker
		jbUtils.DebugTrace("Terminating Marker "+theMarker)
		(theMarker as jbMOSconceFireLighterScript).TerminateMarker()
		tookAction = True
	endIf
	
	Return tookAction

endFunction

endState