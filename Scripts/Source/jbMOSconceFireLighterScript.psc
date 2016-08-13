Scriptname jbMOSconceFireLighterScript extends ObjectReference  

jbMOMainQS property MainQS auto
Keyword Property MagicDamageFire auto
Keyword Property MagicDamageFrost auto

formlist firelist
formlist lightlist

jbMOUtils jbUtils
objectreference pPlayer
bool processing = false
objectreference selfRef
ObjectReference kFire
ObjectReference kFireOut
ObjectReference kLight

Form[] mySmokelist

Event onInit()
	selfRef = self as ObjectReference
	jbUtils = MainQS.jbUtils
	mySmokelist = new Form[8]
	jbUtils.DebugTrace(self+" Firelighter Initialized")
endEvent

Event onCellattach()

	jbUtils.DebugTrace(self+" Firelighter Loaded")
	lightlist = MainQS.llights
	firelist = MainQS.lFireLightSources

endEvent	

Function setRefs(objectreference akFireRef, objectreference akLightRef)

	kFire = akFireRef
	kLight = akLightRef

	lightlist = MainQS.llights
	firelist = MainQS.lFireLightSources
	jbUtils = MainQS.jbUtils
	pPlayer = game.getplayer()

	if kFire
		if kLight.isEnabled()
			gotoState("FireLit")
		else
			kFire.disable()
			if !kFireOut
				kFireOut = placeFireOut()
			endIf
			gotoState("FireOut")
		endIf
	else
		self.disable()
		self.delete()
	endIf

endFunction

Function addSmoke(Form smokeForm)
	if smokeForm
		jbUtils.ArrayAddForm(mySmokelist,smokeForm)
		jbUtils.DebugTrace(self+" Added Smoke "+smokeForm)
	endIf
endFunction

;State FireEmpty

;Event onBeginState()

;	self.SetDisplayName("Add Fuel")
	
;endEvent

;Event onActivate(objectreference theActivator)
;	if !processing
;		processing = true
;;		kFire.delete()
;;		kFire.moveto(self,0,0,10000)
;;		selfRef.moveto(kFire)
;		jbUtils.DebugTrace(self+" Firelighter Activated")
;		if theActivator == pPlayer
;			selfRef.disable()
;			int xIndex = 0
;			while xIndex < 6
;				objectreference theFuel = selfRef.placeatme(pRuinedBook,1,true,true)
;;				theFuel.moveto(self,0,0,50)
;				float theAngle = Utility.RandomFloat(0.0,360.0)
;				theFuel.setAngle(0.0,0.0,theAngle)
;				theFuel.enable()
;				Utility.wait(0.5)
;				xIndex +=1
;			endWhile
;			Utility.wait(1.0)
;;			selfRef.moveto(self,0,0,-10000)
;;			kFire.moveto(self)
;			selfRef.enable()
;			gotoState("FireOut")
;		endIf
;		processing = false
;	endIf
;endEvent

;Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
;  bool abBashAttack, bool abHitBlocked)
;
;endEvent


;endState

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
;do Nothing
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)

  ;do Nothing

endEvent

endState

Function LightFire()

if kFire
	kFire.Enable()	
	if kFireOut
		kFireOut.Disable()
	endIf
	if kLight
		klight.Enable()	
	endIf
	handleSmoke(true)
	gotoState("FireLit")
endif

endFunction

Function PutOutFire()

if kFire
	if kFireOut
		kFireOut.enable()
	else
		kFireOut = placeFireOut()
	endIf
	kFire.Disable()	
	if kLight
		klight.Disable()	
	endIf
	handleSmoke(false)
	gotoState("FireOut")
endif

endFunction

Function handleSmoke(bool akEnable)

	int xIndex = jbUtils.ArrayCount(mySmokelist)
	objectreference nearbySmoke
	jbUtils.DebugTrace(self+" Number of smokes: "+xIndex)
	while xIndex > 0
		xIndex -= 1
		nearbySmoke = mySmokelist[xIndex] as objectreference
		if nearbySmoke
			if akEnable
				nearbySmoke.enable()
				jbUtils.DebugTrace(self+" Enabling smoke "+nearbySmoke)
			else
				nearbySmoke.disable()
				jbUtils.DebugTrace(self+" Disabling smoke "+nearbySmoke)
			endIf
		endIf
	endWhile
	
endFunction

ObjectReference Function placeFireOut(bool akInitiallyDisabled = false)

objectreference newFireOutRef
form kFireOutForm = getFireOutForm(kFire)
if kFireOutForm
	newFireOutRef = kFire.placeAtMe(kFireOutForm, abInitiallyDisabled = akInitiallyDisabled)
	jbUtils.DebugTrace("Placed Fireout "+newFireOutRef+" for Fire "+kFire)
	newFireOutRef.SetScale(kFire.getScale())
	newFireOutRef.SetAngle(kFire.getAngleX(),kFire.getAngleY(),kFire.getAngleZ())
endIf

Return newFireOutRef

endFunction

Form Function getFireOutForm(ObjectReference akFireLit)

	int LitIndex
	int UnlitIndex = -1
	Form ReturnForm
	Form FireLitBaseObj = akFireLit.GetBaseObject()
	
	LitIndex = MainQS.lFireLightSources.Find(FireLitBaseObj)
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
	
	ReturnForm = MainQS.lFireLightsOff.GetAt(UnlitIndex)
	jbUtils.DebugTrace("getFireOutForm Returning: "+UnlitIndex+"-"+ReturnForm)
	Return ReturnForm
	
endFunction

Function TerminateMarker()

	jbUtils.DebugTrace("Terminating Marker "+selfRef)
	if kFireOut
		jbUtils.DebugTrace("Deleting Fireout: "+kFireOut)
		kFireOut.Disable()
		kFireOut.Delete()
	endIf
	selfRef.Disable()
	selfRef.Delete()

endFunction
		
	
	