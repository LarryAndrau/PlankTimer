using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.Attention;
using Toybox.Lang;

class WorkoutManager {

    var currentIndex = 0;
    var workouts as Lang.Array<WorkoutElement>;

    hidden var isRestMode = false;

    function initialize() {

	    workouts = [
            new WorkoutElement("basic plank", Rez.Drawables.PlankNormc, false),
            new WorkoutElement("left plank", Rez.Drawables.PlankNorm, false),
            new WorkoutElement("right plank", Rez.Drawables.PlankNormc, false),
            new WorkoutElement("revers plank", Rez.Drawables.PlankNorm, false),
            new WorkoutElement("corner plank", Rez.Drawables.PlankNormc, false),
            new WorkoutElement("boat plank", Rez.Drawables.PlankNorm, false),
            new WorkoutElement("spider move", Rez.Drawables.PlankNorm, false),
            new WorkoutElement("spider plank", Rez.Drawables.PlankNormc, false)
            ];
    }
    
    function getCurrentWorkout()
    {
        return workouts[currentIndex];
    }

    function isFinish(){
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