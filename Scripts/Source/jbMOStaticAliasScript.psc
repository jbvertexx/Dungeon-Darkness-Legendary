Scriptname jbMOStaticAliasScript extends ReferenceAlias

Import Math

jbMOMainQS Property theMainQS Auto

ObjectReference theLight
Form theLightBase
ObjectReference theNearbyLightBulb
FormList theLightsList
FormList theCandleLightSourceList
FormList theCandleLightsOffList
FormList theELFXCandleSmokeList
FormList theMarkerList
jbMOUtils jbUtils
jbMOOptions Options
jbMOCandleArraysScript Candles
Form theCandleMarker

Event onInit()

if self.getowningquest().isrunning()

	Bool Result = False
	jbUtils = theMainQS.jbUtils
	if theMainQS.ResetDungeon
		GoToState("Reset")
	endIf

	theLight = self.getRef()

	debug.trace(self+" Activated for Reference: "+theLight)
	if theLight

		Options = theMainQS.Options
		Candles = theMainQS.CandleArrays
		theLightsList = theMainQS.lLights
		theCandleLightSourceList = theMainQS.lCandleLightSources
		theCandleLightsOffList = theMainQS.lCandleLightsOff
		theELFXCandleSmokeList = theMainQS.lELFXCandleSmoke
		theMarkerList = theMainQS.lLightMarkers
		theLightBase = theLight.getBaseObject()

		Result = takeAction()
	endIf

	RaiseEvent_DisableLightAliasCallback(Result)

endIf

endEvent

Bool Function takeAction()

	Bool tookAction = False
	theNearbyLightBulb = Game.FindClosestReferenceOfAnyTypeInListFromRef(theLightsList,theLight,200)
	if theNearbyLightBulb && theNearbyLightBulb.isEnabled()
		jbUtils.DebugTrace("Lit light bulb "+theNearbyLightBulb+" found near "+theLight)
	else
		;Disabling the light
		;First check for ELFX Candle Smoke
		if theCandleLightSourceList.hasForm(theLightBase) && Options.ELFXInstalled && Options.ELFXDisableCandleSmoke
			jbUtils.DebugTrace("Checking ELFX candle smoke for "+theLight)
			ObjectReference theCandleSmoke = Game.FindClosestReferenceOfAnyTypeInList(theELFXCandleSmokeList,theLight.getPositionX(), theLight.getPositionY(),theLight.getPositionZ()+100,50)
			if theCandleSmoke && theCandleSmoke.isEnabled()
				jbUtils.DebugTrace("Disabling ELFX candle smoke "+theCandleSmoke+" near "+theLight)
				theCandleSmoke.disable()
			else
				jbUtils.DebugTrace("No ELFX candle smoke found for "+theLight)
			endIf
		endIf
		;Now disable the light
		theLight.disable()
		jbUtils.DebugTrace("Disabled "+theLight)
		tookAction = True
	endIf
	
	if Options.enableCandleLighter && theNearbyLightBulb

		;Get values for marker placement
		Int CandleIndexVal = theCandleLightSourceList.find(theLightBase)
		theCandleMarker = theMarkerList.getAt(Candles.MarkerSelect[CandleIndexVal])
		Float CandleXOffset = Candles.CandleXOffset[CandleIndexVal]
		Float CandleYOffset = Candles.CandleYOffset[CandleIndexVal]
		Float CandleZOffset = Candles.CandleZOffset[CandleIndexVal]
		Float ZRotation = theLight.getAngleZ()
		Bool noOffset = (CandleXOffset == 0.0 && CandleYOffset == 0.0 && CandleZOffset == 0.0)

		If ZRotation != 0.0
			If CandleXOffset != 0.0
				CandleYOffset = (-1.0)*CandleXOffset*sin(ZRotation)
				CandleXOffset = CandleXOffset*cos(ZRotation)
			ElseIf CandleYOffset != 0.0
				CandleXOffset = CandleYOffset*sin(ZRotation)
				CandleYOffset = CandleYOffset*cos(ZRotation)
			EndIf
		EndIf
		
		objectreference newMarker = theLight.placeAtMe(theCandleMarker)
		newMarker.MoveTo(theLight,CandleXOffset,CandleYOffset,CandleZOffset,noOffset)
		jbUtils.DebugTrace("New marker "+newMarker+" base "+theCandleMarker+" placed at "+theLight+" Offsets: "+CandleXOffset+","+CandleYOffset+","+CandleZOffset)
		jbUtils.DebugTrace("Marker "+newMarker+" position: "+newMarker.getPositionX()+","+newMarker.getPositionY()+","+newMarker.getPositionZ())
		jbUtils.DebugTrace("Light "+theLight+" position: "+theLight.getPositionX()+","+theLight.getPositionY()+","+theLight.getPositionZ())
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

	;First check for ELFX Candle Smoke
	if theCandleLightSourceList.hasForm(theLightBase) && Options.ELFXInstalled
		ObjectReference theCandleSmoke = Game.FindClosestReferenceOfAnyTypeInList(theELFXCandleSmokeList,theLight.getPositionX(), theLight.getPositionY(),theLight.getPositionZ()+100,50)
		if theCandleSmoke && theCandleSmoke.isDisabled()
			jbUtils.DebugTrace("Enabling ELFX candle smoke "+theCandleSmoke+" near "+theLight)
			theCandleSmoke.enable()
		endIf
	endIf

	;Now enable the light
	if !theLight.isEnabled()
		theLight.Enable()
		jbUtils.DebugTrace("Enabled "+theLight)
		Return True
	else
		Return False
	endIf
	
endFunction
endState