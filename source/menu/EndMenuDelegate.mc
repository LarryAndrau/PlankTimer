using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;
using Toybox.Application;
using Toybox.UserProfile;
using Toybox.Timer;

class EndMenuDelegate extends Ui.Menu2InputDelegate  {
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
        if(itemId.equals("saveItem")){
            session.save();             
            myEndTimer.start(method(:timerCallback), 5000, true);       
            Ui.pushView( new MessageView("workout", "saved"), new MessageDelegate(callBack), WatchUi.SLIDE_UP);               
   	    } else if (itemId.equals("resumeItem")) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
   	    } else if (itemId.equals("discardItem")) {
            session.discard();
            myEndTimer.start(method(:timerCallback), 5000, true);
            Ui.pushView( new MessageView("workout", "discarded"), new MessageDelegate(callBack), WatchUi.SLIDE_UP);        
   	    }   
    }     
}
