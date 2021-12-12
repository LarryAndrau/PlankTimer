using Toybox.WatchUi as Ui;

//! Main menu for CIQ3 devices
//! Replaces old resource menus/main.xml
class MainMenu extends Ui.Menu2 {
    hidden var plankTimeItem;
    hidden var restTimeItem;
    hidden var repeatTimesItem;
    
    hidden var time;

    function initialize() {
        Menu2.initialize({});

        var label;
        var title = "Settings";
        self.setTitle(title);
 
        label = "Plank time";
        plankTimeItem = new Ui.MenuItem(label, null, "plankTimeItem", null);
        self.addItem(plankTimeItem);

        label = "Rest time";
        restTimeItem = new Ui.MenuItem(label, null, "restTimeItem", null);
        self.addItem(restTimeItem);

        label = "Repeat";
        repeatTimesItem = new Ui.MenuItem(label, null, "repeatTimesItem", null);
        self.addItem(repeatTimesItem);       
    }

    function onShow() {
        refreshSubLabels();
        Menu2.onShow();
    }

    function refreshSubLabels() {
        var subLabel;

        time = Application.Properties.getValue("plankTime");
        subLabel = time.toString() + " sec";
        plankTimeItem.setSubLabel(subLabel);

        time = Application.Properties.getValue("restTime");
        subLabel = time.toString() + " sec";
        restTimeItem.setSubLabel(subLabel);

        time = Application.Properties.getValue("repeat");
        subLabel = time.toString() + " times";
        repeatTimesItem.setSubLabel(subLabel);
    }
}