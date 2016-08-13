scriptname jbMODisableLightThreadManager extends Quest
 
Quest property DisableLightQuest auto
{The name of the thread management quest.}

int property thread_limit = 30 auto hidden

bool isCellLoaded = false

jbMODisableLightThread01 thread01
jbMODisableLightThread02 thread02
jbMODisableLightThread03 thread03
jbMODisableLightThread04 thread04
jbMODisableLightThread05 thread05
jbMODisableLightThread06 thread06
jbMODisableLightThread07 thread07
jbMODisableLightThread08 thread08
jbMODisableLightThread09 thread09
jbMODisableLightThread10 thread10
jbMODisableLightThread11 thread11
jbMODisableLightThread12 thread12
jbMODisableLightThread13 thread13
jbMODisableLightThread14 thread14
jbMODisableLightThread15 thread15
jbMODisableLightThread16 thread16
jbMODisableLightThread17 thread17
jbMODisableLightThread18 thread18
jbMODisableLightThread19 thread19
jbMODisableLightThread20 thread20
jbMODisableLightThread21 thread21
jbMODisableLightThread22 thread22
jbMODisableLightThread23 thread23
jbMODisableLightThread24 thread24
jbMODisableLightThread25 thread25
jbMODisableLightThread26 thread26
jbMODisableLightThread27 thread27
jbMODisableLightThread28 thread28
jbMODisableLightThread29 thread29
jbMODisableLightThread30 thread30

 
Event OnInit()

	InitializeThreadManager()
	
EndEvent
 
Function InitializeThreadManager()
    ;Register for the event that will start all threads
    ;NOTE - This needs to be re-registered once per load! Use an alias and OnPlayerLoadGame() in a real implementation.

	Debug.Notification("Initializing Thread Manager")

    RegisterForModEvent("JBMod_OnDisableLight", "OnDisableLight")

    ;Let's cast our threads to local variables so things are less cluttered in our code
    thread01 = DisableLightQuest as jbMODisableLightThread01
    thread02 = DisableLightQuest as jbMODisableLightThread02
    thread03 = DisableLightQuest as jbMODisableLightThread03
    thread04 = DisableLightQuest as jbMODisableLightThread04
    thread05 = DisableLightQuest as jbMODisableLightThread05
    thread06 = DisableLightQuest as jbMODisableLightThread06
    thread07 = DisableLightQuest as jbMODisableLightThread07
    thread08 = DisableLightQuest as jbMODisableLightThread08
    thread09 = DisableLightQuest as jbMODisableLightThread09
    thread10 = DisableLightQuest as jbMODisableLightThread10
    thread11 = DisableLightQuest as jbMODisableLightThread11
    thread12 = DisableLightQuest as jbMODisableLightThread12
    thread13 = DisableLightQuest as jbMODisableLightThread13
    thread14 = DisableLightQuest as jbMODisableLightThread14
    thread15 = DisableLightQuest as jbMODisableLightThread15
    thread16 = DisableLightQuest as jbMODisableLightThread16
    thread17 = DisableLightQuest as jbMODisableLightThread17
    thread18 = DisableLightQuest as jbMODisableLightThread18
    thread19 = DisableLightQuest as jbMODisableLightThread19
    thread20 = DisableLightQuest as jbMODisableLightThread20
    thread21 = DisableLightQuest as jbMODisableLightThread21
    thread22 = DisableLightQuest as jbMODisableLightThread22
    thread23 = DisableLightQuest as jbMODisableLightThread23
    thread24 = DisableLightQuest as jbMODisableLightThread24
    thread25 = DisableLightQuest as jbMODisableLightThread25
    thread26 = DisableLightQuest as jbMODisableLightThread26
    thread27 = DisableLightQuest as jbMODisableLightThread27
    thread28 = DisableLightQuest as jbMODisableLightThread28
    thread29 = DisableLightQuest as jbMODisableLightThread29
    thread30 = DisableLightQuest as jbMODisableLightThread30


EndFunction

;Function to load parameters that will remain constant for each run to increase efficiency of each work-item.

function LoadforRun(jbMOMainQS akMainQS, Cell akCell, Int akLocType, Int akLightType, FormList akDisableLightList, int akRunType = 0)

	thread01.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread02.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread03.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread04.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread05.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread06.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread07.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread08.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread09.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread10.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread11.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread12.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread13.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread14.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread15.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread16.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread17.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread18.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread19.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread20.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread21.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread22.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread23.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread24.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread25.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread26.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread27.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread28.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread29.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	thread30.loadVars(akMainQS,akCell,akLocType,akLightType,akDisableLightList,akRunType)
	
endFunction
	
 
;The 'public-facing' function that our MagicEffect script will interact with.
function DisableLightAsync(Int akIndexVal)

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
        ;Debug.trace("[Callback] Selected thread11")
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
    elseif !thread21.queued() && thread_limit >= 21
        ;Debug.trace("[Callback] Selected thread21")
        thread21.get_async(akIndexVal)
    elseif !thread22.queued() && thread_limit >= 22
        ;Debug.trace("[Callback] Selected thread22")
        thread22.get_async(akIndexVal)
    elseif !thread23.queued() && thread_limit >= 23
        ;Debug.trace("[Callback] Selected thread23")
        thread23.get_async(akIndexVal)
    elseif !thread24.queued() && thread_limit >= 24
        ;Debug.trace("[Callback] Selected thread24")
        thread24.get_async(akIndexVal)
    elseif !thread25.queued() && thread_limit >= 25
        ;Debug.trace("[Callback] Selected thread25")
        thread25.get_async(akIndexVal)
    elseif !thread26.queued() && thread_limit >= 26
        ;Debug.trace("[Callback] Selected thread26")
        thread26.get_async(akIndexVal)
    elseif !thread27.queued() && thread_limit >= 27
        ;Debug.trace("[Callback] Selected thread27")
        thread27.get_async(akIndexVal)
    elseif !thread28.queued() && thread_limit >= 28
        ;Debug.trace("[Callback] Selected thread28")
        thread28.get_async(akIndexVal)
    elseif !thread29.queued() && thread_limit >= 29
        ;Debug.trace("[Callback] Selected thread29")
        thread29.get_async(akIndexVal)
    elseif !thread30.queued() && thread_limit >= 30
        ;Debug.trace("[Callback] Selected thread30")
        thread30.get_async(akIndexVal)

	else
		;All threads are queued; start all threads, wait, and try again.
        wait_all()
        DisableLightAsync(akIndexVal)
	endif
endFunction
 
function wait_all()
    RaiseEvent_OnDisableLight()
    begin_waiting()
endFunction

function begin_waiting()
    bool waiting = true
    int i = 0
    while waiting
        if thread01.queued() || thread02.queued() || thread03.queued() || thread04.queued() || thread05.queued() || \
           thread06.queued() || thread07.queued() || thread08.queued() || thread09.queued() || thread10.queued() || \ 
           thread11.queued() || thread12.queued() || thread13.queued() || thread14.queued() || thread15.queued() || \ 
           thread16.queued() || thread17.queued() || thread18.queued() || thread19.queued() || thread20.queued() || \ 
           thread21.queued() || thread22.queued() || thread23.queued() || thread24.queued() || thread25.queued() || \ 
           thread26.queued() || thread27.queued() || thread28.queued() || thread29.queued() || thread30.queued()
            i += 1
            Utility.wait(0.1)
            if i >= 500
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
function RaiseEvent_OnDisableLight()
    int handle = ModEvent.Create("JBMod_OnDisableLight")
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
	thread21.clear_thread_vars()
	thread22.clear_thread_vars()
	thread23.clear_thread_vars()
	thread24.clear_thread_vars()
	thread25.clear_thread_vars()
	thread26.clear_thread_vars()
	thread27.clear_thread_vars()
	thread28.clear_thread_vars()
	thread29.clear_thread_vars()
	thread30.clear_thread_vars()
	
endFunction
	


