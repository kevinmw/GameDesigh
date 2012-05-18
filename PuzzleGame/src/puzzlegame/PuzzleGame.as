package puzzlegame
{
	import flash.display.Stage;
	
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.swiftsuspenders.SwiftSuspendersGame;
	import net.richardlord.ash.tick.FrameTickProvider;
	
	import org.swiftsuspenders.Injector;
	
	import puzzlegame.components.GameState;
	import puzzlegame.systems.GameManager;
	import puzzlegame.systems.RenderSystem;
	import puzzlegame.systems.SystemPriorities;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class PuzzleGame
	{
		private var game:Game;
		private var injector:Injector;
		private var tickProvider : FrameTickProvider;
		
		public function PuzzleGame(container : DisplayObject, stage : Stage)
		{
			prepare(container, stage);
		}
		
		private function prepare( container : DisplayObject, stage : Stage) : void
		{
			injector = new Injector();
			game = new SwiftSuspendersGame( injector );
			
			injector.map( Game ).toValue( game );
			injector.map( GameContainer ).toValue( container );
			injector.map( GameState ).asSingleton();
			injector.map( EntityCreator ).asSingleton();
//			injector.map( KeyPoll ).toValue( new KeyPoll( container.stage ) );
			
			game.addSystem(new GameManager(), SystemPriorities.preUpdate);
			game.addSystem(new RenderSystem(), SystemPriorities.render);
			
			tickProvider = new FrameTickProvider( stage );
			
			var gameState : GameState = injector.getInstance( GameState );
			gameState.width = stage.stageWidth;
			gameState.height = stage.stageHeight;
		}
		
		public function start():void
		{
			var gameState : GameState = injector.getInstance( GameState );
			
			gameState.level = 1;
			gameState.times = 100;
			
			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}