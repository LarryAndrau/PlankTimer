    using Toybox.WatchUi as Ui;
    using Toybox.Application as App;

    class ElementMenu extends Ui.Menu2 {

        function initialize(mgr, index) {
            Menu2.initialize({});

            var currentItem = mgr.getWorkoutByIndex(index);
            self.setTitle( currentItem.name as String );
            self.addItem( new Ui.ToggleMenuItem( App.loadResource( Rez.Strings.ElementMenuEnabled ), null, "enabled", currentItem.isEnabled, null) );
            self.addItem( new Ui.ToggleMenuItem( App.loadResource( Rez.Strings.ElementMenuBeep ), null, "beep", currentItem.beepInTheMiddle, null) );
    //        self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.ElementMenuIndex ), null, "index", null) );
        }
    }