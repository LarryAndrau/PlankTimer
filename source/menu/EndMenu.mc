using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class EndMenu extends Ui.Menu2 {

    function initialize() {
        Menu2.initialize({});

        self.setTitle( App.loadResource( Rez.Strings.EndMenuTitle ) as String );
        self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.EndMenuSave ), null, "saveItem", null) );
        self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.EndMenuDiscard ), null, "discardItem", null) );
    }
}