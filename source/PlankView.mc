using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.Lang;

class PlankView extends Ui.View {

	var isFirstTime = true;	

	hidden var smallFont;
	hidden var mgr;
	hidden var sec_total;

    function initialize(mgr) {
        View.initialize();
    	smallFont = Ui.loadResource(Rez.Fonts.SmallFont);
		self.mgr = mgr;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
		sec_total = mgr.getCurrentWorkout().time();
		sec_current = sec_total;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
		if (isFirstTime) {
            isFirstTime = false;
        }
	
		sec_total = Application.Properties.getValue("plankTime");
		sec_current = sec_total;
		WatchUi.requestUpdate();
    }

    function onHide() as Void {
    }
	
	function startupTimerCallback() {
  	    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
  	    dc.clear();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
		if (isFirstTime) {
            // render the startup view (title, version, etc) here...
        }
  	    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
  	    dc.clear();
  		drawArc(dc, sec_current, mgr.getCurrentWorkout().time(), 20);
	
   	    dc.setColor(Gfx.COLOR_BLACK,Gfx.COLOR_TRANSPARENT);

		dc.drawText(dc.getWidth()/2, dc.getHeight()*0.175 + 30, Gfx.FONT_SYSTEM_LARGE,
			sec_current.toString(),
			Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);

		dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
  	    
		dc.drawText(
			dc.getWidth()/2, 
			dc.getHeight()*0.825 - 20, 
			Gfx.FONT_SMALL, 
			mgr.getCurrentWorkout().name,
		    Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);
  	    
		dc.drawText(
			dc.getWidth()/2, 
			dc.getHeight()*0.825 + 7, 
			Gfx.FONT_SMALL, 
			(mgr.currentIndex+1).toString() + "/" + mgr.workouts.size(),
		   	Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);

		var image = Application.loadResource( mgr.getCurrentWorkout().icon ) as BitmapResource;
		dc.drawBitmap( dc.getWidth()/2 - 75, dc.getHeight()/2 - 20 , image );
    }

    function drawArc(dc, counter, max, thin){
    	var cx =  dc.getWidth() / 2;
    	var cy = dc.getHeight() / 2;
		dc.setPenWidth(thin);
		var arcColor = mgr.getCurrentWorkout().color();
		dc.setColor( arcColor, Gfx.COLOR_TRANSPARENT );
				
       	var angle = 0;
       	if(counter > 0){
       		angle = counter * 360 / max;
       	}
       	if(angle > 0){
       		dc.drawArc( cx, cy, dc.getHeight()/2-thin/2, Gfx.ARC_CLOCKWISE, 90, (360-angle.toLong()+90)%360); 
       	}
    }
}
