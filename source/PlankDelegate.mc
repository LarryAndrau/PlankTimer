using Toybox.ActivityRecording;
using Toybox.Lang;
using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;

var sec_current;
var session = null;
var myTimer;

class PlankDelegate extends WatchUi.BehaviorDelegate {
    hidden var mgr;
    hidden var currentWorkout;    
    hidden var repeatTimes;

    function initialize(mgr) {
        BehaviorDelegate.initialize();
        self.mgr = mgr;
        myTimer = new Timer.Timer();
        repeatTimes = Application.Properties.getValue("repeat");
    }

    function pause(){
        session.stop();
        myTimer.stop();
    }

    function resume(){
        session.start();
        myTimer.start(method(:timerCallback), 1000, true);
     }

    function onMenu() as Boolean {
        //pause();
        WatchUi.pushView( new MainMenu(), new MainMenuDelegate(mgr), WatchUi.SLIDE_UP);
        return true;
    }

    function onReturnAfterPause(){
        mgr.restart();
        currentWorkout = mgr.getCurrentWorkout();
        sec_current = currentWorkout.time();
        myTimer.start(method(:timerCallback), 1000, true);
    }

    function timerCallback() {
        if(isShowPlay){
            isShowPlay = false;
            mgr.startBuzz();
        }

        if(sec_current > 0){
            if(sec_current <= 6 && !mgr.getCurrentWorkout().isRestMode){
                mgr.beep();
            }
            sec_current -= 1;
        }else{
            myTimer.stop();
            //session.addLap();
            if(!mgr.isFinish()){
                mgr.moveNext();
                currentWorkout = mgr.getCurrentWorkout();
                sec_current = currentWorkout.time();
                //if(session != null && session.isRecording()){
                    myTimer.start(method(:timerCallback), 1000, true);
                //}
            }
            else{
                repeatTimes -= 1;
                if(repeatTimes > 0){
                    session.addLap();
                    System.println("repeatTimes: " + repeatTimes);
                    var callBack = self.method(:onReturnAfterPause);
                    WatchUi.pushView( new MessageView("Press Start", "to continue"), new MessageDelegate(callBack), WatchUi.SLIDE_UP);
                }else{
                    session.stop(); 
                    System.println("stop recording");
                    WatchUi.pushView( new EndMenu(), new EndMenuDelegate(), WatchUi.SLIDE_UP);
                }
            }
        }
        WatchUi.requestUpdate();
    }

    function onBack(){
        System.println("onBack");  
        //var message = "Stop and quit?";
        //var dialog = new WatchUi.Confirmation(message);
        WatchUi.pushView(
            new CancelConfirmationMenu(),
            new CancelConfirmationDelegate(),
            WatchUi.SLIDE_IMMEDIATE
        );     
        return true;
    }

    function onSelect() { 
        System.println("onSelect");
        
        if (Toybox has :ActivityRecording) { 
            if ((session == null) || (session.isRecording() == false)) { 
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
// todo: pause ???
//                session.stop();

            }
        }
        return true;
    }
}

