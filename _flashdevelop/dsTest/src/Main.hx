package ;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;

/**
 * ...
 * @author kevin ni
 */

class Main 
{
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		var array2 = new de.polygonal.ds.Array2<String>(4, 4);
		array2.walk(function(val:String, x:Int, y:Int):String { return Std.string(x) + "." + Std.string(y); });
		trace(array2);
		trace("..........");
	}
	
}