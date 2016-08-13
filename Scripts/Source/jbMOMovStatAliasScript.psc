Scriptname jbMOMovStatAliasScript extends ReferenceAlias  

jbMOMainQS Property theMainQS Auto

ObjectReference theLight
Form theLightBase
ObjectReference theNearbyLightBulb
ObjectReference newFog
ObjectReference FireOutRef
FormList theLightsList
FormList theFogsList
FormList theMoveStatsList
FormList theMoveStatsOffList
FormList theMarkerList
FormList theFireLightSourceList
FormList theAmbientsList
FormList theSunLightList
jbMOUtils jbUtils
jbMOOptions Options
Activator theFireMarker

Event onInit()

Bool Result = False
Options = theMainQS.Options
jbUtils = theMainQS.jbUtils

theLight = self.getRef()

debug.trace(self+" Activated for Reference: "+theLight)
if theLight

	theLightsList = theMainQS.lLights
	theFogsList = theMainQS.lFogsandMists
	theMoveStatsList = theMainQS.lMovStatics
	theMoveStatsOffList = theMainQS.lMovStatsOff
	theMarkerList = theMainQS.lLightMarkers
	theFireMarker = theMainQS.FireMarker
	theFireLightSourceList = theMainQS.lFireLightSources
	theAmbientsList = theMainQS.lAmbients
	theSunLightList = theMainQS.lSunLights
	if theMainQS.ResetDungeon
		GoToState("Reset")
	endIf

	theLightBase = theLight.GetBaseObject() as Form

	Result = takeAction()
	

endIf

RaiseEvent_DisableLightAliasCallback(Result)

endEvent

Bool Function takeAction()

	bool tookAction = False
	theNearbyLightBulb = Game.FindClosestReferenceOfAnyTypeInListFromRef(theLightsList,theLight,200)
	if theNearbyLightBulb && theNearbyLightBulb.isEnabled()
		jbUtils.DebugTrace("Lit light bulb "+theNearbyLightBulb+" found near "+theLight)
	elseif theAmbientsList.HasForm(theLightBase) && Game.FindClosestReferenceOfAnyTypeInListFromRef(theSunLightList,theLight,1500) != None
		jbUtils.DebugTrace("Found sunlight "+Game.FindClosestReferenceOfAnyTypeInListFromRef(theSunLightList,theLight,1500)+" near "+theLight)
	else
		jbUtils.DebugTrace("Disabling "+theLight)
		theLight.disable()
		tookAction = True
		if theFogsList.HasForm(theLightBase)
			newFog = theLight.placeAtMe(theLightBase)
			jbUtils.DebugTrace("Replacing Fog "+theLight+" with "+newFog)
			newFog.SetScale(theLight.getScale())
			newFog.SetAngle(theLight.getAngleX(),theLight.getAngleY(),theLight.getAngleZ())
			theLight.SetPosition(theLight.GetPositionX(),theLight.GetPositionY(),30000)
			newFog = None
		elseIf theNearbyLightBulb
			Form FireOutForm = getFireOutForm(theLightBase)
			if FireOutForm
				FireOutRef = theLight.placeAtMe(FireOutForm)
				jbUtils.DebugTrace("Replacing Fire "+theLight+" with Fireout "+FireOutRef)
				FireOutRef.SetScale(theLight.getScale())
				FireOutRef.SetAngle(theLight.getAngleX(),theLight.getAngleY(),theLight.getAngleZ())
			endIf
		endIf
	endIf
	if Options.enableFireLighter && theFireLightSourceList.HasForm(theLightBase) && !Game.FindClosestReferenceOfAnyTypeInListFromRef(theMarkerList, theLight, 100)
		objectreference newMarker = theLight.placeAtMe(theFireMarker)
		jbUtils.DebugTrace("New marker "+newMarker+" placed at "+theLight)
		(newMarker as jbMOSconceFireLighterScript).setRefs(theLight,FireOutRef,theNearbyLightBulb)
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

Form Function getFireOutForm(Form akFireLit)

	int LitIndex
	int UnlitIndex = -1
	Form ReturnForm
	
	LitIndex = theMoveStatsList.Find(akFireLit)
	jbUtils.DebugTrace("Getting Unlit Object for "+akFireLit+" - LitIndex = "+LitIndex)

	if LitIndex < 2 || LitIndex > 14
		Return None
	elseIf LitIndex <= 6
		UnlitIndex = 0
	elseIf LitIndex == 7
		UnlitIndex = 1
	elseIf LitIndex == 8
		UnlitIndex = 2
	elseIf LitIndex == 9
		UnlitIndex = 3
	elseIf LitIndex <= 11
		UnlitIndex = 4
	elseIf LitIndex <= 13
		UnlitIndex = 5
	elseIf LitIndex == 14
		UnlitIndex = 6
	endIf
	
	ReturnForm = theMoveStatsOffList.GetAt(UnlitIndex)
	jbUtils.DebugTrace("getFireOutForm Returning: "+ReturnForm)
	Return ReturnForm
	
endFunction

State Reset
Bool Function takeAction()

	if theLight.isDisabled() && theLight.getpositionz() > -30000 ;(check ELFX lights that have enable parent tied to player)
		theLight.Enable()
		jbUtils.DebugTrace("Enabled "+theLight)
		Return True
	endIf
	
endFunction

endState