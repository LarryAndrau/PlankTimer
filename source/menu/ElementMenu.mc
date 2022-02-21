    using Toybox.WatchUi as Ui;
    using Toybox.Application as App;

    class ElementMenu extends Ui.Menu2 {
        hidden var currentItem;
        hidden var mgr;

        function initialize(mgr, index) {
            Menu2.initialize({});
            self.mgr = mgr;
            currentItem = mgr.getWorkoutByIndex(index);
            self.setTitle( currentItem.name as String );
            self.addItem( new Ui.ToggleMenuItem( App.loadResource( Rez.Strings.ElementMenuEnabled ), null, "enabled", currentItem.isEnabled, null) );
            self.addItem( new Ui.ToggleMenuItem( App.loadResource( Rez.Strings.ElementMenuBeep ), null, "beep", currentItem.beepInTheMiddle, null) );
            self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.ElementMenuIndex ), (index + 1).toString(), "index", null) );
            Application.Properties.setValue("index", currentItem.index);
        }
        
        function onShow() {
            var newVal = Application.Properties.getValue("index");
            var item = self.getItem(2);
            item.setSubLabel(newVal.toString());
            var tmpItem = mgr.getWorkoutByIndex(newVal-1);
            tmpItem.index = currentItem.index;
            currentItem.index = newVal;
            mgr.saveWorkouts();
        }
    }