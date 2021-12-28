using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;
using Toybox.Application;
using Toybox.UserProfile;
using Toybox.Timer;

class CancelConfirmationDelegate extends Ui.Menu2InputDelegate  {
    hidden var myEndTimer;

    function initialize() {
        Menu2InputDelegate.initialize();
        myEndTimer = new Timer.Timer();
    }

    function timerCallback() {
        session = null; 
        System.exit();
    }

    function onSelect(item){
        var itemId = item.getId();
        var callBack = self.method(:timerCallback);
        if(itemId.equals("MenuYes")){
            if(session != null && session.isRecording()){
                session.stop();
                session.discard();
            }
            myEndTimer.start(callBack, 1000, true);
            Ui.pushView( new MessageView("workout", "discarded"), new MessageDelegate(callBack), WatchUi.SLIDE_UP);        
   	    } else if (itemId.equals("MenuNo")) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
   	    }   
    }      
}