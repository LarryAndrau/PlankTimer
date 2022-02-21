using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;
using Toybox.Application;
using Toybox.UserProfile;

//https://bitbucket.org/obagot/connectiq-hict/src/master/source/ExerciseDurationPickerDelegate.mc

class MainMenuDelegate extends Ui.Menu2InputDelegate  {
	hidden var time;
    hidden var mgr;
    var myPicker;
    var myValue = 0;

    function initialize(mgr) {
        Menu2InputDelegate.initialize();
        self.mgr = mgr;
    }
      
    function switchToMainMenu(){
        System.println("myValue:" + time.toString());
    }

    function onMenuItem(item){
        System.println("onMenu");
    }

    function onSelect(item){
        var itemId = item.getId();
        if(itemId.equals("plankTimeItem")){
            time = Application.Properties.getValue("plankTime");
            var roundsPicker = new SettingPickerView("Plank", [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90], time/5 - 1);
            var roundsPickerDelegate = new SettingPickerDelegate("plankTime", self.method(:switchToMainMenu));
            Ui.pushView(roundsPicker, roundsPickerDelegate, Ui.SLIDE_IMMEDIATE );
   	    } else if (itemId.equals("restTimeItem")) {
            time = Application.Properties.getValue("restTime");
            var roundsPicker = new SettingPickerView("Rest", [0,1,2,3,4,5,6,7,8,9,10], time);
            var roundsPickerDelegate = new SettingPickerDelegate("restTime", self.method(:switchToMainMenu));
            Ui.pushView(roundsPicker, roundsPickerDelegate, Ui.SLIDE_IMMEDIATE );
   	    } else if (itemId.equals("repeatTimesItem")) {
            time = Application.Properties.getValue("repeat");
            var roundsPicker = new SettingPickerView("Repeat", [1,2,3,4,5], time - 1);
            var roundsPickerDelegate = new SettingPickerDelegate("repeat", self.method(:switchToMainMenu));
            Ui.pushView(roundsPicker, roundsPickerDelegate, Ui.SLIDE_IMMEDIATE );
        } else if (itemId.equals("workoutsItem")) {
            var wMenu = new WorkoutsMenu(self.mgr);
            var wdMenu = new WorkoutsMenuDelegate(self.mgr);
            Ui.pushView(wMenu, wdMenu, Ui.SLIDE_IMMEDIATE );
        }
        
    }     
}