using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi as Ui;
using Toybox.Application;
using Toybox.UserProfile;


class EndMenuDelegate extends Ui.Menu2InputDelegate  {
	hidden var time;
    var myPicker;
    var myValue = 0;

    function initialize() {
        Menu2InputDelegate.initialize();
    }
      
    function switchToMainMenu(){
        System.println("myValue:" + time.toString());
    }

    function onMenuItem(item){
        System.println("onMenu");
    }

    function onSelect(item){
        var itemId = item.getId();
        if(itemId.equals("saveItem")){
            session.save(); 
            session = null; 
            System.exit();
   	    } else if (itemId.equals("resumeItem")) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
   	    } else if (itemId.equals("discardItem")) {
            session.discard();
            session = null; 
            System.exit();
   	    }   
    }     
}
