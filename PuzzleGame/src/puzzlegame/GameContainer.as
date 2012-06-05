package puzzlegame
{
	import flash.display.Stage;
	
	import puzzlegame.graphics.BlockView;
	import puzzlegame.texture.BlockTexture;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.lighting.core.Light;
	import starling.extensions.lighting.core.LightLayer;
	import starling.extensions.lighting.geometry.QuadShadowGeometry;
	
	public class GameContainer extends Sprite
	{
		private var lightLayer:LightLayer;
		
		private var mouseLight:Light;
		private var lights:Vector.<Light>;
		
		private var nativeStage:Stage;
		private var nativeStageWidth:int = 1000;
		private var nativeStageHeight:int = 1000;
		public function GameContainer()
		{
			//初始block的纹理
			BlockTexture.getInstance();
			
//			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			nativeStage = Starling.current.nativeStage;
			nativeStageWidth = nativeStage.stageWidth;
			nativeStageHeight = nativeStage.stageHeight;
			
			//create the LightLayer coverting the stage
			//this where the lights and shadows are rendered
			lightLayer = new LightLayer(nativeStageWidth, nativeStageHeight, 0x555555);
			
			//uncomment this to add a background image with random perlin noise to see how the lights might look on a texture 
			//			var bmd:BitmapData = new BitmapData(nativeStageWidth, nativeStageHeight, false, 0xffffffff);
			//			var seed:Number = Math.floor(Math.random()*100);
			//			bmd.perlinNoise(320, 240, 8, seed, true, true, 7, false, null);
			//			addChild(new Image(Texture.fromBitmapData(bmd)));
			
			createLights();
//			createGeometry();
			
			//add the lightLayer last, so it is on top of other display objects
//			addChild(lightLayer);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
		}
		
		private function createLights():void
		{
			//create a white light that will follow the mouse position
			mouseLight = new Light(0, 0, 400, 0xffeeee);
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
			var quad:Quad;
			var w:int;
			var h:int;
			
			//create an arbitrary number of quads to act as shadow geometry
			for(var i:int; i < 3; i++)
			{
				w = 50 + Math.round(Math.random() * 10);
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
				
			}
		}
		
		private function update(event:EnterFrameEvent):void
		{
			mouseLight.x = nativeStage.mouseX;
			mouseLight.y = nativeStage.mouseY;
		}
		
		public function addLigit():void
		{
			if(lightLayer==null) return;
			if(this.getChildIndex(lightLayer)!=-1)
			{
				this.removeChild(lightLayer);
			}
			this.addChild(lightLayer);
		}
	}
}