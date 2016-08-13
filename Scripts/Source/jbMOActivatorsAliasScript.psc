Scriptname jbMOActivatorsAliasScript extends ReferenceAlias  

jbMOMainQS Property theMainQS Auto

ObjectReference theLight
Form theLightBase
ObjectReference theNearbyLightBulb
FormList theLightsList
jbMOUtils jbUtils
jbMOOptions Options
Activator theOilLamp
RemovableTorchSconce01Script theTorchScript
FormList theOilLampExtender
FormList theOilLampRope

Event onInit()

if self.getowningquest().isrunning()

	Bool Result = False
	Options = theMainQS.Options
	jbUtils = theMainQS.jbUtils
	if theMainQS.ResetDungeon
		GoToState("Reset")
	endIf

	theLight = self.getRef()

	debug.trace(self+" Activated for Reference: "+theLight)
	if theLight

		theLightsList = theMainQS.lLights
		theOilLamp = theMainQS.oilLamp
		theOilLampExtender = theMainQS.lOilLampExtender
		theOilLampRope = theMainQS.lOilLampRope

		Result = takeAction()

	endIf

	RaiseEvent_DisableLightAliasCallback(Result)

endIf

endEvent

Bool Function takeAction()

	bool tookAction = True
	
	theLightBase = theLight.GetBaseObject() as Form
	theNearbyLightBulb = Game.FindClosestReferenceOfAnyTypeInListFromRef(theLightsList,theLight,200)
	if theNearbyLightBulb && theNearbyLightBulb.isEnabled()
		jbUtils.DebugTrace("Lit light bulb "+theNearbyLightBulb+" found near "+theLight)
		tookAction = False
	else
		jbUtils.DebugTrace("Disabling "+theLight)
		theLight.disable()
;		int addedat = FormListAdd(theCell as form, "DisabledLights", theLight as form, false)
;		jbUtils.DebugTrace(theLight+" added at #"+addedat+" Test get:"+FormListGet(theCell as Form, "DisabledLights",addedat))
		tookAction = True
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

	if !theLight.isEnabled()
		theLight.Enable()
		jbUtils.DebugTrace("Enabled "+theLight)
		if Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampRope,theLight,5) != None
			jbUtils.DebugTrace("Enabling rope for Oil Lamp "+theLight)
			Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampRope,theLight,5).enable()
		endIf
		if Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampExtender,theLight,5) != None
			Game.FindClosestReferenceOfAnyTypeInListFromRef(theOilLampExtender,theLight,5).enable()
		endIf
		Return True
	else
		Return False
	endIf
	
endFunction
endState