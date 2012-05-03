package
{
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class Game extends Sprite
	{
		private var customSprite:CustomSprite;
		private var mouseX:Number = 0; 
		private var mouseY:Number = 0;
		
		public function Game() 
		{ 
			addEventListener(Event.ADDED_TO_STAGE, onAdded); 
		}
		
		private function onAdded ( e:Event ):void 
		{
			customSprite = new CustomSprite(100, 200);
			// positions it by default in the center of the stage 
			// we add half width because of the registration point of the custom sprite (middle) 
			customSprite.x = (stage.stageWidth - customSprite.width >> 1 ) + (customSprite.width >> 1); 
			customSprite.y = (stage.stageHeight - customSprite.height >> 1) + (customSprite.height >> 1);
			// show it 
			addChild(customSprite);
			// we listen to the mouse movement on the stage 
			stage.addEventListener(TouchEvent.TOUCH, onTouch); 
			// need to comment this one ? ;) 
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			// when the sprite is touched
			customSprite.addEventListener(TouchEvent.TOUCH, onTouchedSprite);
		}
		
		private function onTouchedSprite(e:TouchEvent):void
		{
/*			// get the touch points (can be multiple because of multitouch) 
			var touch:Touch = e.getTouch(stage);
			var clicked:DisplayObject = e.currentTarget as DisplayObject; 
			// detect the click/release phase 
			if ( touch.phase == TouchPhase.ENDED ) 
			{ 
				// remove the clicked object 
				removeChild(clicked, true);
				trace(clicked.hasEventListener(e.type));
			}*/
			// retrieves the touch points 
//			var touches:Vector.<Touch> = e.touches; 
			var touches:Vector.<Touch> = e.getTouches(stage);
			// if two fingers 
			if ( touches.length == 2 ) 
			{ 
				var finger1:Touch = touches[0]; 
				var finger2:Touch = touches[1]; 
				var distance:int; 
				var preDistance:int;
				var dx:int; var dy:int; 
				// if both fingers moving (dragging) 
				if ( finger1.phase == TouchPhase.MOVED && finger2.phase == TouchPhase.MOVED ) 
				{ 
					// calculate the distance between each axes 
					dx = Math.abs ( finger1.globalX - finger2.globalX ); 
					dy = Math.abs ( finger1.globalY - finger2.globalY ); 
					// calculate the distance 
					distance = Math.sqrt(dx*dx+dy*dy); 
					trace ( distance );
					dx = Math.abs(finger1.previousGlobalX - finger2.previousGlobalX);
					dy = Math.abs(finger1.previousGlobalY - finger2.previousGlobalY);
					preDistance = Math.sqrt(dx*dx + dy*dy);
					
					if(distance!=preDistance)
					{
						customSprite.scaleX = customSprite.scaleY = distance/preDistance;
					}
				} 
			}
		}
		
		private function onTouch(e:TouchEvent):void
		{
			// get the mouse location related to the stage 
			var touch:Touch = e.getTouch(stage); 
			var pos:Point = touch.getLocation(stage); 
			// store the mouse coordinates 
			mouseX = pos.x; 
			mouseY = pos.y;
		}
		
		private function onFrame(e:Event):void
		{
			// easing on the custom sprite position 
			customSprite.x -= ( customSprite.x - mouseX ) * .1; 
			customSprite.y -= ( customSprite.y - mouseY ) * .1;
			// we update our custom sprite 
			customSprite.update();
		}
	}
}