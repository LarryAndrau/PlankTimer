using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.Attention;
using Toybox.Lang;

class WorkoutManager {

    hidden var currentIndex = 0;
    hidden var workouts as Lang.Array<WorkoutElement>;
    hidden var isRestMode = false;

    function initialize() {

	    workouts = [
            new WorkoutElement("basic plank", Rez.Drawables.PlankSimple, false, 1),
            new WorkoutElement("left plank", Rez.Drawables.PlankNorm, false, 2),
            new WorkoutElement("right plank", Rez.Drawables.PlankNormc, false, 3),
            new WorkoutElement("revers plank", Rez.Drawables.PlankNorm, false, 4),
            new WorkoutElement("corner plank", Rez.Drawables.PlankNormc, false, 5),
            new WorkoutElement("boat plank", Rez.Drawables.PlankNorm, false, 6),
            new WorkoutElement("spider move", Rez.Drawables.PlankNorm, false, 7),
            new WorkoutElement("spider plank", Rez.Drawables.PlankNormc, false, 8)
            ];
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

    function getCurrentWorkout()
    {        
        if(!workouts[currentIndex].isEnabled){
            currentIndex = currentIndex + 1;
        }
        return workouts[currentIndex];
    }

    function getWorkoutByIndex(index)
    {
        return workouts[index];
    }

    function isFinish()
    {
        var isFinish = currentIndex >= (workouts.size()-1) && !workouts[currentIndex].isRestMode;
        if (isFinish){
            endBuzz();
        }
        return isFinish;
    }

    function restart()
    {
	    isRestMode = false;
        currentIndex = 0;
        workouts[currentIndex].setRestMode(isRestMode);
    }
    
    function moveNext()
    {
	    isRestMode = !isRestMode;
        if(isRestMode){
            currentIndex = currentIndex + 1;
            stopBuzz();
        }else{
            startBuzz();
        }
        workouts[currentIndex].setRestMode(isRestMode);
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
    
    function vibrate(duration) {
		if(Attention has :vibrate){
			var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
			Attention.vibrate( vibrateData );
		}
	}
}