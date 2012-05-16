package
{
	import flash.display.Sprite;
	
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.core.IInjector;
	
	public class RobotlegsExample extends Sprite
	{
		public function RobotlegsExample()
		{
			var injector:IInjector = new SwiftSuspendersInjector();
//			injector.mapClass(Sprite, Sprite);
//			var sprite1:Sprite = injector.getInstance(Sprite);
//			var sprite2:Sprite = injector.getInstance(Sprite);
//			trace('identical=' + (sprite1 === sprite2));
			
			var spr5:Sprite = new Sprite();
			
			// Map as Value
			injector.mapValue(Sprite, spr5);
			
			var spr6:Sprite = injector.getInstance(Sprite);
			var spr7:Sprite = injector.getInstance(Sprite);
			
			trace('identical=' + (spr5 == spr6 && spr6 == spr7 && spr7 == spr5));
		}
	}
}