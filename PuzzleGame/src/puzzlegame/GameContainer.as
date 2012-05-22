package puzzlegame
{
	import puzzlegame.graphics.BlockView;
	import puzzlegame.texture.BlockTexture;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameContainer extends Sprite
	{
		public function GameContainer()
		{
			//初始block的纹理
			BlockTexture.getInstance();
			
//			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
/*		private function onAdded(e:Event):void
		{
			stage.addEventListener(TouchEvent.TOUCH, onClick);			
		}
		
		private function onClick(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(this);
			var clicked:DisplayObject = e.currentTarget as DisplayObject;
			if(touches.length == 1)
			{
				var touch:Touch = touches[0];
				if(touch.phase == TouchPhase.ENDED)
				{
//					trace(e.currentTarget, e.target);
					((e.target as Image).parent as BlockView).addFrame();
				}
			}
		}*/
	}
}