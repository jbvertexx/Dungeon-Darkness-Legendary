Scriptname jbMOSconceFireLighterScript extends ObjectReference  

jbMOMainQS property MainQS auto
Keyword Property MagicDamageFire auto
Keyword Property MagicDamageFrost auto
Light Property Torch01 auto

formlist firelist
formlist lightlist
jbMOUtils jbUtils
objectreference pPlayer
bool processing = false

Event onInit()

	lightlist = MainQS.llights
	firelist = MainQS.lFireLightSources
	jbUtils = MainQS.jbUtils
	pPlayer = game.getplayer()
	jbUtils.DebugTrace(self+" Firelighter Initialized")
	ObjectReference kFire = game.FindClosestReferenceOfAnyTypeInListFromRef(firelist,self,100.0)
	if kFire
		if kFire.isEnabled()
			gotoState("FireLit")
		else
			gotoState("FireOut")
		endIf
	else
		self.disable()
		self.delete()
	endIf
endEvent

Event onCellattach()

	jbUtils.DebugTrace(self+" Firelighter Loaded")
	lightlist = MainQS.llights
	firelist = MainQS.lFireLightSources

endEvent	

State FireOut

Event onBeginState()

	self.SetDisplayName("Light Fire")
	
endEvent

Event onActivate(objectreference theActivator)
	if !processing
		processing = true
	
		jbUtils.DebugTrace(self+" Firelighter Activated")
		if theActivator == pPlayer
			if (theActivator as Actor).getEquippedItemType(0) == 11
				LightFire()
			else
				debug.Notification("Equip torch to light")
			endIf
		endIf
		processing = false
	endIf
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)

	if !processing
		processing = true
		jbUtils.DebugTrace(self+" Firelighter Hit by: "+akSource+" Bashattack: "+abBashAttack)
		If(akSource As Spell)
			Spell sourceSpell = akSource As Spell
			int numEffects = sourceSpell.GetNumEffects()
			int index=0

			while(index < numEffects)
				MagicEffect nthMagicEffect = sourceSpell.GetNthEffectMagicEffect(index)
				If(nthMagicEffect.HasKeyword(MagicDamageFire))
					jbUtils.DebugTrace(self+" hit with fire spell")
					LightFire()
					index=numEffects
				Else
					index+=1
				EndIf
			endWhile
		EndIf
		processing = false
	endIf
endEvent

endState

State FireLit

Event onBeginState()

	self.SetDisplayName("Extinguish Fire")
	
endEvent

Event onActivate(objectreference theActivator)

	if !processing
		processing = true
	
		jbUtils.DebugTrace(self+" Firelighter Activated")
		if theActivator == pPlayer
			PutOutFire()
		endIf
		processing = false
	endIf
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)

	if !processing
		processing = true
		jbUtils.DebugTrace(self+" Firelighter Hit by: "+akSource+" Bashattack: "+abBashAttack)
		If(akSource As Spell)
			Spell sourceSpell = akSource As Spell
			int numEffects = sourceSpell.GetNumEffects()
			int index=0

			while(index < numEffects)
				MagicEffect nthMagicEffect = sourceSpell.GetNthEffectMagicEffect(index)
				If(nthMagicEffect.HasKeyword(MagicDamageFrost))
					jbUtils.DebugTrace(self+" hit with frost spell")
					PutOutFire()
					index=numEffects
				Else
					index+=1
				EndIf
			endWhile
		EndIf
		processing = false
	endIf

endEvent

endState

State Busy

Event onActivate(objectreference theActivator)

	jbUtils.DebugTrace(self+" Firelighter Activated")

endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)

	jbUtils.DebugTrace(self+" Firelighter Hit")

endEvent

endState

Function LightFire()

ObjectReference kFire = game.FindClosestReferenceOfAnyTypeInListFromRef(firelist,self,100.0)

if kFire
	kFire.Enable()	
	ObjectReference kLight = game.FindClosestReferenceOfAnyTypeInListFromRef(lightlist,kFire,400.0)
	if kLight
		klight.Enable()	
	endIf
	gotoState("FireLit")
endif

endFunction

Function PutOutFire()

ObjectReference kFire = game.FindClosestReferenceOfAnyTypeInListFromRef(firelist,self,100.0)

if kFire
	kFire.Disable()	
	ObjectReference kLight = game.FindClosestReferenceOfAnyTypeInListFromRef(lightlist,kFire,400.0)
	if kLight
		klight.Disable()	
	endIf
	gotoState("FireOut")
endif

endFunction
	