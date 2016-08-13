Scriptname fadeImagespace extends Quest  

ImageSpaceModifier Property pFadeToBlack auto

ImageSpaceModifier Property pFadeFromBlack auto

;**************************************
Function DoFadeOut()
	Game.DisablePlayerControls(True, True,True,True, True,True, True, True)
   pFadeToBlack.Apply()
   Utility.Wait(0.1)
   Game.FadeOutGame(True,True,50, 1)
EndFunction

;**************************************
; Fade the game back in after a call to DoFadeOut
;**************************************
Function DoFadeIn()
   Game.FadeOutGame(False,True,0.1, 0.1)
   pFadeToBlack.PopTo(pFadeFromBlack)
   Game.EnablePlayerControls()
EndFunction
;************************************
