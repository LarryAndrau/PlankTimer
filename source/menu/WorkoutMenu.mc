using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class WorkoutMenu extends Ui.Menu2 {

    function initialize() {
        Menu2.initialize({});

        self.setTitle( App.loadResource( Rez.Strings.CancelMenuTitle ) as String );
        self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.MenuYes ), null, "MenuYes", null) );
        self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.MenuNo ), null, "MenuNo", null) );
    }
}