using Toybox.Application;
using Toybox.Lang;
using Toybox.WatchUi;
using Toybox.Sensor;

class PlankApp extends Application.AppBase {

	hidden var mgr;

    function initialize() {
        AppBase.initialize();
        Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
        mgr = new WorkoutManager();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
                System.println("onStart");
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
                System.println("onStop");
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var plankDelegate = new PlankDelegate(mgr);
        return [ new PlankView(mgr, plankDelegate), plankDelegate ] as Array<Views or InputDelegates>;
    }
}

function getApp() as PlankApp {
    return Application.getApp() as PlankApp;
}