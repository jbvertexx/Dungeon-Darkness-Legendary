scriptname jbMOScanNPCThreadManager extends Quest
 
Quest property ScanNPCQuest auto
{The name of the thread management quest.}

int property thread_limit = 20 auto hidden

bool isCellLoaded = false

jbMOScanNPCThread01 thread01
jbMOScanNPCThread02 thread02
jbMOScanNPCThread03 thread03
jbMOScanNPCThread04 thread04
jbMOScanNPCThread05 thread05
jbMOScanNPCThread06 thread06
jbMOScanNPCThread07 thread07
jbMOScanNPCThread08 thread08
jbMOScanNPCThread09 thread09
jbMOScanNPCThread10 thread10
jbMOScanNPCthread11 thread11
jbMOScanNPCthread12 thread12
jbMOScanNPCthread13 thread13
jbMOScanNPCthread14 thread14
jbMOScanNPCthread15 thread15
jbMOScanNPCthread16 thread16
jbMOScanNPCthread17 thread17
jbMOScanNPCthread18 thread18
jbMOScanNPCthread19 thread19
jbMOScanNPCThread20 thread20
 
Event OnInit()

	InitializeThreadManager()
	
EndEvent
 
Function InitializeThreadManager()
    ;Register for the event that will start all threads
    ;NOTE - This needs to be re-registered once per load! Use an alias and OnPlayerLoadGame() in a real implementation.

    RegisterForModEvent("JBMod_OnScanNPCs", "OnScanNPCs")

    ;Let's cast our threads to local variables so things are less cluttered in our code
    thread01 = ScanNPCQuest as jbMOScanNPCThread01
    thread02 = ScanNPCQuest as jbMOScanNPCThread02
    thread03 = ScanNPCQuest as jbMOScanNPCThread03
    thread04 = ScanNPCQuest as jbMOScanNPCThread04
    thread05 = ScanNPCQuest as jbMOScanNPCThread05
    thread06 = ScanNPCQuest as jbMOScanNPCThread06
    thread07 = ScanNPCQuest as jbMOScanNPCThread07
    thread08 = ScanNPCQuest as jbMOScanNPCThread08
    thread09 = ScanNPCQuest as jbMOScanNPCThread09
    thread10 = ScanNPCQuest as jbMOScanNPCThread10
    thread11 = ScanNPCQuest as jbMOScanNPCthread11
    thread12 = ScanNPCQuest as jbMOScanNPCthread12
    thread13 = ScanNPCQuest as jbMOScanNPCthread13
    thread14 = ScanNPCQuest as jbMOScanNPCthread14
    thread15 = ScanNPCQuest as jbMOScanNPCthread15
    thread16 = ScanNPCQuest as jbMOScanNPCthread16
    thread17 = ScanNPCQuest as jbMOScanNPCthread17
    thread18 = ScanNPCQuest as jbMOScanNPCthread18
    thread19 = ScanNPCQuest as jbMOScanNPCthread19
    thread20 = ScanNPCQuest as jbMOScanNPCThread20

EndFunction

;Function to load parameters that will remain constant for each run to increase efficiency of each work-item.

function LoadforRun(jbMOMainQS akMainQS, Cell akCell)

	thread01.loadVars(akMainQS,akCell)
	thread02.loadVars(akMainQS,akCell)
	thread03.loadVars(akMainQS,akCell)
	thread04.loadVars(akMainQS,akCell)
	thread05.loadVars(akMainQS,akCell)
	thread06.loadVars(akMainQS,akCell)
	thread07.loadVars(akMainQS,akCell)
	thread08.loadVars(akMainQS,akCell)
	thread09.loadVars(akMainQS,akCell)
	thread10.loadVars(akMainQS,akCell)
	thread11.loadVars(akMainQS,akCell)
	thread12.loadVars(akMainQS,akCell)
	thread13.loadVars(akMainQS,akCell)
	thread14.loadVars(akMainQS,akCell)
	thread15.loadVars(akMainQS,akCell)
	thread16.loadVars(akMainQS,akCell)
	thread17.loadVars(akMainQS,akCell)
	thread18.loadVars(akMainQS,akCell)
	thread19.loadVars(akMainQS,akCell)
	thread20.loadVars(akMainQS,akCell)
	
endFunction
	
 
;The 'public-facing' function that our MagicEffect script will interact with.
function ScanNPCAsync(Int akIndexVal)

	if !thread01.queued() && thread_limit >= 1
        ;Debug.trace("[Callback] Selected thread01")
        thread01.get_async(akIndexVal)
	elseif !thread02.queued() && thread_limit >= 2
        ;Debug.trace("[Callback] Selected thread02")
		thread02.get_async(akIndexVal)
    elseif !thread03.queued() && thread_limit >= 3
        ;Debug.trace("[Callback] Selected thread03")
        thread03.get_async(akIndexVal)
    elseif !thread04.queued() && thread_limit >= 4
        ;Debug.trace("[Callback] Selected thread04")
        thread04.get_async(akIndexVal)
    elseif !thread05.queued() && thread_limit >= 5
        ;Debug.trace("[Callback] Selected thread05")
        thread05.get_async(akIndexVal)
    elseif !thread06.queued() && thread_limit >= 6
        ;Debug.trace("[Callback] Selected thread06")
        thread06.get_async(akIndexVal)
    elseif !thread07.queued() && thread_limit >= 7
        ;Debug.trace("[Callback] Selected thread07")
        thread07.get_async(akIndexVal)
    elseif !thread08.queued() && thread_limit >= 8
        ;Debug.trace("[Callback] Selected thread08")
        thread08.get_async(akIndexVal)
	elseif !thread09.queued() && thread_limit >= 9
        ;Debug.trace("[Callback] Selected thread09")
        thread09.get_async(akIndexVal)
	elseif !thread10.queued() && thread_limit >= 10
        ;Debug.trace("[Callback] Selected thread10")
        thread10.get_async(akIndexVal)
	elseif !thread11.queued() && thread_limit >= 11
        ;Debug.trace("[Callback] Selected thread10")
        thread11.get_async(akIndexVal)
	elseif !thread12.queued() && thread_limit >= 12
        ;Debug.trace("[Callback] Selected thread12")
		thread12.get_async(akIndexVal)
    elseif !thread13.queued() && thread_limit >= 13
        ;Debug.trace("[Callback] Selected thread13")
        thread13.get_async(akIndexVal)
    elseif !thread14.queued() && thread_limit >= 14
        ;Debug.trace("[Callback] Selected thread14")
        thread14.get_async(akIndexVal)
    elseif !thread15.queued() && thread_limit >= 15
        ;Debug.trace("[Callback] Selected thread15")
        thread15.get_async(akIndexVal)
    elseif !thread16.queued() && thread_limit >= 16
        ;Debug.trace("[Callback] Selected thread16")
        thread16.get_async(akIndexVal)
    elseif !thread17.queued() && thread_limit >= 17
        ;Debug.trace("[Callback] Selected thread17")
        thread17.get_async(akIndexVal)
    elseif !thread18.queued() && thread_limit >= 18
        ;Debug.trace("[Callback] Selected thread18")
        thread18.get_async(akIndexVal)
	elseif !thread19.queued() && thread_limit >= 19
        ;Debug.trace("[Callback] Selected thread19")
        thread19.get_async(akIndexVal)
	elseif !thread20.queued() && thread_limit >= 20
        ;Debug.trace("[Callback] Selected thread20")
        thread20.get_async(akIndexVal)

	else
		;All threads are queued; start all threads, wait, and try again.
        wait_all()
        ScanNPCAsync(akIndexVal)
	endif
endFunction
 
function wait_all()
    RaiseEvent_OnScanNPCs()
    begin_waiting()
endFunction

function begin_waiting()
    bool waiting = true
    int i = 0
    while waiting
        if thread01.queued() || thread02.queued() || thread03.queued() || thread04.queued() || thread05.queued() || \
           thread06.queued() || thread07.queued() || thread08.queued() || thread09.queued() || thread10.queued() || \
		   thread11.queued() || thread12.queued() || thread13.queued() || thread14.queued() || thread15.queued() || \
           thread16.queued() || thread17.queued() || thread18.queued() || thread19.queued() || thread20.queued()
            i += 1
            Utility.wait(0.01)
            if i >= 5000
                Debug.trace("Error: A catastrophic error has occurred. All threads have become unresponsive. Please debug this issue or notify the author.")
                i = 0
                ;Fail by returning None. The mod needs to be fixed.
                return
            endif
        else
            waiting = false
        endif
    endWhile
endFunction

;Create the ModEvent that will start this thread
function RaiseEvent_OnScanNPCs()
    int handle = ModEvent.Create("JBMod_OnScanNPCs")
    if handle
        ModEvent.Send(handle)
    else
        ;pass
    endif
endFunction

function clear_vars()

	thread01.clear_thread_vars()
	thread02.clear_thread_vars()
	thread03.clear_thread_vars()
	thread04.clear_thread_vars()
	thread05.clear_thread_vars()
	thread06.clear_thread_vars()
	thread07.clear_thread_vars()
	thread08.clear_thread_vars()
	thread09.clear_thread_vars()
	thread10.clear_thread_vars()
	thread11.clear_thread_vars()
	thread12.clear_thread_vars()
	thread13.clear_thread_vars()
	thread14.clear_thread_vars()
	thread15.clear_thread_vars()
	thread16.clear_thread_vars()
	thread17.clear_thread_vars()
	thread18.clear_thread_vars()
	thread19.clear_thread_vars()
	thread20.clear_thread_vars()
	
endFunction
	


