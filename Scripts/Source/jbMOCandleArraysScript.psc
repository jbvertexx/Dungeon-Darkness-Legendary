Scriptname jbMOCandleArraysScript Extends Quest

;Script to hold arrays required for candle lighting.
;Arrays are initialized once and accessed via script properties.

Float[] Property CandleXOffset Hidden
	Float[] Function get()
		return CandleXOffsetVar
	endFunction
endProperty

Float[] Property CandleYOffset Hidden
	Float[] Function get()
		return CandleYOffsetVar
	endFunction
endProperty

Float[] Property CandleZOffset Hidden
	Float[] Function get()
		return CandleZOffsetVar
	endFunction
endProperty

Int[] Property MarkerSelect Hidden
	Int[] Function get()
		return MarkerSelectVar
	endFunction
endProperty
	

Float[] CandleXOffsetVar
Float[] CandleYOffsetVar
Float[] CandleZOffsetVar
Int[] MarkerSelectVar


Event OnInit()

	InitCandleArrays()

EndEvent

Function InitCandleArrays()

	MarkerSelectVar = New Int[27]

	MarkerSelectVar[0] = 2
	MarkerSelectVar[1] = 2
	MarkerSelectVar[2] = 2
	MarkerSelectVar[3] = 1
	MarkerSelectVar[4] = 1
	MarkerSelectVar[5] = 1
	MarkerSelectVar[6] = 1
	MarkerSelectVar[7] = 1
	MarkerSelectVar[8] = 1
	MarkerSelectVar[9] = 2
	MarkerSelectVar[10] = 2
	MarkerSelectVar[11] = 1
	MarkerSelectVar[12] = 2
	MarkerSelectVar[13] = 2
	MarkerSelectVar[14] = 2
	MarkerSelectVar[15] = 1
	MarkerSelectVar[16] = 1
	MarkerSelectVar[17] = 1
	MarkerSelectVar[18] = 1
	MarkerSelectVar[19] = 1
	MarkerSelectVar[20] = 1
	MarkerSelectVar[21] = 1
	MarkerSelectVar[22] = 1
	MarkerSelectVar[23] = 1
	MarkerSelectVar[24] = 1
	MarkerSelectVar[25] = 1
	MarkerSelectVar[26] = 1

	CandleXOffsetVar = New Float[27]
	
	CandleXOffsetVar[0] = 0.0
	CandleXOffsetVar[1] = 0.0
	CandleXOffsetVar[2] = 0.0
	CandleXOffsetVar[3] = 0.0
	CandleXOffsetVar[4] = 0.0
	CandleXOffsetVar[5] = 0.0
	CandleXOffsetVar[6] = 0.0
	CandleXOffsetVar[7] = 0.0
	CandleXOffsetVar[8] = 0.0
	CandleXOffsetVar[9] = 0.0
	CandleXOffsetVar[10] = 0.0
	CandleXOffsetVar[11] = 0.0
	CandleXOffsetVar[12] = 0.0
	CandleXOffsetVar[13] = 0.0
	CandleXOffsetVar[14] = 0.0
	CandleXOffsetVar[15] = -10.0
	CandleXOffsetVar[16] = -10.0
	CandleXOffsetVar[17] = -10.0
	CandleXOffsetVar[18] = -25.0
	CandleXOffsetVar[19] = -25.0
	CandleXOffsetVar[20] = 0.0
	CandleXOffsetVar[21] = 0.0
	CandleXOffsetVar[22] = 0.0
	CandleXOffsetVar[23] = 0.0
	CandleXOffsetVar[24] = 0.0
	CandleXOffsetVar[25] = 0.0
	CandleXOffsetVar[26] = 0.0

	CandleYOffsetVar = New Float[27]

	CandleYOffsetVar[0] = 0.0
	CandleYOffsetVar[1] = 0.0
	CandleYOffsetVar[2] = 0.0
	CandleYOffsetVar[3] = 0.0
	CandleYOffsetVar[4] = -24.0
	CandleYOffsetVar[5] = 0.0
	CandleYOffsetVar[6] = -23.0
	CandleYOffsetVar[7] = 0.0
	CandleYOffsetVar[8] = 0.0
	CandleYOffsetVar[9] = 0.0
	CandleYOffsetVar[10] = 0.0
	CandleYOffsetVar[11] = 0.0
	CandleYOffsetVar[12] = 0.0
	CandleYOffsetVar[13] = 0.0
	CandleYOffsetVar[14] = 0.0
	CandleYOffsetVar[15] = 0.0
	CandleYOffsetVar[16] = 0.0
	CandleYOffsetVar[17] = 0.0
	CandleYOffsetVar[18] = 0.0
	CandleYOffsetVar[19] = 0.0
	CandleYOffsetVar[20] = 0.0
	CandleYOffsetVar[21] = 0.0
	CandleYOffsetVar[22] = 0.0
	CandleYOffsetVar[23] = 0.0
	CandleYOffsetVar[24] = 0.0
	CandleYOffsetVar[25] = 0.0
	CandleYOffsetVar[26] = 0.0

	CandleZOffsetVar = New Float[27]

	CandleZOffsetVar[0] = -30.0
	CandleZOffsetVar[1] = -28.0
	CandleZOffsetVar[2] = 75.0
	CandleZOffsetVar[3] = 0.0
	CandleZOffsetVar[4] = 0.0
	CandleZOffsetVar[5] = 0.0
	CandleZOffsetVar[6] = 115.0
	CandleZOffsetVar[7] = 0.0
	CandleZOffsetVar[8] = 0.0
	CandleZOffsetVar[9] = 50.0
	CandleZOffsetVar[10] = 110.0
	CandleZOffsetVar[11] = 0.0
	CandleZOffsetVar[12] = -20.0
	CandleZOffsetVar[13] = -50.0
	CandleZOffsetVar[14] = -55.0
	CandleZOffsetVar[15] = 5.0
	CandleZOffsetVar[16] = 0.0
	CandleZOffsetVar[17] = -10.0
	CandleZOffsetVar[18] = 15.0
	CandleZOffsetVar[19] = 15.0
	CandleZOffsetVar[20] = 75.0
	CandleZOffsetVar[21] = 100.0
	CandleZOffsetVar[22] = 25.0
	CandleZOffsetVar[23] = 25.0
	CandleZOffsetVar[24] = 35.0
	CandleZOffsetVar[25] = 35.0
	CandleZOffsetVar[26] = 22.0

endFunction
	