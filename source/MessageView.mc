using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
//using Toybox.System as System;
//using Toybox.Lang;

class MessageView extends Ui.View {

	hidden var message1;
	hidden var message2;

    function initialize(message1, message2) {
        View.initialize();
    	//smallFont = Ui.loadResource(Rez.Fonts.SmallFont);
        self.message1 = message1;
        self.message2 = message2;
    }

    function onShow() as Void {
		WatchUi.requestUpdate();
    }

    function onUpdate(dc as Dc) as Void {
  	    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
  	    dc.clear();
	
   	    dc.setColor(Gfx.COLOR_BLACK,Gfx.COLOR_TRANSPARENT);

		dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/2 - 18,
            Gfx.FONT_SYSTEM_LARGE,
			message1.toString(),
			Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);

		dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/2 + 18,
            Gfx.FONT_SYSTEM_LARGE,
			message2.toString(),
			Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);
    }
}
