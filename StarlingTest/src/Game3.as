package 
{ 
	import flash.display.Bitmap;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	public class Game3 extends Sprite 
	{ 
		private var mMovie:MovieClip; 
		[Embed(source="assets/1.xml", mimeType="application/octet-stream")]
		public static const SpriteSheetXML:Class;
		[Embed(source = "assets/1.png")] 
		private static const SpriteSheet:Class; 
		public function Game3() 
		{ 
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		private function onAdded (e:Event):void 
		{ 
			// creates the embedded bitmap (spritesheet file) 
			var bitmap:Bitmap = new SpriteSheet();
			// creates a texture out of it 
			var texture:Texture = Texture.fromBitmap(bitmap);
			// creates the XML file detailing the frames in the spritesheet
			var xml:XML = XML(new SpriteSheetXML()); 
			// creates a texture atlas (binds the spritesheet and XML description) 
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml); 
			// retrieve the frames the running boy frames
			var frames:Vector.<Texture> = sTextureAtlas.getTextures("fly_"); 
			// creates a MovieClip playing at 40fps
			mMovie = new MovieClip(frames, 21);
			// centers the MovieClip
			mMovie.x = stage.stageWidth - mMovie.width >> 1;
			mMovie.y = stage.stageHeight - mMovie.height >> 1; 
			// show it 
			addChild ( mMovie );
			
			mMovie.setFrameDuration(4, 1);
			
			Starling.juggler.add(mMovie);
		} 
	} 
}