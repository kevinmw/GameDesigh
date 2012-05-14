package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	
	import starling.core.Starling;
	
	[SWF(width="600", height="450", frameRate="60", backgroundColor="#002143")]
	public class StarlingTest extends Sprite
	{
		
		private var mStarling:Starling;
		
		public function StarlingTest()
		{
//			addChild(new Stats());
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			mStarling = new Starling(Game3, stage);
//			mStarling = new Starling(Game2, stage);
			// emulate multi-touch 
			mStarling.simulateMultitouch = true;
			mStarling.antiAliasing = 0;
			mStarling.start();
			mStarling.stage.color = 0x555555;
			trace(mStarling.enableErrorChecking);
			trace(mStarling.juggler);
		}
	}
}