using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;

class WorkoutElement {
    var name;
    var icon;
	var isRestMode = false;	
    	
    function initialize (name, icon, isrest) {
		self.name = name;	
		self.icon = icon;
		self.isRestMode = isrest;
	}

	function setRestMode(isRestMode){
		self.isRestMode = isRestMode;	
	}

	function time(){
		if(isRestMode){
			return Application.Properties.getValue("restTime");
		}
		return Application.Properties.getValue("plankTime");
	}

	function color(){
		return isRestMode ? Gfx.COLOR_GREEN : Gfx.COLOR_RED;
	}

}