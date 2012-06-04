package puzzlegame.components
{
	import puzzlegame.graphics.BlockView;
	
	import starling.display.DisplayObject;
	
	public class Display
	{
		//todo 目前的现实对象都是blockView
		public var displayObject:BlockView = null;
		
		public function Display(displayObject:BlockView)
		{
			this.displayObject = displayObject;
		}
	}
}
