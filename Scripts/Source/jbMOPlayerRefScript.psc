Scriptname jbMOPlayerRefScript extends ReferenceAlias  

ObjectReference Property playerRef  Auto
jbMOMainQS Property mainQS Auto
jbMOOptions Property Options Auto
jbMOUtils Property jbUtils Auto
Keyword Property locTypeDungeonKW  Auto  
Keyword Property locTypeDwemerKW Auto
Keyword Property locSetCaveKW Auto
Keyword Property locSetCaveIceKW Auto
Keyword Property locSetDwarvenKW Auto
Keyword Property locSetNordicKW Auto
Formlist Property CellsNoDungKWList Auto
Formlist Property CellsNoDungKWNoScan Auto
Message Property manualScanMessage Auto
Message Property NoLocationMessage Auto
MQ00QuestScript Property MQ00 Auto
Quest Property StatsAliasQ Auto


Cell pCell
Location pLoc
;jbMOMainQS mainQS
bool WasinDungeon = false
bool WasManualScan = false


Event OnInit()
    RegisterForModEvent("JBMod_ScanCurrentDungeon", "onScanCurrentDungeon")
    RegisterForModEvent("JBMod_ResetCurrentDungeon", "onResetCurrentDungeon")
;    RegisterForModEvent("JBMod_ResetAllDungeons", "onResetAllDungeons")

EndEvent

Event OnPlayerLoadGame()

;	Debug.Notification("Load Game Detected")
	Options.doUpdate()
	mainQS.doGameLoad()
    RegisterForModEvent("JBMod_ScanCurrentDungeon", "onScanCurrentDungeon")
    RegisterForModEvent("JBMod_ResetCurrentDungeon", "onResetCurrentDungeon")
;    RegisterForModEvent("JBMod_ResetAllDungeons", "onResetAllDungeons")
;	Debug.Notification("OnPlayerLoadGame Complete")
EndEvent

Event OnCellLoad()

int locType

if StatsAliasQ.isRunning()
	StatsAliasQ.Stop()
	jbUtils.DebugTrace(StatsAliasQ+" Stopped")
endIf
	
if Options.isModEnabled && MQ00.GetStage() >= 5
	bool doScan = false
	jbUtils.DebugNotification("New Cell Loaded")
	pCell = playerRef.GetParentCell()
	pLoc = playerRef.GetCurrentLocation()
	jbUtils.DebugTrace("Cell Loaded:  "+(pCell as form)+"  Location:  "+(pLoc as form))

	if mainQS.isProcessing
		mainQS.TerminateProcessing()
	endIf

	if mainQS.checkExceptionCells(pCell)
		doScan = true
		locType = getLocType(pLoc)
		WasManualScan = false
	elseIf pCell.IsInterior()
		if !pLoc
			if WasinDungeon && WasManualScan
				doScan = true
			elseif Options.noLocPrompt && !CellsNoDungKWNoScan.hasForm(pCell)
				doScan = !(NoLocationMessage.show() as bool)
				if doScan
					locType = manualScanMessage.show()
					if locType > 3
						doScan = false
					else
						WasManualScan = true
					endIf
				endIf
			endIf
		elseIf pLoc.HasKeyword(locTypeDungeonKW)
			doScan = true
			locType = getLocType(pLoc)
			WasManualScan = false
		endIf
	endIf
	
	if !Options.doDwemer && locType == 2 && doScan
		doScan = false
		jbUtils.DebugNotification("Dwemer ruins - not doing scan.")
	endIf
	
	if doScan
		jbUtils.DebugTrace("Location Type: "+locType)
		mainQS.dungeonScan(pCell, locType, WasinDungeon)
		WasinDungeon = true
	Else
		jbUtils.DebugNotification("Location Type not Dungeon")
		if WasinDungeon && Options.STDisable
			mainQS.SneakToolsResume()
		endIf
		WasinDungeon = false
		WasManualScan = false
	EndIf
endIf

endEvent

Event OnScanCurrentDungeon()

	jbUtils.DebugNotification("Scan current dungeon called")
	pCell = playerRef.GetParentCell()

	if mainQS.isProcessing
		mainQS.TerminateProcessing()
	endIf
	int MessageSelection = 0
	MessageSelection = manualScanMessage.show()

	If MessageSelection <= 3
		mainQS.dungeonScan(pCell, MessageSelection, WasinDungeon)
	endIf
	
endEvent

Event OnResetCurrentDungeon()

	jbUtils.DebugNotification("Reset current dungeon called")
	pCell = playerRef.GetParentCell()

	if mainQS.isProcessing
		mainQS.TerminateProcessing()
	endIf
		
	mainQS.dungeonReset(pCell)
	
endEvent

;Event OnResetAllDungeons()

;	jbUtils.DebugNotification("Reset all dungeons called")

;	if mainQS.isProcessing
;		mainQS.TerminateProcessing()
;	endIf
		
;	mainQS.dungeonResetAll()
	
;endEvent


;Function Get Location Type:  0=Default, 1=Cave, 2=Dwarven Ruin, 3=Nordic Ruin
;Actually using locset keyword

int Function getLocType(Location akLocation)

	if akLocation.HasKeyword(locSetCaveKW) || akLocation.HasKeyword(locSetCaveIceKW)
		return 1
	elseIf akLocation.HasKeyword(locSetDwarvenKW)
		return 2
	elseIf akLocation.HasKeyword(locSetNordicKW)
		return 3
	else
		return 0
	endIf
	
endFunction




