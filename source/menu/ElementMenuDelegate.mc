using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;
using Toybox.Application;
using Toybox.UserProfile;
//using Toybox.Timer;

class ElementMenuDelegate extends Ui.Menu2InputDelegate  {
    hidden var mgr;
    hidden var index;
    hidden var newIndex;

    function initialize(mgr, index) {
        Menu2InputDelegate.initialize();
        self.mgr = mgr;
        self.index = index;
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function switchToMainMenu(){
        var newVal = Application.Properties.getValue("index");
        System.println("myValue:" + newVal.toString());
    }

    function onSelect(item){
        var itemId = item.getId();
        if(itemId.equals("enabled")){
            var currentItem = item as ToggleMenuItem;
   	        self.mgr.getWorkoutByIndex(self.index).isEnabled = currentItem.isEnabled();
        } else if (itemId.equals("beep")) {
            var currentItem = item as ToggleMenuItem;
   	        self.mgr.getWorkoutByIndex(self.index).beepInTheMiddle = currentItem.isEnabled();
   	    } else if (itemId.equals("index")) {

            var array = new [self.mgr.size()];
            for( var i = 0; i < self.mgr.size(); i += 1 ) {
                array[i] = i + 1;
            }
            newIndex = self.index;
            System.println("newIndex:" + newIndex.toString());
            var roundsPicker = new SettingPickerView("Index", array, newIndex);
            var roundsPickerDelegate = new SettingPickerDelegate("index", self.method(:switchToMainMenu));
            Ui.pushView(roundsPicker, roundsPickerDelegate, Ui.SLIDE_IMMEDIATE );
   	    }
    }     
}
