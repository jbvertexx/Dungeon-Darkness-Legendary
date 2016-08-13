Scriptname jbMOCandleLightingScript Extends Quest

import Math

Int[] CandleXOffset
Int[] CandleYOffset
Int[] CandleZOffset
Int[] CandleMeshSelect


Event OnInit()

	InitCandleArrays()

EndEvent

Function InitCandleArrays()

	CandleXOffset = New Int[27]
	CandleYOffset = New Int[27]
	CandleZOffset = New Int[27]
	
	CandleXOffset[0] = 0
	CandleXOffset[1] = 0
	CandleXOffset[2] = 0
	CandleXOffset[3] = 0
	CandleXOffset[4] = 0
	CandleXOffset[5] = 0
	CandleXOffset[6] = 0
	CandleXOffset[7] = 0
	CandleXOffset[8] = 0
	CandleXOffset[9] = 0
	CandleXOffset[10] = 0
	CandleXOffset[11] = 0
	CandleXOffset[12] = 0
	CandleXOffset[13] = 0
	CandleXOffset[14] = 0
	CandleXOffset[15] = 0
	CandleXOffset[16] = 0
	CandleXOffset[17] = 0
	CandleXOffset[18] = 0
	CandleXOffset[19] = 0
	CandleXOffset[20] = 0
	CandleXOffset[21] = 0
	CandleXOffset[22] = 0
	CandleXOffset[23] = 0
	CandleXOffset[24] = 0
	CandleXOffset[25] = 0
	CandleXOffset[26] = 0

	CandleYOffset[0] = 0
	CandleYOffset[1] = 0
	CandleYOffset[2] = 0
	CandleYOffset[3] = 0
	CandleYOffset[4] = 0
	CandleYOffset[5] = 0
	CandleYOffset[6] = 0
	CandleYOffset[7] = 0
	CandleYOffset[8] = 0
	CandleYOffset[9] = 0
	CandleYOffset[10] = 0
	CandleYOffset[11] = 0
	CandleYOffset[12] = 0
	CandleYOffset[13] = 0
	CandleYOffset[14] = 0
	CandleYOffset[15] = 0
	CandleYOffset[16] = 0
	CandleYOffset[17] = 0
	CandleYOffset[18] = 0
	CandleYOffset[19] = 0
	CandleYOffset[20] = 0
	CandleYOffset[21] = 0
	CandleYOffset[22] = 0
	CandleYOffset[23] = 0
	CandleYOffset[24] = 0
	CandleYOffset[25] = 0
	CandleYOffset[26] = 0

	CandleZOffset[0] = 0
	CandleZOffset[1] = 0
	CandleZOffset[2] = 0
	CandleZOffset[3] = 0
	CandleZOffset[4] = 0
	CandleZOffset[5] = 0
	CandleZOffset[6] = 0
	CandleZOffset[7] = 0
	CandleZOffset[8] = 0
	CandleZOffset[9] = 0
	CandleZOffset[10] = 0
	CandleZOffset[11] = 0
	CandleZOffset[12] = 0
	CandleZOffset[13] = 0
	CandleZOffset[14] = 0
	CandleZOffset[15] = 0
	CandleZOffset[16] = 0
	CandleZOffset[17] = 0
	CandleZOffset[18] = 0
	CandleZOffset[19] = 0
	CandleZOffset[20] = 0
	CandleZOffset[21] = 0
	CandleZOffset[22] = 0
	CandleZOffset[23] = 0
	CandleZOffset[24] = 0
	CandleZOffset[25] = 0
	CandleZOffset[26] = 0


	