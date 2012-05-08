package fishCatcher
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width='600', height='450', frameRate='60', backgroundColor='#333333')]

	public class Main extends Sprite
	{
		private var catcher:FishCatcher;
		
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, init );
			catcher = new FishCatcher( this, stage.stageWidth, stage.stageHeight );
			catcher.start();
		}
	}
}
