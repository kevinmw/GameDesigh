package
{
	import flash.display.Bitmap;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	public class Game2 extends Sprite
	{
		private var sausagesVector:Vector.<CustomImage> = new Vector.<CustomImage>(NUM_SAUSAGES, true);
		private const NUM_SAUSAGES:uint = 400;
		
		[Embed(source="assets/particle_smallest.png")]
		private static const Sausage:Class;
		
		public function Game2()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			var sausageBitmap:Bitmap = new Sausage();
			var texture:Texture = Texture.fromBitmap(sausageBitmap, false);
			for(var i:int=0;i<NUM_SAUSAGES;i++)
			{
				// create a Image object with our one texture
				var image:CustomImage = new CustomImage(texture); 
				// set a random alpha, position, rotation 
				image.alpha = Math.random(); 
				// define a random initial position 
				image.x = Math.random()*stage.stageWidth;
				image.y = Math.random()*stage.stageHeight;
				image.rotation = deg2rad(Math.random()*360); 
				// show it 
				addChild(image); 
				// store references for later 
				sausagesVector[i] = image;
			}
			// main loop 
//			stage.addEventListener(Event.ENTER_FRAME, onFrame);
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
					trace(e.currentTarget, e.target);
					(e.target as DisplayObject).dispose();
				}
			}
		}
		
		private function onFrame(e:Event):void
		{
			var lng:uint = sausagesVector.length; 
			for (var i:int = 0; i < lng; i++) 
			{
				// move the sausages around 
				var sausage:CustomImage = sausagesVector[i] as CustomImage; 
				sausage.x -= ( sausage.x - sausage.destX ) * .1;
				sausage.y -= ( sausage.y - sausage.destY ) * .1; 
				// when reached destination 
				if ( Math.abs ( sausage.x - sausage.destX ) < 1 && Math.abs ( sausage.y - sausage.destY ) < 1) 
				{ 
					sausage.destX = Math.random()*stage.stageWidth; 
					sausage.destY = Math.random()*stage.stageWidth; 
					sausage.rotation = deg2rad(Math.random()*360); 
				} 
			}
		}
	}
}