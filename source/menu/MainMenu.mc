using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class MainMenu extends Ui.Menu2 {
    hidden var plankTimeItem;
    hidden var restTimeItem;
    hidden var repeatTimesItem;
    hidden var workoutsItem;

    function initialize() {
        Menu2.initialize({});

        self.setTitle( App.loadResource( Rez.Strings.MainMenuTitle ) as String );
        plankTimeItem = new Ui.MenuItem( App.loadResource( Rez.Strings.MainMenuPlank ), null, "plankTimeItem", null);
        self.addItem( plankTimeItem );
        restTimeItem = new Ui.MenuItem( App.loadResource( Rez.Strings.MainMenuRest ), null, "restTimeItem", null);
        self.addItem( restTimeItem );
        repeatTimesItem = new Ui.MenuItem( App.loadResource( Rez.Strings.MainMenuRepeat ), null, "repeatTimesItem", null);
        self.addItem( repeatTimesItem );       
        workoutsItem = new Ui.MenuItem( App.loadResource( Rez.Strings.EditWorkouts ), null, "workoutsItem", null);
        self.addItem( workoutsItem );       
    }

    function onShow() {
        refreshSubLabels();
        Menu2.onShow();
    }

    function refreshSubLabels() {
        plankTimeItem.setSubLabel( App.Properties.getValue("plankTime").toString() + " sec" );
        restTimeItem.setSubLabel( App.Properties.getValue("restTime").toString() + " sec" );
        repeatTimesItem.setSubLabel( App.Properties.getValue("repeat").toString() + " times" );
    }
}