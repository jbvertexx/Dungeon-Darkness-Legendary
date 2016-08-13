Scriptname jbMOlightitmagicspell extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
  
; *****************************************************************
objectreference pPlayer = game.getplayer()
;Debug.Notification("Trying to Find Movable Static Source")

	ObjectReference kFire = game.FindClosestReferenceOfAnyTypeInListFromRef(firelist,pPlayer,400.0)
	;Do stuff with the reference here
if kFire && kFire.IsDisabled()
	kFire.Enable()	
	lightFound = true
EndIf


;*****************************************************************  

;Debug.Notification("Trying to Find Static Sources")
;   kParentCell = Game.GetPlayer().GetParentCell()
; iFormType = 34
; iLights = kParentCell.GetNumRefs(iFormType)
; i = 0
;While(i < iLights)
;	ObjectReference kLight = kParentCell.GetNthRef(i, iFormType)
;	;Do stuff with the reference here
;float howfar = game.GetPlayer().GetDistance(kLight)
;if kLight.IsDisabled() && howfar < 400
;klight.Enable()	
;i = iLights
;lightFound = true
;EndIf
;	i += 1
;EndWhile 

;**************************************************************  
 
if lightFound 
; Debug.Notification("Trying to Find Light Source")
	
	ObjectReference kLight = game.FindClosestReferenceOfAnyTypeInListFromRef(lightlist,kFire,400.0)
	;Do stuff with the reference here
	if kLight
		klight.Enable()	
	endIf

endif

 
EndEvent



bool lightFound = false
formlist property firelist auto
formlist property lightlist auto


; kMovableStatic = 36
;  kStatic = 34