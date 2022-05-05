using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.Attention;
using Toybox.Application;
using Toybox.Lang;

class WorkoutManager {

    hidden var currentIndex = 0;
    hidden var workouts as Lang.Array<WorkoutElement>;
    hidden var isRestMode = false;
    hidden var workout1;
    hidden var workout2;
    hidden var workout3;
    hidden var workout4;
    hidden var workout5;
    hidden var workout6;
    hidden var workout7;
    hidden var workout8;
    hidden var timerCallBack;
    hidden var repeatTimes;

    function initialize() {
        loadWorkouts();
        reorderWorkouts();
        repeatTimes = Application.Properties.getValue("repeat");
    }

    function getCurrentIndex()
    {
        return currentIndex;
    }  

    function getDisplayIndex()
    {
        var displayIndex = 0;
        for( var i = 0; i < workouts.size(); i += 1 ) {
            if( i == currentIndex )
            {
                return displayIndex;
            }            
            if( workouts[i].isEnabled )
            {
                displayIndex = displayIndex + 1;
            }
        }
        return displayIndex;
    }  

    function enabledSize()
    {
        var size = 0;
        for( var i = 0; i < workouts.size(); i += 1 ) {
            if( workouts[i].isEnabled )
            {
                size = size + 1;
            }
        }
        return size;
    }    

    function size()
    {
        return workouts.size();
    }

    function getFirstEnabledWorkout()
    {
        System.println("getFirstEnabledWorkout:");
        for( var i = 0; i < workouts.size(); i += 1 ) {
            if( workouts[i].isEnabled )
                {
                    currentIndex = i;
                    return workouts[currentIndex];
                }
        }
        return null;
    }

    function moveNext()
    {
        System.println("moveNext: isRestMode " + isRestMode.toString());
	    isRestMode = !isRestMode;
        if(isRestMode){
            for( var i = currentIndex + 1; i < workouts.size(); i += 1 ) {
                if( workouts[i].isEnabled )
                {
                    currentIndex = i;
                    workouts[currentIndex].setRestMode(isRestMode);
                    stopBuzz();
                    return;
                }
            }
            currentIndex = 100;
        }else{
            startBuzz();
            workouts[currentIndex].setRestMode(isRestMode);
        }
    }

    function getCurrentWorkout()
    {
        System.println("getCurrentWorkout, currentIndex = " + currentIndex);
        if(currentIndex >= size()){
            return null;//workouts[0];
        }

        return workouts[currentIndex];
    }

    function getWorkoutByIndex(index)
    {
        System.println("getWorkoutByIndex, index = " + index);
        if(currentIndex >= size()){
            return null;
        }
        return workouts[index];
    }

    function isFinish()
    {
        return repeatTimes >= 0;
    }
    
    function startBuzz() {
		if(Attention has :playTone){
			Attention.playTone(Attention.TONE_START);
		}
		vibrate(1500);      
	}

	function stopBuzz() {
		if(Attention has :playTone){
			Attention.playTone(Attention.TONE_STOP);
		}
		vibrate(1500);
	}

	function endBuzz() {
		if(Attention has :playTone){
			Attention.playTone(Attention.TONE_SUCCESS);
		}
		vibrate(1500);
	}
    
	function beep() {
		if(Attention has :playTone){
			Attention.playTone(Attention.TONE_LOUD_BEEP);
		}
	}	
    
	function beepDistanceAlert() {
		if(Attention has :playTone){
			Attention.playTone(Attention.TONE_INTERVAL_ALERT);
		}
	}	
    
    function vibrate(duration) {
		if(Attention has :vibrate){
			var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
			Attention.vibrate( vibrateData );
		}
	}

    function onReturnAfterPause(){
        currentIndex = 0;
        moveNext();
        var currentWorkout = getCurrentWorkout();
        moveNext();
        myTimer.start(timerCallBack, 1000, true);
    }

    function oneSecondProcessing(timerCallBack) {
        self.timerCallBack = timerCallBack;
        var currentWorkout = getCurrentWorkout();

        var sec_total = currentWorkout.time();
        if(sec_current > 0){
            if(sec_current <= 6 && !currentWorkout.isRestMode){
                beep();
            }
            if( sec_current == sec_total / 2 &&
                currentWorkout.beepInTheMiddle &&
                !currentWorkout.isRestMode){
                    beepDistanceAlert();
            }
            sec_current -= 1;
        }else{
            myTimer.stop();
            System.println("repeatTimes: " + repeatTimes.toString());
            moveNext();
            currentWorkout = getCurrentWorkout();
            if(currentWorkout != null){
                sec_current = currentWorkout.time();
                myTimer.start(timerCallBack, 1000, true);
            }else{
                System.println("repeatTimes: " + repeatTimes.toString());
                repeatTimes -= 1;
                if(repeatTimes > 0){
                    //session.addLap();
                    System.println("repeatTimes: " + repeatTimes);
                    var callBack = self.method(:onReturnAfterPause);
                    WatchUi.pushView( new MessageView("Press Start", "to continue"), new MessageDelegate(callBack), WatchUi.SLIDE_UP);
                }else{
                    session.stop(); 
                    System.println("stop recording");
                    WatchUi.pushView( new EndMenu(self), new EndMenuDelegate(self), WatchUi.SLIDE_UP);
                }
            }
        }
    }


    function saveWorkouts() {
        Application.Properties.setValue("w1index", workout1.index);
        Application.Properties.setValue("w1isEnabled", workout1.isEnabled);
        Application.Properties.setValue("w1beepInTheMiddle", workout1.beepInTheMiddle);
        
        Application.Properties.setValue("w2index", workout2.index);
        Application.Properties.setValue("w2isEnabled", workout2.isEnabled);
        Application.Properties.setValue("w2beepInTheMiddle", workout2.beepInTheMiddle);
 
        Application.Properties.setValue("w3index", workout3.index);
        Application.Properties.setValue("w3isEnabled", workout3.isEnabled);
        Application.Properties.setValue("w3beepInTheMiddle", workout3.beepInTheMiddle);
 
        Application.Properties.setValue("w4index", workout4.index);
        Application.Properties.setValue("w4isEnabled", workout4.isEnabled);
        Application.Properties.setValue("w4beepInTheMiddle", workout4.beepInTheMiddle);
 
        Application.Properties.setValue("w5index", workout5.index);
        Application.Properties.setValue("w5isEnabled", workout5.isEnabled);
        Application.Properties.setValue("w5beepInTheMiddle", workout5.beepInTheMiddle);
 
        Application.Properties.setValue("w6index", workout6.index);
        Application.Properties.setValue("w6isEnabled", workout6.isEnabled);
        Application.Properties.setValue("w6beepInTheMiddle", workout6.beepInTheMiddle);
 
        Application.Properties.setValue("w7index", workout7.index);
        Application.Properties.setValue("w7isEnabled", workout7.isEnabled);
        Application.Properties.setValue("w7beepInTheMiddle", workout7.beepInTheMiddle);
 
        Application.Properties.setValue("w8index", workout8.index);
        Application.Properties.setValue("w8isEnabled", workout8.isEnabled);
        Application.Properties.setValue("w8beepInTheMiddle", workout8.beepInTheMiddle);

        reorderWorkouts();
    }
        
    function loadWorkouts() {       
        var w1index = Application.Properties.getValue("w1index");       
        var w1isEnabled = Application.Properties.getValue("w1isEnabled");
        var w1beepInTheMiddle = Application.Properties.getValue("w1beepInTheMiddle");
        workout1 = new WorkoutElement("basic plank", Rez.Drawables.Plank1, w1index, w1isEnabled, w1beepInTheMiddle);

        var w2index = Application.Properties.getValue("w2index");
        var w2isEnabled = Application.Properties.getValue("w2isEnabled");
        var w2beepInTheMiddle = Application.Properties.getValue("w2beepInTheMiddle");
        workout2 = new WorkoutElement("left plank", Rez.Drawables.Plank2, w2index, w2isEnabled, w2beepInTheMiddle);

        var w3index = Application.Properties.getValue("w3index");
        var w3isEnabled = Application.Properties.getValue("w3isEnabled");
        var w3beepInTheMiddle = Application.Properties.getValue("w3beepInTheMiddle");
        workout3 = new WorkoutElement("right plank", Rez.Drawables.Plank3, w3index, w3isEnabled, w3beepInTheMiddle);

        var w4index = Application.Properties.getValue("w4index");
        var w4isEnabled = Application.Properties.getValue("w4isEnabled");
        var w4beepInTheMiddle = Application.Properties.getValue("w4beepInTheMiddle");
        workout4 = new WorkoutElement("revers plank", Rez.Drawables.Plank4, w4index, w4isEnabled, w4beepInTheMiddle);

        var w5index = Application.Properties.getValue("w5index");
        var w5isEnabled = Application.Properties.getValue("w5isEnabled");
        var w5beepInTheMiddle = Application.Properties.getValue("w5beepInTheMiddle");
        workout5 = new WorkoutElement("corner plank", Rez.Drawables.Plank5, w5index, w5isEnabled, w5beepInTheMiddle);

        var w6index = Application.Properties.getValue("w6index"); 
        var w6isEnabled = Application.Properties.getValue("w6isEnabled");
        var w6beepInTheMiddle = Application.Properties.getValue("w6beepInTheMiddle");    
        workout6 = new WorkoutElement("boat plank", Rez.Drawables.Plank6, w6index, w6isEnabled, w6beepInTheMiddle);

        var w7index = Application.Properties.getValue("w7index"); 
        var w7isEnabled = Application.Properties.getValue("w7isEnabled");
        var w7beepInTheMiddle = Application.Properties.getValue("w7beepInTheMiddle");    
        workout7 = new WorkoutElement("spider move", Rez.Drawables.Plank7, w7index, w7isEnabled, w7beepInTheMiddle);

        var w8index = Application.Properties.getValue("w8index"); 
        var w8isEnabled = Application.Properties.getValue("w8isEnabled");
        var w8beepInTheMiddle = Application.Properties.getValue("w8beepInTheMiddle");   
        workout8 = new WorkoutElement("spider plank", Rez.Drawables.Plank7, w8index, w8isEnabled, w8beepInTheMiddle);

	    workouts = [
            workout1,
            workout2,
            workout3,
            workout4,
            workout5,
            workout6,
            workout7,
            workout8
            ];
	}
            
    function reorderWorkouts() {
        var workoutsnew = [];

        for( var n = 1; n <= workouts.size(); n += 1 ) {
            for( var i = 0; i < workouts.size(); i += 1 ) {
                if( workouts[i].index == n )
                {
                    workoutsnew.add(workouts[i]);
                }
            }
        }       
        workouts = workoutsnew;
    }
}