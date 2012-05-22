package puzzlegame.texture
{
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * 方块纹理管理类
	 * TODO 后续考虑整合进统一的Assets类
	 * @author Kevin Ni
	 * 
	 */	
	public class BlockTexture
	{
		[Embed(source="assets/1.xml", mimeType="application/octet-stream")]
		public static const SpriteSheetXML:Class;
		[Embed(source="assets/1.png")]
		private static const SpriteSheet:Class;
		[Embed(source="assets/2.png")]
		private static const Frame:Class;
		
		private static var instance:BlockTexture;
		private var blockTextures:Vector.<Texture>;
		private var frameTexture:Texture;
		
		public function BlockTexture()
		{
			var bitmap:Bitmap = new SpriteSheet();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new SpriteSheetXML()); 
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml); 
			blockTextures = sTextureAtlas.getTextures("Magic_button_"); 
			
			bitmap = new Frame();
			frameTexture = Texture.fromBitmap(bitmap);
		}
		
		public function getTexture(type:int):Texture
		{
			return blockTextures[type];
		}
		
		public function getFrame():Texture
		{
			return frameTexture;
		}
		
		public static function getInstance():BlockTexture
		{
			if(!instance)
			{
				instance = new BlockTexture();
			}
			return instance;
		}
	}
}