using Toybox.ActivityRecording;
using Toybox.Lang;
using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;

var sec_current;

class PlankDelegate extends WatchUi.BehaviorDelegate {
	
    hidden var session = null;
    hidden var myTimer;
    hidden var mgr;
    hidden var currentWorkout;

    function initialize(mgr) {
        BehaviorDelegate.initialize();
        self.mgr = mgr;
        myTimer = new Timer.Timer();
    }

    function onMenu() as Boolean {
        WatchUi.pushView( new MainMenu(), new MainMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function timerCallback() {
        if(sec_current > 0){
            if(sec_current < 6 && !mgr.getCurrentWorkout().isRestMode){
                mgr.beep();
            }
            sec_current -= 1;
        }else{
            myTimer.stop();
            if(!mgr.isFinish()){
                mgr.moveNext();
                currentWorkout = mgr.getCurrentWorkout();
                sec_current = currentWorkout.time();
                myTimer.start(method(:timerCallback), 1000, true);
            }
        }
        WatchUi.requestUpdate();
    }

    function onBack(){
        System.println("onBack");       
    }

// use the select Start/Stop or touch for recording 
    function onSelect() { 
        System.println("onSelect");
        
        if (Toybox has :ActivityRecording) { 
            // check device for activity recording 
            if ((session == null) || (session.isRecording() == false)) { 
                session = ActivityRecording.createSession({ 
                    // set up recording session 
                    :name=>"Plank workout", 
                    // set session name 
                    :sport=>ActivityRecording.SPORT_TRAINING, 
                    // set sport type 
                    :subSport=>ActivityRecording.SUB_SPORT_STRENGTH_TRAINING // set sub sport type 
                });
                session.start(); // call start session 
                myTimer.start(method(:timerCallback), 1000, true);
                
                System.println("start recording");
            } else if ((session != null) && session.isRecording()) {
                session.stop(); // stop the session 
                System.println("stop recording");
                session.save(); // save the session 
                session = null; // set session control variable to null 
            }
        }
        return true; // return true for onSelect function 
    }
}

