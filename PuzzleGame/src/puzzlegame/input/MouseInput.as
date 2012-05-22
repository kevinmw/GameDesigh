package puzzlegame.input
{
	import puzzlegame.graphics.BlockView;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class MouseInput
	{
		private var displayObj:DisplayObject
		
		public function MouseInput(displayObj:DisplayObject)
		{
			this.displayObj = displayObj;
			displayObj.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(displayObj);
			var clicked:DisplayObject = e.currentTarget as DisplayObject;
			if(touch.phase == TouchPhase.ENDED && (e.target is Image))
			{
				//					trace(e.currentTarget, e.target);
				((e.target as Image).parent as BlockView).addFrame();
			}
			if(touch.phase == TouchPhase.MOVED)
			{
				trace("move");
			}
		}
	}
}