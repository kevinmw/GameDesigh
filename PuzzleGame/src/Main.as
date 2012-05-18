package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import puzzlegame.GameContainer;
	import puzzlegame.PuzzleGame;
	import puzzlegame.components.GameState;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	[SWF(frameRate="60", width="760", height="600")]
	public class Main extends Sprite
	{
		private var puzzle:PuzzleGame;
		private var mStarling:Starling;
		
		public function Main()
		{
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:flash.events.Event):void
		{
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
			
			mStarling = new Starling(GameContainer, stage);
			
			mStarling.antiAliasing = 0;
			mStarling.start();
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, onCreate);
			
		}
		
		private function onCreate(e:starling.events.Event):void
		{
			puzzle = new PuzzleGame(mStarling.stage.getChildAt(0), stage);
			puzzle.start();
		}
	}
}