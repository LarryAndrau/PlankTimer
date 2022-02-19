using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;
using Toybox.Application;
using Toybox.UserProfile;
using Toybox.Timer;

class ElementMenuDelegate extends Ui.Menu2InputDelegate  {
    hidden var mgr;
    hidden var index;

    function initialize(mgr, index) {
        Menu2InputDelegate.initialize();
        self.mgr = mgr;
        self.index = index;
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onSelect(item){
        var itemId = item.getId();
        if(itemId.equals("enabled")){
            var currentItem = item as ToggleMenuItem;
   	        self.mgr.getWorkoutByIndex(self.index).isEnabled = currentItem.isEnabled();
        } else if (itemId.equals("beep")) {
   	    } else if (itemId.equals("index")) {
   	    }
    }     
}
