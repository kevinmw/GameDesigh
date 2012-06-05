package 
{
	import flash.display.Bitmap;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.extensions.lighting.core.Light;
	import starling.extensions.lighting.core.LightLayer;
	import starling.extensions.lighting.geometry.QuadShadowGeometry;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * @author Szenia Zadvornykh
	 */
	public class StarlingLightingExample extends Sprite
	{
		private var lightLayer:LightLayer;
		
		private var mouseLight:Light;
		private var lights:Vector.<Light>;
		
		private var geometry:Vector.<DisplayObject>;
				
		private var nativeStage:Stage;
		private var nativeStageWidth:int = 1000;
		private var nativeStageHeight:int = 1000;
		
		private var mMovie:MovieClip; 
		[Embed(source="assets/1.xml", mimeType="application/octet-stream")]
		public static const SpriteSheetXML:Class;
		[Embed(source = "assets/1.png")] 
		private static const SpriteSheet:Class;
		
		public function StarlingLightingExample()
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}

		private function initialize(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			Starling.current.showStats = true;

			nativeStage = Starling.current.nativeStage;
			nativeStageWidth = nativeStage.stageWidth;
			nativeStageHeight = nativeStage.stageHeight;
			
			//create the LightLayer coverting the stage
			//this where the lights and shadows are rendered
			lightLayer = new LightLayer(nativeStageWidth, nativeStageHeight, 0x000000);
			
			//uncomment this to add a background image with random perlin noise to see how the lights might look on a texture 
//			var bmd:BitmapData = new BitmapData(nativeStageWidth, nativeStageHeight, false, 0xffffffff);
//			var seed:Number = Math.floor(Math.random()*100);
//			bmd.perlinNoise(320, 240, 8, seed, true, true, 7, false, null);
//			addChild(new Image(Texture.fromBitmapData(bmd)));
			
			createLights();
			createGeometry();
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
			
			//add the lightLayer last, so it is on top of other display objects
			addChild(lightLayer);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
			nativeStage.addEventListener(MouseEvent.CLICK, clickHandler);
		}

		private function createLights():void
		{
			//create a white light that will follow the mouse position
			mouseLight = new Light(0, 0, 400, 0xffffff);
			//add it to the light layer
			lightLayer.addLight(mouseLight);
			
			lights = new <Light>[];
			
			//uncomment this to add an arbitrary number of random lights
//			var light:Light;
//			
//			for(var i:int; i < 20; i++)
//			{
//				light = new Light(Math.random() * nativeStageWidth, Math.random() * nativeStageHeight, 200 + Math.random() * 400, Math.random() * 0xffffff, 1);
//				
//				lightLayer.addLight(light);
//				lights.push(light);
//			}
		}

		private function createGeometry():void
		{
			geometry = new <DisplayObject>[];

			var quad:Quad;
			var w:int;
			var h:int;
			
			//create an arbitrary number of quads to act as shadow geometry
			for(var i:int; i < 150; i++)
			{
				w = 10 + Math.round(Math.random() * 10);
				h = 4;
				
				quad = new Quad(w, h, Math.random() * 0xffffff);
				quad.pivotX = w / 2;
				quad.pivotY = h / 2;
				quad.x = Math.random() * nativeStageWidth;
				quad.y = Math.random() * nativeStageHeight;
				
				//this takes the bounding box of the quad to create geometry that blocks light
				//the QuadShadowGeometry class also accepts Images
				//if you want to create more complex geometry for a display object, 
				//you can make your own ShadowGeometry subclass, and override the createEdges method
				lightLayer.addShadowGeometry(new QuadShadowGeometry(quad));
				
				//add the quad to the stage
				//the quad will cast shadows even if it is not on the display list (I might change this later)
				//to remove shadow geometry assosiated with a display object, call LightLayer.removeGeometryForDisplayObject 			
				addChild(quad);
				
				geometry.push(quad);
			}
		}

		private function clickHandler(event:MouseEvent):void
		{
			var light:Light;
			light = new Light(nativeStage.mouseX, nativeStage.mouseY, 100 + Math.random() * 500, Math.random() * 0xffffff, 1);
				
			lightLayer.addLight(light);
			lights.push(light);
		}

		private function update(event:EnterFrameEvent):void
		{
			mouseLight.x = nativeStage.mouseX;
			mouseLight.y = nativeStage.mouseY;
			
			var dx:int;
			var dy:int;
			var rad:Number;
			
			//rotate the quads to face the mouse position
			for each(var g:Quad in geometry)
			{
				dx = g.x - mouseLight.x;
				dy = g.y -mouseLight.y;
				
				rad = -Math.atan2(dx, dy);
				g.rotation = rad;
			}
		}
	}
}
