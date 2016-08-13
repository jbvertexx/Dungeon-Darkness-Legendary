Scriptname jbMOFogsAliasScript extends ReferenceAlias  

jbMOMainQS Property theMainQS Auto

ObjectReference theLight
Form theLightBase
ObjectReference newFog
ObjectReference FireOutRef
FormList theLightsList
FormList theFogsList
FormList theAmbientsList
FormList theSmokesList
FormList theSunLightList
FormList theFireLightSourceList
FormList theMarkerList
jbMOUtils jbUtils
jbMOOptions Options

Event onInit()

if self.getowningquest().isrunning()

	Bool Result = False
	Options = theMainQS.Options
	jbUtils = theMainQS.jbUtils

	theLight = self.getRef()

	jbUtils.DebugTrace(self+" Activated for Reference: "+theLight)
	if theLight

		theLightsList = theMainQS.lLights
		theFogsList = theMainQS.lFogsandMists
		theAmbientsList = theMainQS.lAmbients
		theSmokesList = theMainQS.lSmokes
		theSunLightList = theMainQS.lSunLights
		theMarkerList = theMainQS.lLightMarkers
		theLightBase = theLight.GetBaseObject() as Form
		theFireLightSourceList = theMainQS.lFireLightSources

		if theMainQS.ResetDungeon
			GoToState("Reset")
		elseif theFogsList.hasForm(theLightBase)
			GoToState("Fogs")
		elseif theAmbientsList.hasForm(theLightBase)
			GoToState("Ambients")
		elseif theSmokesList.hasForm(theLightBase)
			GoToState("Smokes")
		endIf

		Result = takeAction()
		
	endIf

	RaiseEvent_DisableLightAliasCallback(Result)

endIf

endEvent

Bool Function takeAction()
;Defualt state do nothing
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

State Fogs
Bool Function takeAction()

	bool tookAction = True
	newFog = theLight.placeAtMe(theLightBase)
	jbUtils.DebugTrace("Replacing Fog "+theLight+" with "+newFog)
	newFog.SetScale(theLight.getScale())
	newFog.SetAngle(theLight.getAngleX(),theLight.getAngleY(),theLight.getAngleZ())
	theLight.SetPosition(theLight.GetPositionX(),theLight.GetPositionY(),30000)
	newFog.SetActorOwner(Game.GetPlayer().GetActorBase())
	newFog = None

	Return tookAction
	
endFunction
endState

State Smokes
Bool Function takeAction()

	bool tookAction = True
	objectReference theNearbyFireSource = Game.FindClosestReferenceOfAnyTypeInListFromRef(theFireLightSourceList,theLight,500)
	if theNearbyFireSource
		objectReference theFireMarker = Game.FindClosestReferenceOfAnyTypeInListFromRef(theMarkerList,theNearbyFireSource,100)
		if theFireMarker
			(theFireMarker as jbMOSconceFireLighterScript).addSmoke(theLight as Form)
		endIf
		if theNearbyFireSource.isEnabled()
			jbUtils.DebugTrace("Lit fire "+theNearbyFireSource+" found near smoke "+theLight)
			tookAction = False
		endIf
	endIf
	
	if tookAction
		jbUtils.DebugTrace("Disabling "+theLight)
		theLight.disable()
	endIf
	
	Return tookAction
	
endFunction
endState

State Ambients
Bool Function takeAction()

	bool tookAction = False
	
	objectReference theNearbyLightBulb = Game.FindClosestReferenceOfAnyTypeInListFromRef(theLightsList,theLight,200)
	if theNearbyLightBulb && theNearbyLightBulb.isEnabled()
		jbUtils.DebugTrace("Lit light bulb "+theNearbyLightBulb+" found near "+theLight)
	else
		objectreference theSunlight = Game.FindClosestReferenceOfAnyTypeInListFromRef(theSunLightList,theLight,1500)
		if theSunlight
			jbUtils.DebugTrace("Found sunlight "+theSunlight+" near "+theLight)
		else
			jbUtils.DebugTrace("Disabling "+theLight)
			theLight.disable()
			tookAction = True
		endIf
	endIf
	
	Return tookAction
	
endFunction
endState

State Reset
Bool Function takeAction()

	if theLight.getFormId() >= 4278190080
		jbUtils.DebugTrace("Deleting fog "+theLight)
		theLight.Disable()
		theLight.Delete()
	else
		jbUtils.DebugTrace("Resetting: "+theLight)
		theLight.Reset()
		theLight.Enable()
		jbUtils.DebugTrace(theLight+" Position: "+theLight.GetPositionX()+":"+theLight.GetPositionY()+":"+theLight.GetPositionZ())
	endIf

	Return True
	
endFunction

endState