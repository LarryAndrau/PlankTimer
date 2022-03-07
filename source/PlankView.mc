using Toybox.ActivityRecording;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.Lang as Lang;

var isShowPlay = false;

class PlankView extends Ui.View {

	var isFirstTime = true;	

	hidden var smallFont;
	hidden var mgr;
	hidden var plankDelegate;
	hidden var sec_total;

    function initialize(mgr, plankDelegate) {
        View.initialize();
    	smallFont = Ui.loadResource(Rez.Fonts.SmallFont);
		self.mgr = mgr;
		self.plankDelegate = plankDelegate;
		sec_total = Application.Properties.getValue("plankTime");
		sec_current = sec_total;
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
        if(onPause){
			plankDelegate.resume();
        }
		if(session == null){
	        sec_total = Application.Properties.getValue("plankTime");
	        sec_current = sec_total;
			mgr.loadWorkouts();
		}
	
		WatchUi.requestUpdate();
    }

    function onHide() as Void {
        if(!onPause){
			plankDelegate.pause();
        }
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

		if (mgr.getCurrentWorkout().isRestMode) {
			dc.drawText(dc.getWidth()/2, dc.getHeight()*0.175 + 30, Gfx.FONT_SYSTEM_LARGE,
				"next",
				Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);
        } else {
			dc.drawText(dc.getWidth()/2, dc.getHeight()*0.175 + 30, 
				Gfx.FONT_NUMBER_HOT,
			//	Gfx.FONT_SYSTEM_LARGE,
				sec_current.toString(),
				Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);
		}		


		//dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
  	    
		dc.drawText(
			dc.getWidth()/2, 
			dc.getWidth()*0.825 - 20, 
			Gfx.FONT_SMALL, 
			mgr.getCurrentWorkout().name,
		    Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);
  	    
		dc.drawText(
			dc.getWidth()/2, 
			dc.getWidth()*0.825 + 7, 
			Gfx.FONT_SMALL, 
			(mgr.getDisplayIndex()+1).toString() + "/" + mgr.enabledSize(),
		   	Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_CENTER);

		var image = Application.loadResource( mgr.getCurrentWorkout().icon ) as BitmapResource;
		dc.drawBitmap( dc.getWidth()/2 - 75, dc.getWidth()/2 - 20 , image );

		if (isShowPlay) {
			var playImage = Application.loadResource( Rez.Drawables.PlayIcon ) as BitmapResource;
			dc.drawBitmap( dc.getWidth()/2 - 40, dc.getWidth()/2 - 50, playImage );
        }
    }

    function drawArc(dc, counter, max, thin){
    	var cx =  dc.getWidth() / 2;
    	var cy = dc.getWidth() / 2;
		dc.setPenWidth(thin);
		var arcColor = mgr.getCurrentWorkout().color();
		dc.setColor( arcColor, Gfx.COLOR_TRANSPARENT );
				
       	var angle = 0;
       	if(counter > 0){
       		angle = counter * 360 / max;
       	}
       	if(angle > 0){
       		dc.drawArc( cx, cy, dc.getWidth()/2-thin/2, Gfx.ARC_CLOCKWISE, 90, (360-angle.toLong()+90)%360); 
       	}
    }
}
