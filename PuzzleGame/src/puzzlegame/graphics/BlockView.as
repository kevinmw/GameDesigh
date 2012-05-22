package puzzlegame.graphics
{
	
	import puzzlegame.texture.BlockTexture;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * 方块的显示
	 * @author Kevin Ni
	 * 
	 */
	public class BlockView extends Sprite
	{
		
		public function BlockView(type:int)
		{
			refreshView(type);
		}
		
		public function refreshView(type:int):void
		{
			var image:Image = new Image(BlockTexture.getInstance().getTexture(type))
			this.addChild(image);
			image.pivotX = image.width>>1;
			image.pivotY = image.height>>1;			
		}
		
		/**
		 * 鼠标选中时的边框显示
		 * 
		 */		
		public function addFrame():void
		{
			var frame:Image = new Image(BlockTexture.getInstance().getFrame());
			this.addChild(frame);
			frame.pivotX = frame.width>>1;
			frame.pivotY = frame.height>>1;
//			var tweenObj:BlockView = this;
//			var tween:Tween = new Tween(this, 2, Transitions.EASE_IN_OUT_ELASTIC);
//			tween.scaleTo(1.05);
//			tween.onComplete = function ():void{
//				tween = new Tween(tweenObj, 2, Transitions.EASE_IN_OUT_ELASTIC);
//				tween.scaleTo(1);
//				Starling.juggler.add(tween);
//			}
//			Starling.juggler.add(tween);
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