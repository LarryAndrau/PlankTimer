using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class WorkoutsMenu extends Ui.Menu2 {
    hidden var mgr;

    function initialize(mgr) {
        Menu2.initialize({});
        self.mgr = mgr;

        self.setTitle( App.loadResource( Rez.Strings.EditWorkouts ) as String );
        for( var i = 0; i <  mgr.size(); i += 1 ) {
            self.addItem( new Ui.MenuItem( mgr.getWorkoutByIndex(i).name, null, i , null) );
        }
    }
        
    function onHide() as Void {
        mgr.saveWorkouts();
    }
}