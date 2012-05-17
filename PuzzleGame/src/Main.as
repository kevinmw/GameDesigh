package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import puzzlegame.PuzzleGame;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="760", height="600")]
	public class Main extends Sprite
	{
		private var puzzle:PuzzleGame;
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			puzzle = new PuzzleGame(this, stage.stageWidth, stage.stageHeight);
			puzzle.start();
		}
	}
}