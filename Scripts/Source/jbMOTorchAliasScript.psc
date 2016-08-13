Scriptname jbMOTorchAliasScript   extends ReferenceAlias

jbMOMainQS Property theMainQS Auto

ObjectReference theLight
ObjectReference theNearbyLightBulb
FormList theLightsList
jbMOUtils jbUtils
jbMOOptions Options
RemovableTorchSconce01Script theTorchScript

Event onInit()

if self.getowningquest().isrunning()

	Bool Result = False
	Options = theMainQS.Options
	jbUtils = theMainQS.jbUtils

	theLight = self.getRef()
	debug.trace(self+" Activated for Reference: "+theLight)

	if theLight

		theLightsList = theMainQS.lLights
		theTorchScript = theLight as RemovableTorchSconce01Script
		if theMainQS.ResetDungeon
			GoToState("Reset")
		endIf

		Result = takeAction()

	endIf

	RaiseEvent_DisableLightAliasCallback(Result)

endIf

endEvent

Bool Function takeAction()

	jbUtils.DebugTrace("Found torch activator "+theLight)
	jbUtils.DebugTrace(theLight+" State:  "+theTorchScript.GetState())

	bool tookAction = False

	theNearbyLightBulb = Game.FindClosestReferenceOfAnyTypeInListFromRef(theLightsList,theLight,200)
	if theNearbyLightBulb && theNearbyLightBulb.isEnabled()
		jbUtils.DebugTrace("Lit light bulb "+theNearbyLightBulb+" found near "+theLight)
	else
		if theTorchScript.GetState() == "HasTorch"
			jbUtils.DebugTrace(theLight+" Linked Ref: "+theLight.GetLinkedRef())
			jbUtils.DebugTrace(theLight+" Linked Ref Disabled? "+theLight.GetLinkedRef().isDisabled())
			if theLight.GetLinkedRef() != None && theLight.GetLinkedRef().isDisabled()
				jbUtils.DebugTrace("Enabling "+theLight.GetLinkedRef())
				theLight.EnableLinkChain()
			endIf
			theTorchScript.PlacedTorch.disable()
			theLight.DisableLinkChain()
			theTorchScript.GoToState("NoTorch")

			tookAction = True

		endIf
	endIf

	return tookAction
	
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
	
	Return True

endFunction

endState