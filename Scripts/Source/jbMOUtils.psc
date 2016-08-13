Scriptname jbMOUtils extends quest

import math

jbMOOptions Property Options Auto

Function DebugTrace(string debugText)

if Options.DebugMode

	debug.trace(debugText)
	
endif

endFunction

Function DebugNotification(string NotificationText, int NoteLevel = 2)

if Options.NotificationLevel >= NoteLevel

	debug.Notification(NotificationText)
	
endif

endFunction

Form[] Function FormArrayCopy(Form[] myArray)

	Form[] returnArray = new Form[128]
	int xIndex = 0
	while xIndex < 128
		returnArray[xIndex] = myArray[xIndex]
		xIndex+=1
	endWhile
	
	return returnArray
	
endFunction

Int[] Function IntArrayCopy(Int[] myArray)

	Int[] returnArray = new Int[128]
	int xIndex = 0
	while xIndex < 128
		returnArray[xIndex] = myArray[xIndex]
		xIndex+=1
	endWhile
	
	return returnArray
	
endFunction

Function dumpModInfo()

	int xIndex = 0
	string modName
	string modAuthor
	int numMods = game.GetModCount()
	Debug.Trace("**** Mod List *****")
	while xIndex < numMods
		modName = Game.GetModName(xIndex)
		modAuthor = Game.GetModAuthor(xIndex)
		Debug.Trace(xIndex+":  "+modName+" - "+modAuthor)
		xIndex += 1
	endWhile
	
endFunction

Function dumpFormlist(Formlist akList)

	int listSize = akList.GetSize()
	Debug.Trace("Dumping Formlist: "+akList)
	int xIndex = 0
	while xIndex < listSize
		Debug.Trace(akList.GetAt(xIndex))
		xIndex += 1
	endWhile
	
endFunction
	
int Function ArrayCount(Form[] myArray)

	int i = 0
	int myCount = 0
	while i < myArray.Length
		if myArray[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
 
	return myCount
 
endFunction
 
int function ArrayHasForm(Form[] myArray, Form myForm)

	int i = 0
	;DebugTrace("Searching for "+myForm)
	dumpArrayContents(myArray)
	while i < myArray.Length
		if myArray[i] == myForm
			;DebugTrace("Found at position "+i)
			return i
		else
			i += 1
		endif
	endWhile
 
	return -1
 
endFunction

function ArrayAddForm(Form[] myArray, Form myForm)
 
	int i = 0
	while i < myArray.Length
		if myArray[i] == none
			myArray[i] = myForm
			;DebugTrace("Adding " + myForm + " to position "+i)
			i=myArray.Length
		else
			i += 1
		endif
	endWhile
	DebugTrace(myArray)
endFunction

function dumpArrayContents (Form[] myArray)

	int i = 0
	while i < myArray.Length
		DebugTrace("Array element "+i+":  "+myArray[i])
		i+=1
	endWhile

endFunction

Form[] Function ArrayClear(Form[] myArray)

	int i = 0
	int myCount = 0
	while i < myArray.Length
		myArray[i] = none
		i += 1
	endWhile
 
	return myArray
 
endFunction

	
		