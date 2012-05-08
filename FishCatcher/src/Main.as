package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width='600', height='450', frameRate='60', backgroundColor='#000000')]

	public class Main extends Sprite
	{
		
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, init );
		}
	}
}
