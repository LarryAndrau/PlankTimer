using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;
using Toybox.Application;
using Toybox.UserProfile;
using Toybox.Timer;

class WorkoutsMenuDelegate extends Ui.Menu2InputDelegate  {
    hidden var mgr;

    function initialize(mgr) {
        Menu2InputDelegate.initialize();
        self.mgr = mgr;
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onSelect(item){
        var itemId = item.getId();
       
        var wMenu = new ElementMenu(self.mgr, itemId);
        var wdMenu = new ElementMenuDelegate(self.mgr, itemId);
        Ui.pushView(wMenu, wdMenu, Ui.SLIDE_IMMEDIATE );     

/*        if(itemId.equals("saveItem")){
            session.save();             
            Ui.pushView( new MessageView("workout", "saved"), new MessageDelegate(callBack), WatchUi.SLIDE_UP);               
   	    } else if (itemId.equals("resumeItem")) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
   	    } else if (itemId.equals("discardItem")) {
            session.discard();
            Ui.pushView( new MessageView("workout", "discarded"), new MessageDelegate(callBack), WatchUi.SLIDE_UP);        
   	    }   */
    }     
}
