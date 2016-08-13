Scriptname jbMOAmbientsAliasScript extends ReferenceAlias  

jbMOMainQS Property theMainQS Auto

ObjectReference theLight
Form theLightBase
FormList theSunLightList
jbMOUtils jbUtils
jbMOOptions Options

Event onInit()

if self.getowningquest().isrunning()

	Bool Result = False
	Options = theMainQS.Options
	jbUtils = theMainQS.jbUtils

	theLight = self.getRef()

	debug.trace(self+" Activated for Reference: "+theLight)
	if theLight

		theSunLightList = theMainQS.lSunLights
		theLightBase = theLight.GetBaseObject() as Form
		if theMainQS.ResetDungeon
			GoToState("Reset")
		endIf

		Result = takeAction()

	endIf

	RaiseEvent_DisableLightAliasCallback(Result)

endIf

endEvent

Bool Function takeAction()

	bool tookAction = False
	objectreference theSunlight = Game.FindClosestReferenceOfAnyTypeInListFromRef(theSunLightList,theLight,1500)
	if theSunlight
		jbUtils.DebugTrace("Found sunlight "+theSunlight+" near "+theLight)
	else
		jbUtils.DebugTrace("Disabling "+theLight)
		theLight.disable()
		tookAction = True
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

	if theLight.isDisabled()
		theLight.Enable()
		jbUtils.DebugTrace("Enabled "+theLight)
		Return True
	endIf
	
endFunction
endState