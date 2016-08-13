Scriptname jbMOChainPullScript extends ObjectReference  

ObjectReference Property enableFXRef  Auto  

Auto STATE Waiting
	EVENT onActivate (objectReference triggerRef)
		if enableFXRef.isenabled()
			enableFXRef.disable()
		Else
			enableFXRef.enable()
		endif
	endEVENT
endState
