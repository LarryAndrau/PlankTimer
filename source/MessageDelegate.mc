using Toybox.ActivityRecording;
using Toybox.Lang;
using Toybox.Application;
using Toybox.WatchUi as Ui;
using Toybox.Timer;

class MessageDelegate extends Ui.BehaviorDelegate {
	
    hidden var callBack;

    function initialize(callBack) {
        BehaviorDelegate.initialize();
        self.callBack = callBack;
    }

    function onSelect() { 
        callBack.invoke();
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        return true;
    }

    function onBack(){
        callBack.invoke();
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        return true;        
    }
}

