package puzzlegame
{
	import flash.display.DisplayObjectContainer;
	
	import puzzlegame.components.GameState;
	
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.swiftsuspenders.SwiftSuspendersGame;
	import net.richardlord.input.KeyPoll;
	
	import org.swiftsuspenders.Injector;

	public class PuzzleGame
	{
		private var game:Game;
		private var injector:Injector;
		
		public function PuzzleGame(container : DisplayObjectContainer, width : int, height : int)
		{
			prepare(container, width, height);
		}
		
		private function prepare( container : DisplayObjectContainer, width : Number, height : Number ) : void
		{
			injector = new Injector();
			game = new SwiftSuspendersGame( injector );
			
			injector.map( Game ).toValue( game );
			injector.map( DisplayObjectContainer ).toValue( container );
			injector.map( GameState ).asSingleton();
			injector.map( EntityCreator ).asSingleton();
			injector.map( KeyPoll ).toValue( new KeyPoll( container.stage ) );
			
			
			var gameState : GameState = injector.getInstance( GameState );
			gameState.width = width;
			gameState.height = height;
		}
		
		public function start():void
		{
			
		}
	}
}