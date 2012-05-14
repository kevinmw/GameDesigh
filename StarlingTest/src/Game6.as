package 
{ 
	import flash.display.Bitmap; 
	import starling.display.Image; 
	import starling.display.Sprite; 
	import starling.events.Event; 
	import starling.textures.Texture;
	import starling.utils.deg2rad; 
	public class Game6 extends Sprite 
	{ 
		private var container:Sprite;
		private static const NUM_PIGS:uint = 400; 
		[Embed(source = "assets/particle_smallest.png")] 
		private static const PigParachute:Class; 
		public function Game6() 
		{ 
			addEventListener(Event.ADDED_TO_STAGE, onAdded); 
		}
		
		private function onAdded (e:Event):void 
		{ 
			// create the container 
			container = new Sprite(); 
			// change the registration point 
			container.pivotX = stage.stageWidth >> 1;
			container.pivotY = stage.stageHeight >> 1;
			container.x = stage.stageWidth >> 1; 
			container.y = stage.stageHeight >> 1;
			// create a Bitmap object out of the embedded image 
			var pigTexture:Bitmap = new PigParachute(); 
			// create a Texture object to feed the Image object
			var texture:Texture = Texture.fromBitmap(pigTexture); 
			// layout the pigs 
			for ( var i:uint = 0; i< NUM_PIGS; i++) 
			{
				// create a new pig 
				var pig:Image = new Image(texture);
				// random position 
				pig.x = Math.random()*stage.stageWidth;
				pig.y = Math.random()*stage.stageHeight;
				pig.rotation = deg2rad(Math.random()*360);
				// nest the pig 
				container.addChild ( pig );
			}
			container.pivotX = stage.stageWidth >> 1; 
			container.pivotY = stage.stageHeight >> 1;
			// show the pigs 
			addChild ( container ); 
			container.flatten();
			// on each frame 
			stage.addEventListener(Event.ENTER_FRAME, onFrame); 
		}
		
		private function onFrame (e:Event):void 
		{
			// rotate the container 
			container.rotation += .1; 
		}
	}
}