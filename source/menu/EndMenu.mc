using Toybox.WatchUi as Ui;

//! Main menu for CIQ3 devices
//! Replaces old resource menus/main.xml
class EndMenu extends Ui.Menu2 {
    hidden var resumeItem;
    hidden var saveItem;
    hidden var discardItem;
    
    hidden var time;

    function initialize() {
        Menu2.initialize({});

        var label;
        var title = "Save workout";
        self.setTitle(title);
 
        label = "Resume";
        resumeItem = new Ui.MenuItem(label, null, "resumeItem", null);
//        self.addItem(resumeItem);

        label = "Save";
        saveItem = new Ui.MenuItem(label, null, "saveItem", null);
        self.addItem(saveItem);

        label = "Discard";
        discardItem = new Ui.MenuItem(label, null, "discardItem", null);
        self.addItem(discardItem);
    }
}