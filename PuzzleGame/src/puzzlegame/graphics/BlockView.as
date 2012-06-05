package puzzlegame.graphics
{
	
	import flash.geom.Point;
	
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
		private var image:Image;
		//选中边框
		private var frame:Image;
		public var cols:int;
		public var rows:int;
		public var isTweening:Boolean;
		public var color:uint;
		private var _position:Point;
		
		public function BlockView(type:int, cols:int, rows:int)
		{
			this.cols = cols;
			this.rows = rows;
			this.color = type;
			this._position = new Point(cols, rows);
			refreshView(type);
		}
		
		public function refreshView(type:int):void
		{
			//TODO 需要先删除当前的Image
			image = new Image(BlockTexture.getInstance().getTexture(type))
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
			if(frame)
			{
//				trace("has frame!");
				return;
			}
			frame = new Image(BlockTexture.getInstance().getFrame());
			this.addChild(frame);
			frame.pivotX = frame.width>>1;
			frame.pivotY = frame.height>>1;
		}
		
		public function removeFrame():void
		{
			this.removeChild(frame, true);
			frame.dispose();
		}
		
		public function get currPosition():Point
		{
			return _position;
		}
		
		public function dump():String
		{
			return "[x:"+cols+",y:"+rows+",color:"+color+"]";
		}
		
		override public function dispose():void
		{
			this._position = null;
			this.image.dispose();
			this.frame.dispose();
			super.dispose();
		}
//			var tweenObj:BlockView = this;
//			var tween:Tween = new Tween(this, 2, Transitions.EASE_IN_OUT_ELASTIC);
//			tween.scaleTo(1.05);
//			tween.onComplete = function ():void{
//				tween = new Tween(tweenObj, 2, Transitions.EASE_IN_OUT_ELASTIC);
//				tween.scaleTo(1);
//				Starling.juggler.add(tween);
//			}
//			Starling.juggler.add(tween);
		
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