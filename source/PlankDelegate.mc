using Toybox.ActivityRecording;
using Toybox.Lang;
using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;

var sec_current;
var session = null;
var myTimer;
var onPause = false;

class PlankDelegate extends WatchUi.BehaviorDelegate {
    hidden var mgr;
    //hidden var currentWorkout;    

    function initialize(mgr) {
        BehaviorDelegate.initialize();
        self.mgr = mgr;
        myTimer = new Timer.Timer();
    }

    function pause(){
		if((session != null) && session.isRecording()){
	        session.stop();
    	    myTimer.stop();
	        onPause = true;
		}
    }

    function resume(){
		if(onPause){
	        session.start();
	        myTimer.start(method(:timerCallback), 1000, true);
        	onPause = false;
		}
    }

    function onMenu() as Boolean {
        WatchUi.pushView( new MainMenu(), new MainMenuDelegate(mgr), WatchUi.SLIDE_UP);
        return true;
    }

    function timerCallback() {
        if(isShowPlay){
            isShowPlay = false;
            mgr.startBuzz();
        }
        mgr.oneSecondProcessing(method(:timerCallback));
        WatchUi.requestUpdate();
    }

    function onBack(){
        System.println("onBack");
        if(session == null){
            System.exit();
        }
        if(session != null && session.isRecording()){
            WatchUi.pushView(
                new EndMenu(mgr),
                new EndMenuDelegate(mgr),
                WatchUi.SLIDE_IMMEDIATE
            );     
        }  
        return true;
    }

    function onSelect() { 
        System.println("onSelect");

        if (Toybox has :ActivityRecording) { 
            if ((session == null) || (!session.isRecording())) { 
                isShowPlay = true;
                WatchUi.requestUpdate();
                session = ActivityRecording.createSession({ 
                    :name => "Plank workout", 
                    :sport => ActivityRecording.SPORT_TRAINING, 
                    :subSport => ActivityRecording.SUB_SPORT_STRENGTH_TRAINING
                });
                session.start();
                myTimer.start(method(:timerCallback), 1000, true);       
                System.println("start recording");
            } else if ((session != null) && session.isRecording()) {
                WatchUi.pushView(
                    new EndMenu(mgr),
                    new EndMenuDelegate(mgr),
                    WatchUi.SLIDE_IMMEDIATE
                );     
            }
        }
        return true;
    }
}

