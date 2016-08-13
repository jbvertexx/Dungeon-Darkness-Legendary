Scriptname jbMOSconceAliasScript extends ReferenceAlias  

Event OnInit()

	RegisterforSingleUpdate(5.0)

endEvent

Event OnUpdate()

	debug.Notification(GetName()+" filled by "+getref())
	
	RegisterforSingleUpdate(5.0)

endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, \
  bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if (akAggressor == Game.GetPlayer())
		debug.Notification("I've been hit")
	endif
EndEvent