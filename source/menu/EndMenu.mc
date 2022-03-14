    using Toybox.WatchUi as Ui;
    using Toybox.Application as App;

    class EndMenu extends Ui.Menu2 {
        hidden var mgr;

        function initialize(mgr) {
            Menu2.initialize({});
            self.mgr = mgr;

            self.setTitle( App.loadResource( Rez.Strings.EndMenuTitle ) as String );
            if(!mgr.isFinish()){
                self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.MenuResume ), null, "resumeItem", null) );
            }
            self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.EndMenuSave ), null, "saveItem", null) );
            self.addItem( new Ui.MenuItem( App.loadResource( Rez.Strings.EndMenuDiscard ), null, "discardItem", null) );
        }
    }