package puzzlegame.input
{
	import flash.geom.Point;
	
	import puzzlegame.GameData;
	import puzzlegame.graphics.BlockView;
	import puzzlegame.texture.BlockConst;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class MouseInput
	{	
		public var touch:Touch;
		
		private var displayObj:DisplayObject
		
		public function MouseInput(displayObj:DisplayObject)
		{
			this.displayObj = displayObj;
			displayObj.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			touch = e.getTouch(displayObj);
			return;
			//TODO 后面是临时测试的代码，须去除
			if(!touch) return;
//			if(touch.phase == TouchPhase.ENDED && (e.target is Image))
//			{
				//					trace(e.currentTarget, e.target);
//				((e.target as Image).parent as BlockView).addFrame();
//			}
			if(touch.phase == TouchPhase.MOVED && (e.target is Image))
			{
//				trace((e.target as Image).name);
				var view:BlockView = (e.target as Image).parent as BlockView;
//				var point:Point = GameData.blockTypeArray2.getPoint(view);
//				var upview:BlockView = GameData.blockTypeArray2.get(point.x, point.y-1) as BlockView;
//				trace(point);
//				trace("up:", e.interactsWith(upview));
//				trace("current:", e.interactsWith(view));
				
				var point:Point = touch.getLocation(touch.target as Image);
				point.offset(-BlockConst.SIDE_LENGTH/2, -BlockConst.SIDE_LENGTH/2);
				trace(point);
				view.addFrame();
//				trace(touch.getMovement(e.target as Image));
//				trace(touch.getLocation(e.target as Image));
//				trace(e.interactsWith(displayObj));
			}
		}
	}
}