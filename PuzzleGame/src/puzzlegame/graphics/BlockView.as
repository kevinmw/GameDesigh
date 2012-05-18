package puzzlegame.graphics
{
	
	import flash.display.Bitmap;
	
	import puzzlegame.texture.BlockTexture;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * 方块的显示
	 * @author Administrator
	 * 
	 */
	public class BlockView extends Sprite
	{
		private var type:int;
		
		public function BlockView(type:int)
		{
			this.type = type;
			var image:Image = new Image(BlockTexture.getInstance().getTexture(type))
			this.addChild(image);
		}
		
		/**
		 * 鼠标选中时的边框显示
		 * 
		 */		
		public function addFrame():void
		{
			var frame:Image = new Image(BlockTexture.getInstance().getFrame());
			this.addChild(frame);
			var tween:Tween = new Tween(this, 5, Transitions.EASE_IN_OUT);
			tween.animate("x", this.x + 10);
			Starling.juggler.add(tween);
		}
		
//		private function onAdded(e:Event):void
//		{
//			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
//			var bitmap:Bitmap = new SpriteSheet();
//			var texture:Texture = Texture.fromBitmap(bitmap);
//			var xml:XML = XML(new SpriteSheetXML()); 
//			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml); 
//			var frames:Vector.<Texture> = sTextureAtlas.getTextures("Magic_button_"); 
//			blockMovie = new MovieClip(frames, 30);
//			blockMovie.x = stage.stageWidth - blockMovie.width >> 1;
//			blockMovie.y = stage.stageHeight - blockMovie.height >> 1; 
//			addChild ( blockMovie );
//			
//			blockMovie.currentFrame = type;
//			blockMovie.pause();
//			
//			Starling.juggler.add(blockMovie);			
//		}
	}
}