Scriptname jbMOCandleLighterScript extends ObjectReference  

jbMOMainQS property MainQS auto
Keyword Property MagicDamageFire auto
Keyword Property MagicDamageFrost auto

formlist candlelist
formlist lightlist

jbMOUtils jbUtils
objectreference pPlayer
bool processing = false
objectreference selfRef
ObjectReference kCandle
ObjectReference kCandleOut
ObjectReference kLight

Form[] mySmokelist

Event onInit()
	selfRef = self as ObjectReference
	jbUtils = MainQS.jbUtils
	mySmokelist = new Form[8]
	jbUtils.DebugTrace(self+" Candlelighter Initialized")
endEvent

Event onCellattach()

	jbUtils.DebugTrace(self+" Candlelighter Loaded")
	lightlist = MainQS.llights
	candlelist = MainQS.lCandleLightSources

endEvent	

Function setRefs(objectreference akCandleRef, objectreference akLightRef)

	kCandle = akCandleRef
	kLight = akLightRef

	lightlist = MainQS.llights
	candlelist = MainQS.lCandleLightSources
	jbUtils = MainQS.jbUtils
	pPlayer = game.getplayer()

	if kCandle
		if kLight.isEnabled()
			gotoState("CandleLit")
		else
			kCandle.disable()
			if !kCandleOut
				kCandleOut = placeCandleOut()
			endIf
			gotoState("CandleOut")
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

;State CandleEmpty

;Event onBeginState()

;	self.SetDisplayName("Add Fuel")
	
;endEvent

;Event onActivate(objectreference theActivator)
;	if !processing
;		processing = true
;;		kCandle.delete()
;;		kCandle.moveto(self,0,0,10000)
;;		selfRef.moveto(kCandle)
;		jbUtils.DebugTrace(self+" Candlelighter Activated")
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
;;			kCandle.moveto(self)
;			selfRef.enable()
;			gotoState("CandleOut")
;		endIf
;		processing = false
;	endIf
;endEvent

;Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
;  bool abBashAttack, bool abHitBlocked)
;
;endEvent


;endState

State CandleOut

Event onBeginState()

	self.SetDisplayName("Light Candle")
	
endEvent

Event onActivate(objectreference theActivator)
	if !processing
		processing = true
	
		jbUtils.DebugTrace(self+" Candlelighter Activated")
		if theActivator == pPlayer
			if (theActivator as Actor).getEquippedItemType(0) == 11
				LightCandle()
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
		jbUtils.DebugTrace(self+" Candlelighter Hit by: "+akSource+" Bashattack: "+abBashAttack)
		If(akSource As Spell)
			Spell sourceSpell = akSource As Spell
			int numEffects = sourceSpell.GetNumEffects()
			int index=0

			while(index < numEffects)
				MagicEffect nthMagicEffect = sourceSpell.GetNthEffectMagicEffect(index)
				If(nthMagicEffect.HasKeyword(MagicDamageFire))
					jbUtils.DebugTrace(self+" hit with fire spell")
					LightCandle()
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

State CandleLit

Event onBeginState()

	self.SetDisplayName("Extinguish Candle")
	
endEvent

Event onActivate(objectreference theActivator)

	if !processing
		processing = true
	
		jbUtils.DebugTrace(self+" Candlelighter Activated")
		jbUtils.DebugTrace("Activator "+selfRef+" position: "+selfRef.getPositionX()+","+selfRef.getPositionY()+","+selfRef.getPositionZ())
		jbUtils.DebugTrace("Candle "+kCandle+" position: "+kCandle.getPositionX()+","+kCandle.getPositionY()+","+kCandle.getPositionZ())
		if theActivator == pPlayer
			PutOutCandle()
		endIf
		processing = false
	endIf
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)

	if !processing
		processing = true
		jbUtils.DebugTrace(self+" Candlelighter Hit by: "+akSource+" Bashattack: "+abBashAttack)
		If(akSource As Spell)
			Spell sourceSpell = akSource As Spell
			int numEffects = sourceSpell.GetNumEffects()
			int index=0

			while(index < numEffects)
				MagicEffect nthMagicEffect = sourceSpell.GetNthEffectMagicEffect(index)
				If(nthMagicEffect.HasKeyword(MagicDamageFrost))
					jbUtils.DebugTrace(self+" hit with frost spell")
					PutOutCandle()
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

Function LightCandle()

if kCandle
	kCandle.Enable()	
	if kCandleOut
		kCandleOut.Disable()
	endIf
	if kLight
		klight.Enable()	
	endIf
	handleSmoke(true)
	gotoState("CandleLit")
endif

endFunction

Function PutOutCandle()

if kCandle
	if kCandleOut
		kCandleOut.enable()
	else
		kCandleOut = placeCandleOut()
	endIf
	kCandle.Disable()	
	if kLight
		klight.Disable()	
	endIf
	handleSmoke(false)
	gotoState("CandleOut")
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

ObjectReference Function placeCandleOut(bool akInitiallyDisabled = false)

objectreference newCandleOutRef
form kCandleOutForm = getCandleOutForm(kCandle)
if kCandleOutForm
	newCandleOutRef = kCandle.placeAtMe(kCandleOutForm, abInitiallyDisabled = akInitiallyDisabled)
	jbUtils.DebugTrace("Placed Candleout "+newCandleOutRef+" for Candle "+kCandle)
	newCandleOutRef.SetScale(kCandle.getScale())
	newCandleOutRef.SetAngle(kCandle.getAngleX(),kCandle.getAngleY(),kCandle.getAngleZ())
endIf

Return newCandleOutRef

endFunction

Form Function getCandleOutForm(ObjectReference akCandleLit)

	Form ReturnForm
	Form CandleLitBaseObj = akCandleLit.GetBaseObject()
	
	Int LitIndex = MainQS.lCandleLightSources.Find(CandleLitBaseObj)
	jbUtils.DebugTrace("Getting Unlit Object for "+akCandleLit+" - LitIndex = "+LitIndex)

	ReturnForm = MainQS.lCandleLightsOff.GetAt(LitIndex)
	jbUtils.DebugTrace("getCandleOutForm Returning: "+LitIndex+"-"+ReturnForm)
	Return ReturnForm
	
endFunction

Function TerminateMarker()

	jbUtils.DebugTrace("Terminating Marker "+selfRef)
	if kCandleOut
		jbUtils.DebugTrace("Deleting Candleout: "+kCandleOut)
		kCandleOut.Disable()
		kCandleOut.Delete()
	endIf
	selfRef.Disable()
	selfRef.Delete()

endFunction
		
	
	