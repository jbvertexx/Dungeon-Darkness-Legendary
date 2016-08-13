Scriptname jbMOlightsoffmagicspell extends activemagiceffect  






Event OnEffectStart(Actor akTarget, Actor akCaster)
  
  




; *****************************************************************

;Debug.Notification("Trying to Find Movable Static Source")
 kParentCell = Game.GetPlayer().GetParentCell()
 iFormType = 36
 iLights = kParentCell.GetNumRefs(iFormType)
 i = 0
While(i < iLights)
	ObjectReference kLight = kParentCell.GetNthRef(i, iFormType)
	;Do stuff with the reference here
float  howfar = game.GetPlayer().GetDistance(kLight)
if kLight.IsDisabled() && howfar < 400
klight.Enable()	
i = iLights
EndIf
	i += 1
EndWhile
 ;**************************************************************  
 
 ; Debug.Notification("Trying to Find Light Source")
  Cell kParentCell = Game.GetPlayer().GetParentCell()
 iFormType = 31
iLights = kParentCell.GetNumRefs(iFormType)
 i = 0
While(i < iLights)
	ObjectReference kLight = kParentCell.GetNthRef(i, iFormType)
	;Do stuff with the reference here
float howfar = game.GetPlayer().GetDistance(kLight)
if kLight.IsDisabled() && howfar < 400
klight.Enable()	
i = iLights
EndIf
	i += 1
EndWhile


;*****************************************************************  

;Debug.Notification("Trying to Find Static Sources")
   kParentCell = Game.GetPlayer().GetParentCell()
 iFormType = 34
 iLights = kParentCell.GetNumRefs(iFormType)
 i = 0
While(i < iLights)
	ObjectReference kLight = kParentCell.GetNthRef(i, iFormType)
	;Do stuff with the reference here
float howfar = game.GetPlayer().GetDistance(kLight)
if kLight.IsDisabled() && howfar < 400
klight.Enable()	
i = iLights
EndIf
	i += 1
EndWhile
 
EndEvent


Int iFormType
Int iLights
Int i


; kMovableStatic = 36
;  kStatic = 34