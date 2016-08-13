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
	

	
		