package;

import openfl.display.Stage;
import openfl.system.Capabilities;

class Utils 
{
	static public var stage: Stage;
	
	static public function dpiScale(value: Float): Float
	{
		var density: Float = stage.window.display.dpi;
		trace(density);
		return value * (density / 96);
	}
}